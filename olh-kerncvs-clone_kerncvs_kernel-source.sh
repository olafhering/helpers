#!/bin/bash
set -e
trap 'pwd' EXIT
branches="
SLE12-SP5
SLE15-SP1
"
azure_branches="
SLE12-SP3
SLE12-SP4
SLE12-SP5
SLE15
SLE15-SP1
"
email='ohering@suse.de'
name='Olaf Hering'
smtp='relay.suse.de'
_merge_branches=
_branches=
_azure_branches=
do_merge=
cmdline_branches=
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
until test "$#" -eq 0
do
	case "$1" in
	-m) do_merge=do_merge ;;
	*) cmdline_branches="${cmdline_branches} $1"
	esac
	shift
done
git_srv=kerncvs.suse.de
git_user=ohering
git_repo=kernel-source
git_origin=kerncvs
repo_prefix=${git_origin}
repo_base=${repo_prefix}.${git_repo}
repo_mirror=${repo_base}.bare.mirror
repo_mirror_dot_git=
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
pushd ~/work/src/kernel
#
: repo_mirror ${repo_mirror}
if test -d ${repo_mirror}
then
	: reusing existing ${repo_mirror}
else
	time git \
		clone \
		--mirror \
		git://${git_srv}/${git_repo}.git \
		${repo_mirror}
fi
repo_mirror_dot_git="`readlink -f ${repo_mirror}`"
#
: cmdline_branches ${cmdline_branches}
if test -n "${cmdline_branches}"
then
	if test -n "${do_merge}"
	then
		# $0 -m branch
		_azure_branches=${cmdline_branches}
		_branches=
	else
		# $0 branch
		_azure_branches=
		_branches=${cmdline_branches}
	fi
else
	_azure_branches=${azure_branches}
	if test -n "${do_merge}"
	then
		# $0 -m
		_branches=
	else
		# $0
		_branches=${branches}
	fi
fi
#
if test -n "${do_merge}"
then
	for branch in ${_azure_branches}
	do
		_merge_branches="${_merge_branches} ${branch}-AZURE"
	done
else
	for branch in ${_azure_branches}
	do
		_branches="${_branches} ${branch} ${branch}-AZURE"
	done
fi
#
for branch in ${_branches}
do
	repo=${repo_base}.${branch}
	if test -e "${repo}"
	then
		echo keeping existing ${repo}
	else
		git \
			clone \
			--single-branch \
			--no-tags \
			--origin ${git_origin} \
			--branch ${branch} \
			--reference ${repo_mirror} \
			${git_user}@${git_srv}:/home/git/${git_repo}.git \
			${repo}
			pushd "${repo}"
				git_config
				scripts/install-git-hooks
				for i in 'scripts'
				do
					git --no-pager \
						config \
						--add \
						remote.${git_origin}.fetch \
						"+refs/heads/${i}:refs/remotes/${git_origin}/${i}"
				done
				git fetch --all
			popd
	fi
	: next
done
#
if test -n "${do_merge}"
then
	echo "branch ${branch}"
	for _branch in ${_merge_branches}
	do
		candidates=()
		unmerged=()
		if pushd ${repo_mirror}
		then
			candidates=( `git --no-pager branch | xargs -n1 | grep -E "(^|/)${branch}(|-UPDATE|_EMBARGO|-AZURE|-AZURE_EMBARGO)($|/)"` )
			for candidate in ${candidates[@]}
			do
				if git --no-pager merge-base --is-ancestor "${candidate}" "${_branch}"
				then
					: "${candidate} already merged into ${_branch}"
				else
					unmerged+=("${candidate}")
				fi
			done
			popd
		fi
		echo "${#unmerged[@]} out of ${#candidates[@]} branches already merged into ${_branch}"
		: unmerged "${unmerged[@]}"
		repo=${repo_base}.${_branch}.merge
		if test -e "${repo}"
		then
			echo keeping existing ${repo}
		else
			git \
				clone \
				--single-branch \
				--origin ${git_origin} \
				--branch ${_branch} \
				--reference ${repo_mirror} \
				${git_user}@${git_srv}:/home/git/${git_repo}.git \
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
		: next
	done
fi
