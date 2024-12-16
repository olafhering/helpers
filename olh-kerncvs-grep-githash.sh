#!/bin/bash
set -e
renice -n 11 -p "$$"
ionice --class 3 -p "$$"
. /usr/share/helpers/bin/olh-kerncvs-env
export TZ=UTC
unset LANG
unset ${!LC_*}
pushd "${WORK_KERNEL}/kerncvs.kernel-source.bare.mirror"
for string in "$@"
do
	pushd "${LINUX_GIT}"
	echo -n "${string} "
	git --no-pager describe --contains "${string}" || :
	popd
	for branch in ${kerncvs_active_branches_base[@]}
	do
		git --no-pager grep "${string}" "${branch}" || :
	done
done
