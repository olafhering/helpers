#!/bin/bash
set -e
# Usage:
# $0: clone branch as is
#
. /usr/share/helpers/bin/olh-kerncvs-env
email='ohering@suse.de'
name='Olaf Hering'
smtp='relay.suse.de'
#
git_repo=kernel
git_origin=kerncvs
repo_prefix=${git_origin}
repo_base=${repo_prefix}.${git_repo}
repo_mirror=${repo_base}.git
#
for var in ${!LANG*} ${!LC_*}
do
	case "${!var}" in
		*.UTF-8)
		export ${var}="en_US.UTF-8"
		;;
		*)
		;;
	esac
done
#
pushd "${WORK_KERNEL}"
#
if test -d "${repo_mirror}"
then
	echo "${_} exists already"
	exit 0
fi
remotes=()
case "$(hostname -f)" in
*.devlab.pgu1.suse.com)
	remotes+=( "git://code-mirror/${git_repo}.git" )
;;
esac
remotes+=( "https://github.com/SUSE/${git_repo}.git" )
remotes+=( "${kerncvs_git_user}@${kerncvs_git_srv}:/srv/git/${git_repo}.git" )

time git --no-pager clone --origin "${git_origin}" "${remotes[0]}" "${repo_mirror}"
pushd "$_"
for remote in "${remotes[@]}"
do
	git --no-pager remote set-url "${git_origin}" "${remote}"
	git --no-pager fetch --tags --all
done
#
