#!/bin/bash
unset LANG
unset ${!LC_*}
. /usr/share/helpers/bin/olh-kerncvs-env
trees_tags=(
kerncvs.kernel-source.bare.mirror
kerncvs.kernel.bare.mirror
)
trees_no_tags=(
${LINUX_GIT}
)
trees_multi_remotes=(
kerncvs.kernel-source.git
kerncvs.kernel.git
)
#
do_upstream_linux="$1"
#
renice -n 11 -p "$$"
ionice --class 3 -p "$$"
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
git_gc()
{
	for l in gc.log .git/gc.log
	do
		if test -f "${l}"
		then
			head --verbose --lines=-0 "${l}"
			rm -fv "${l}"
			git gc --prune
		fi
	done
}
#
pushd "${WORK_KERNEL}" || exit 1
for repo in ${trees_tags[@]}
do
	if pushd "${repo}"
	then
		claim_lock "${PWD##*/}"
		git fetch --all --tags --prune
		git_gc
		release_lock "${PWD##*/}"
		popd
	fi
done
#
for repo in ${trees_multi_remotes[@]}
do
	if pushd "${repo}"
	then
		declare -A remotes
		for remote in $(git --no-pager remote show)
		do
			remotes[${remote}]="${remote}"
		done
		claim_lock "${PWD##*/}"
		test -n "${remotes[openSUSE]}"   && git --no-pager fetch "$_"
		test -n "${remotes[olafhering]}" && git --no-pager fetch "$_"
		test -n "${remotes[code-mirror]}" && git --no-pager fetch "$_"
		test -n "${remotes[kerncvs]}"    && git --no-pager fetch "$_" --prune --tags --prune-tags
		git_gc
		release_lock "${PWD##*/}"
		unset remotes
		popd
	fi
done
#
for repo in ${trees_no_tags[@]}
do
	if pushd "${repo}"
	then
		claim_lock "${PWD##*/}"
		git fetch --all --prune
		git_gc
		release_lock "${PWD##*/}"
		popd
	fi
done
test -n "${do_upstream_linux}" || exit 0
if pushd "${UPSTREAM_REPOS}"
then
	claim_lock "${PWD##*/}"
	git fetch --all
	echo
	echo pushing
	echo
	git push  --tags github.olafhering.linux.git torvalds.linux.git/master:master
	release_lock "${PWD##*/}"
	popd
fi
date
