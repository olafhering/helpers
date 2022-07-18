#!/bin/bash
set -e
unset LANG
unset ${!LC_*}
read td < <(mktemp --directory --tmpdir=/dev/shm .XXX)
trap "rm -rf '${td}'" EXIT
export TMPDIR="${td}"
updates_suse_com_dir=$1
kernel_source_git_dir=$2
list_kernel_binaries="${td}/list_kernel_binaries"
list_git_revision_kernel_binary="${td}/list_git_revision_kernel_binary"
pushd "${updates_suse_com_dir}" > /dev/null
popd > /dev/null
pushd "${kernel_source_git_dir}" > /dev/null
popd > /dev/null
#
find "${updates_suse_com_dir}" -xdev -name 'kernel-azure-?.*.x86_64.rpm' > "${list_kernel_binaries}"
#
while read
do
	read rev < <(rpm -qpi "${REPLY}" | awk '/^GIT Revision:/{print $3}')
	echo "${rev} ${REPLY}" >> "${list_git_revision_kernel_binary}"
done < <(sort "${list_kernel_binaries}")
#
pushd "${kernel_source_git_dir}" > /dev/null
#
while read rev filename
do
	read < <(git --no-pager log --oneline -n1 "${rev}^!")
	case "${REPLY}" in
	*tag:*) ;;
	*)
		echo "${rev} ${filename}"
		echo "${REPLY}"
	;;
	esac
done < "${list_git_revision_kernel_binary}"
