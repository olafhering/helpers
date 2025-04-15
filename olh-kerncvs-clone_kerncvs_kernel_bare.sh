#!/bin/bash
set -e
# Usage:
# $0 <branch>: clone branch as is
# $0 -c: create initial clone
#
. /usr/share/helpers/bin/olh-kerncvs-env
trap 'pwd' EXIT
email='ohering@suse.de'
name='Olaf Hering'
smtp='relay.suse.de'
#
git_repo=kernel
git_origin=kerncvs
repo_prefix=${git_origin}
repo_base=${repo_prefix}.${git_repo}
repo_mirror=${repo_base}.bare.mirror
#
do_clone=
branch=
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
until test "$#" -eq 0
do
	case "$1" in
	-c) do_clone=do_clone ;;
	*)
	test -z "${branch}" && branch="$1"
	;;
	esac
	shift
done
#
pushd "${WORK_KERNEL}"
if test -n "${do_clone}"
then
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

	time git --no-pager clone --mirror "${remotes[0]}" "${repo_mirror}"
	pushd "$_"
	for remote in "${remotes[@]}"
	do
		git --no-pager remote set-url 'origin' "${remote}"
		git --no-pager fetch --tags --all || : ignore failures
	done
	# fatal: options '--bare' and '--origin something' cannot be used together
	git --no-pager remote rename 'origin' "${git_origin}"
	exit 0
fi
#
if ! test -d "${repo_mirror}"
then
	echo "${repo_mirror} does not exist yet."
	exit 1
fi
#
: branch ${branch}
if test -z "${branch}"
then
	echo "A branch name is required"
	exit 1
fi
#
case "${branch}" in
	SL-16.0)         clone_branch='SL-16.0'        ;;
	SLE15-SP7)       clone_branch='SLE15-SP7'      ;;
	SLE15-SP7-AZURE) clone_branch='SLE15-SP7-AZURE';;
	SLE15-SP6)       clone_branch='SLE15-SP6'      ;;
	SLE15-SP6-AZURE) clone_branch='SLE15-SP6-AZURE';;
	SLE15-SP5)       clone_branch='SLE15-SP5-LTSS' ;;
	SLE15-SP4)       clone_branch='SLE15-SP4-LTSS' ;;
	SLE15-SP3)       clone_branch='SLE15-SP3-LTSS' ;;
	SLE15-SP2)       clone_branch='SLE15-SP2-LTSS' ;;
	SLE15-SP1)       clone_branch='SLE15-SP1-LTSS' ;;
	SLE15)           clone_branch='SLE15-LTSS'     ;;
	SLE12-SP5)       clone_branch='SLE12-SP5'      ;;
	SLE12-SP4)       clone_branch='SLE12-SP4-LTSS' ;;
	SLE12-SP3)       clone_branch='SLE12-SP3-LTSS' ;;
	SLE12-SP2)       clone_branch='SLE12-SP2-LTSS' ;;
	SLE12-SP1)       clone_branch='SLE12-SP1-LTSS' ;;
	SLE11-SP4)       clone_branch='SLE11-SP4-LTSS' ;;
	linux-4.12)      clone_branch='fixes/linux-4.12' ;;
	master)          clone_branch='master'         ;;
	packaging)       clone_branch='packaging'      ;;
	scripts)         clone_branch='scripts'        ;;
	*) echo "branch '${branch}' unknown by ${0##*/}" ; exit 1 ;;
esac
#
repo=${repo_base}.${clone_branch//\//_}
if test -e "${repo}"
then
	echo keeping existing ${repo}
else
	git \
		clone \
		--single-branch \
		--no-tags \
		--origin ${git_origin} \
		--branch ${clone_branch} \
		--reference ${repo_mirror} \
		${kerncvs_git_user}@${kerncvs_git_srv}:/srv/git/${git_repo}.git \
		${repo}
		pushd "${repo}"
			git fetch --all
		popd
fi
#
