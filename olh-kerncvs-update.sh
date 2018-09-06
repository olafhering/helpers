#!/bin/bash
unset LANG
unset ${!LC_*}
topdir=~/work/src/kernel
trees="
kerncvs.kernel-source.bare.mirror
kerncvs.kernel.bare.mirror
linux.git
"
pushd "${topdir}" || exit 1
for i in ${trees}
do
	if pushd $i
	then
		git fetch --all --tags --prune
		if test -f gc.log
		then
			head -n 1234 gc.log
			rm -fv gc.log
			git gc --prune
			head -n 1234 gc.log
			rm -fv gc.log
			git prune
		fi
		popd
	fi
done
if pushd upstream.linux
then
	git fetch --all
	echo
	echo pushing
	echo
	git push  --tags github.olafhering.linux.git torvalds.linux.git/master:master
	popd
fi
date
