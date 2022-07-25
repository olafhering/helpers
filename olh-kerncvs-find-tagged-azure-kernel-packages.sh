#!/bin/bash
set -e
unset LANG
unset ${!LC_*}
read td < <(mktemp --directory --tmpdir=/dev/shm .XXX)
trap "rm -rf '${td}'" EXIT
export TMPDIR="${td}"
declare -a tags
declare -a top_dirs
declare -a rpm_dirs
top_dirs=(
SUSE/Products/SLE-Module-Development-Tools-OBS
SUSE/Products/SLE-Module-Public-Cloud
SUSE/Updates/SLE-Module-Development-Tools-OBS
SUSE/Updates/SLE-Module-Public-Cloud
SUSE/Updates/SLE-SERVER
)
updates_suse_com_dir=$1
kernel_source_git_dir=$2
list_kernel_binaries="${td}/list_kernel_binaries"
list_git_revision_kernel_binary="${td}/list_git_revision_kernel_binary"
pushd "${kernel_source_git_dir}" > /dev/null
popd > /dev/null
pushd "${updates_suse_com_dir}" > /dev/null
for i in ${top_dirs[@]}
do
	rpm_dirs+=( $(ls -1d "${i}"/{12-SP5,15*}/*/product/{aarch64,x86_64} "${i}"/{12-SP5,15*}/*/update/{aarch64,x86_64} 2>/dev/null || :) )
done
#
echo "Searching in ${#rpm_dirs[@]} directories ..."
find "${rpm_dirs[@]}" -xdev -name 'kernel-azure-?.*64.rpm' -exec /usr/bin/readlink -f '{}' + > "${list_kernel_binaries}"
wc -l "${list_kernel_binaries}"
popd > /dev/null
#
while read
do
	read rev < <(rpm -qpi "${REPLY}" | awk '/^GIT Revision:/{print $3}')
	echo "${rev} ${REPLY}" >> "${list_git_revision_kernel_binary}"
done < <(sort "${list_kernel_binaries}")
wc -l "${list_git_revision_kernel_binary}"
#
pushd "${kernel_source_git_dir}" > /dev/null
#
while read rev filename
do
	tags=( $(git --no-pager tag --points-at "${rev}") )
	if test ${#tags[@]} -eq 0
	then
		echo "${rev} ${filename}"
		echo "${REPLY}"
	fi
done < "${list_git_revision_kernel_binary}"
