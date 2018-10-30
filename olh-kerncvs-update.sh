#!/bin/bash
unset LANG
unset ${!LC_*}
topdir=~/work/src/kernel
trees="
kerncvs.kernel-source.bare.mirror
kerncvs.kernel.bare.mirror
linux.git
"
#
user="$(id -u)"
test -n "${user}" || exit 1
LOCK_BASEDIR="/dev/shm/.${user}.${0##*/}"
_lockfile=
_setlockfd()
{
	local i
	for ((i = 0; i < ${#_lockdict}; i++))
		do [ -z "${_lockdict[$i]}" -o "${_lockdict[$i]}" = "$1" ] && break
	done
	_lockdict[$i]="$1"
	let _lockfd=200+i
	_lockfile="$LOCK_BASEDIR/$1"
}

claim_lock()
{
	mkdir -vp "$LOCK_BASEDIR"
	_setlockfd $1
	while true; do
		eval "exec $_lockfd<>$_lockfile"
		flock -x $_lockfd || return $?
		_fd_inum=`stat -L -c '%i' /proc/self/fd/$_lockfd`
		_file_inum=`sh -c "stat -c '%i' $_lockfile || true"`
		if [ x$_fd_inum = x$_file_inum ]; then break; fi
		eval "exec $_lockfd<&-"
	done
}

release_lock()
{
    _setlockfd $1
    rm "$_lockfile"
}
#
pushd "${topdir}" || exit 1
for i in ${trees}
do
	if pushd "$i"
	then
		claim_lock "$i"
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
		release_lock "$i"
		popd
	fi
done
i='upstream.linux'
if pushd "$i"
then
	claim_lock "$i"
	git fetch --all
	echo
	echo pushing
	echo
	git push  --tags github.olafhering.linux.git torvalds.linux.git/master:master
	release_lock "$i"
	popd
fi
date
