#!/bin/bash
set -e
. /usr/share/helpers/bin/olh-kerncvs-env
pushd "${WORK_KERNEL}" > /dev/null
for branch in "${kerncvs_active_branches_base[@]}" "${kerncvs_active_branches_azure[@]}"
do
	if pushd "kerncvs.kernel-source.${branch}" > /dev/null
	then
		if git --no-pager status
		then
			if git --no-pager checkout "${branch}"
			then
				if git --no-pager pull
				then
					: all good
				fi
			fi
		fi
		popd > /dev/null
	fi
done
