#!/bin/bash
set -x
set -e
unset LANG
unset ${!LC_*}
t=`mktemp --directory --tmpdir=/dev/shm XXX`
trap "rm -rf ${t}" EXIT
#
remote=github_olafhering
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
git rebase -i "${new_base}"
git push "${remote}" "${base_branch}"
git checkout "${fix_branch}"
git rebase -i "${base_branch}"
rm -rf $$
git format-patch -ko $$ "${base_branch}".."${fix_branch}"
git reset --hard "${base_branch}"
for i in $$/*.patch
do
  test -f "${i}" && olh-git-apply . < "${i}"
done
git push --force "${remote}" "${fix_branch}"
