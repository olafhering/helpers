#!/bin/bash
set -e
unset LANG
unset ${!LC_*}
obs=~/work/obs/devel:languages:ocaml
ibs=~/work/ibs/home:olh:obs:devel:languages:ocaml
pushd "${obs}" > /dev/null
read td < <(mktemp --directory --tmpdir=/Tmpfs .XXX)
trap "rm -rf '${td}'" EXIT
t="${td}/.t"
export TMPDIR="${td}"
>> "${t}"
fn() {
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
}
for git in */*/.git
do
	if pushd $git > /dev/null
	then
		cd ..
		fn
		popd > /dev/null
	fi
done
popd > /dev/null
#
pushd "${ibs}" > /dev/null
for git in */*/.git
do
	if pushd $git > /dev/null
	then
		cd ..
		pkg=${PWD%/*}
		pkg=${pkg##*/}
		if test -d "${obs}/${pkg}"
		then
			:
		else
			fn
		fi
		popd > /dev/null
	fi
done
popd > /dev/null
