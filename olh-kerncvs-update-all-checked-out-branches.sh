#!/bin/bash
set -e
. /usr/share/helpers/bin/olh-kerncvs-env
pushd "${WORK_KERNEL}" > /dev/null
for branch in "${kerncvs_active_branches_base[@]}" "${kerncvs_active_branches_azure[@]}"
do
	pushd "kerncvs.kernel-source.${branch}" > /dev/null || continue
	git --no-pager status || continue
	git --no-pager checkout "${branch}" || continue
	git --no-pager pull || continue
	popd > /dev/null || continue
done
