#!/bin/bash
set -e
# Usage:
# $0 <branch>: clone branch as is
# $0 -m <branch>: clone branch as is, add remotes for the following branches:
#     branch_EMBARGO
#     branch-GA
#     branch-UPDATE
#     branch-LTSS
#     branch-LTSS_EMBARGO
#     branch-AZURE
#     branch-AZURE_EMBARGO
#     unmerged user branches 
#
. /usr/share/helpers/bin/olh-kerncvs-env
trap 'pwd' EXIT
azure_branches="
SLE15-SP6
SLE15-SP5
SLE12-SP5
"
email='ohering@suse.de'
name='Olaf Hering'
smtp='relay.suse.de'
#
git_repo=kernel-source
git_origin=kerncvs
repo_prefix=${git_origin}
repo_base=${repo_prefix}.${git_repo}
repo_mirror=${repo_base}.bare.mirror
#
do_clone=
do_merge=
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
	-m) do_merge=do_merge ;;
	-c) do_clone=do_clone ;;
	*)
	test -z "${branch}" && branch="$1"
	test -n "${do_merge}" && break
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
		git --no-pager fetch --tags --all
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
git_config() {
	git config user.email "${email}"
	git config user.name "${name}"
	git config sendemail.from "${name} <${email}>"
	git config sendemail.envelopesender "${email}"
	git config sendemail.chainreplyto 'false'
	git config sendemail.ccover 'yes'
	git config sendemail.smtpencryption 'tls'
	git config sendemail.smtpdomain 'sender'
	git config sendemail.smtppass ''
	git config sendemail.smtpAuth ''
	git config sendemail.smtpserver "${smtp}"
	git config sendemail.smtpuser ''
	git config sendemail.confirm 'always'
	git config sendemail.assume8bitEncoding 'yes'
	git config sendemail.transferEncoding '8bit'
	git config merge.tool 'git-sort'
	git config mergetool.git-sort.cmd 'scripts/git_sort/merge_tool.py $LOCAL $BASE $REMOTE $MERGED'
	git config mergetool.git-sort.trustExitCode 'true'
}
#
case "${branch}" in
	SLE15-SP6-AZURE) clone_branch='SLE15-SP6-AZURE';;
	SLE15-SP6)       clone_branch='SLE15-SP6'      ;;
	SLE15-SP5-AZURE) clone_branch='SLE15-SP5-AZURE';;
	SLE15-SP5)       clone_branch='SLE15-SP5'      ;;
	SLE15-SP4-LTSS)  clone_branch='SLE15-SP4-LTSS' ;;
	SLE15-SP4)       clone_branch='SLE15-SP4-LTSS' ;;
	SLE15-SP3-LTSS)  clone_branch='SLE15-SP3-LTSS' ;;
	SLE15-SP3)       clone_branch='SLE15-SP3-LTSS' ;;
	SLE15-SP2-LTSS)  clone_branch='SLE15-SP2-LTSS' ;;
	SLE15-SP2)       clone_branch='SLE15-SP2-LTSS' ;;
	SLE15-SP1-LTSS)  clone_branch='SLE15-SP1-LTSS' ;;
	SLE15-SP1)       clone_branch='SLE15-SP1-LTSS' ;;
	SLE15-LTSS)      clone_branch='SLE15-LTSS'     ;;
	SLE15)           clone_branch='SLE15-LTSS'     ;;
	SLE12-SP5-AZURE) clone_branch='SLE12-SP5-AZURE';;
	SLE12-SP5)       clone_branch='SLE12-SP5'      ;;
	SLE12-SP4-LTSS)  clone_branch='SLE12-SP4-LTSS' ;;
	SLE12-SP4)       clone_branch='SLE12-SP4-LTSS' ;;
	SLE12-SP3-TD)    clone_branch='SLE12-SP3-TD'   ;;
	SLE12-SP3-LTSS)  clone_branch='SLE12-SP3-LTSS' ;;
	SLE12-SP3)       clone_branch='SLE12-SP3-LTSS' ;;
	SLE12-SP2-LTSS)  clone_branch='SLE12-SP2-LTSS' ;;
	SLE12-SP2)       clone_branch='SLE12-SP2-LTSS' ;;
	SLE12-SP1-LTSS)  clone_branch='SLE12-SP1-LTSS' ;;
	SLE12-SP1)       clone_branch='SLE12-SP1-LTSS' ;;
	SLE11-SP4-LTSS)  clone_branch='SLE11-SP4-LTSS' ;;
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
			git_config
			scripts/install-git-hooks
			if test "${clone_branch}" != 'scripts'
			then
				for i in 'scripts'
				do
					git --no-pager \
						config \
						--add \
						remote.${git_origin}.fetch \
						"+refs/heads/${i}:refs/remotes/${git_origin}/${i}"
				done
			fi
			git fetch --all
		popd
fi
#
if test -n "${do_merge}"
then
	echo "branch ${branch}"
	merge_clone_branch=
	for i in ${azure_branches}
	do
		test "${i}" = "${branch}" || continue
		merge_clone_branch="${branch}-AZURE"
	done
	test -z "${merge_clone_branch}" && merge_clone_branch="${clone_branch}"
	candidates=()
	unmerged=()
	if pushd ${repo_mirror}
	then
		candidates=( `git --no-pager branch | xargs -n1 | grep -E "(^|/)${branch}(|-GA|-UPDATE|_EMBARGO|-LTSS|-LTSS_EMBARGO|-AZURE|-AZURE_EMBARGO)($|/)"` )
		for candidate in ${candidates[@]}
		do
			if [[ "${candidate}" =~ ^${branch} ]]
			then
				unmerged+=("${candidate}")
			else
				if git --no-pager merge-base --is-ancestor "${candidate}" "${clone_branch}"
				then
					: "${candidate} already merged into ${clone_branch}"
				else
					unmerged+=("${candidate}")
				fi
			fi
		done
		popd
	fi
	echo "${#unmerged[@]} out of ${#candidates[@]} branches already merged into ${clone_branch}"
	: unmerged "${unmerged[@]}"
	repo=${repo_base}.${merge_clone_branch}.merge
	if test -e "${repo}"
	then
		echo keeping existing ${repo}
	else
		git \
			clone \
			--single-branch \
			--origin ${git_origin} \
			--branch ${merge_clone_branch} \
			--reference ${repo_mirror} \
			${kerncvs_git_user}@${kerncvs_git_srv}:/srv/git/${git_repo}.git \
			${repo}
		if pushd "${repo}"
		then
			git_config
			scripts/install-git-hooks
			popd
		fi
	fi
	if pushd "${repo}"
	then
		for i in ${unmerged[@]}
		do
			git --no-pager \
				config \
				--add \
				remote.${git_origin}.fetch \
				"+refs/heads/${i}:refs/remotes/${git_origin}/${i}"
		done
		git fetch --all --prune
		popd
	fi
fi
