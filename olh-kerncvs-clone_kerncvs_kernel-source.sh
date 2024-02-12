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
git_repo=kernel-source
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
	git --no-pager fetch --tags --all || : FAIL $?
done
git_config
scripts/install-git-hooks
#
