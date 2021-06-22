#!/bin/bash
#et -x
set -e
unset LANG
unset ${!LC*}
rev="$1"
reference="$2"
test -n "${rev}"
td="`mktemp --directory --tmpdir=/dev/shm .XXX`"
t="${td}/.t"
trap "rm -rf '${td}'" EXIT

test -z "${LINUX_GIT}" && LINUX_GIT=~/work/src/kernel/LINUX_GIT
g="git --no-pager --git-dir=${LINUX_GIT}/.git"
read rev < <(${g} 'rev-list' -n1 "${rev}") 
: rev ${rev}
${g} 'format-patch' \
	--no-signature \
	--break-rewrites=100%/100% \
	--no-renames \
	--keep-subject \
	--quiet \
	--output-directory "${td}" "${rev}^!"
read patch_file < <(echo ${td}/*.patch)
: patch_file ${patch_file}
read mainline < <(${g} 'describe' '--contains' "${rev}" || echo)
mainline="${mainline%%~*}"
: mainline ${mainline}
patch_name="${patch_file##*/}"
patch_name="${patch_name#*-}"
patch="${td}/${patch_name}"
sed -n '
/^From /d
p
/^$/Q
' < "${patch_file}" > "${t}"
#
grep -E '^From:[[:blank:]]' < "${patch_file}" >> "${patch}"
grep -E '^Date:[[:blank:]]' < "${patch_file}" >> "${patch}"
echo "Patch-mainline: ${mainline}" >> "${patch}"
grep -E '^Subject:[[:blank:]]' < "${patch_file}" >> "${patch}"
echo "Git-commit: ${rev}" >> "${patch}"
test -n "${reference}" && echo "References: ${reference}" >> "${patch}"
#
sed -n '
: header
/^$/ b body
n
b header
: body
p
n
/^---$/q
b body
' < "${patch_file}" >> "${patch}"
echo "Acked-by: Olaf Hering <ohering@suse.de>" >> "${patch}"
sed -n '
: marker
/^---$/b patch
n
b marker
: patch
p
: rest
n
/^index /b rest
p
b rest
' < "${patch_file}" >> "${patch}"
mv -vit 'patches.suse' "${patch}"
