#!/bin/bash
set -e
unset LANG
unset ${!LC_*}
pushd ~/work/obs/devel:languages:ocaml > /dev/null
read td < <(mktemp --directory --tmpdir=/dev/shm .XXX)
trap "rm -rf '${td}'" EXIT
t="${td}/.t"
export TMPDIR="${td}"
for git in */*/.git
do
	if pushd $git > /dev/null
	then
		cd ..
		if git --no-pager fetch --all --tags --prune --force &> "${t}"
		then
			for remote in $(git --no-pager remote show)
			do
				sed -i "/ ${remote}$/d" "${t}"
			done
			if test -s "${t}"
			then
				cat "${t}"
			fi
		else
			echo "ERROR: ${PWD##*/}"
			cat "${t}"
		fi	
		popd > /dev/null
	fi
done
