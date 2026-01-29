#!/bin/bash
set -x
set -e
unset LANG
unset ${!LC_*}
t=`mktemp --directory --tmpdir=/Tmpfs XXX`
trap "rm -rf ${t}" EXIT
#
remote=github_olafhering
interactive_flag='-i'
if test "$1" = '-ni'
then
	interactive_flag=
	shift
fi
#
base_branch=$1
fix_branch=$2
new_base=$3
#
test -n "${base_branch}"
test -n "${fix_branch}"
test -n "${new_base}"

git status
git remote show
git --no-pager log --oneline -n1 "${new_base}"
git checkout "${fix_branch}"
git checkout "${base_branch}"
git rebase ${interactive_flag} "${new_base}"
git push "${remote}" "${base_branch}"
git checkout "${fix_branch}"
git rebase ${interactive_flag} "${base_branch}"
rm -rf $$
git format-patch \
	--unified=12 \
	--base="${base_branch}" \
	-ko $$ "${base_branch}".."${fix_branch}"
git reset --hard "${base_branch}"
for i in $$/*.patch
do
  test -f "${i}" && olh-git-apply . < "${i}"
done
git push --force "${remote}" "${fix_branch}"
