#!/bin/bash
set -ex
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
export TMPDIR=/dev/shm
td=`mktemp --directory --tmpdir=/dev/shm XXX`
trap 'rm -rf "$td" ; echo " rm -rf $SCRATCH_AREA"' EXIT
sf="${td}/status.txt"
branch=
stop_before_commit=
stop_before_push=
mergetool='mergetool'
while test "$#" -gt 0
do
	case "$1" in
		-sc) stop_before_commit='stop_before_commit' ;;
		-sp) stop_before_push='stop_before_push' ;;
		SLE15-SP2) branch=$1 ;;
		SLE15-SP1) branch=$1 ;;
		SLE15) branch=$1 ;;
		SLE12-SP5) branch=$1 ;;
		SLE12-SP4) branch=$1 ;;
		SLE12-SP3) branch=$1 ; : mergetool= ;;
		*) ;;
	esac
	shift
done
test -n "${branch}"
pushd ~/work/src/kernel/
ls
olh-kerncvs-update
rm -rf kerncvs.kernel-source.${branch}-AZURE.merge
olh-kerncvs-clone_kerncvs_kernel-source -m ${branch}
pushd kerncvs.kernel-source.${branch}-AZURE.merge
case "${BASH_SOURCE[0]}" in
	*/*) . "${BASH_SOURCE[0]%/*}/olh-kerncvs-env" ;;
	*) . olh-kerncvs-env.sh ;;
esac
spr() {
	if time scripts/sequence-patch.sh --rapid > /dev/null
	then
		: spr good
		return 1
	else
		: spr fail
		return 0
	fi
}
#
git_status() {
	git --no-pager status --porcelain --untracked-files=no | tee "${sf}"
}
#
git_status_check() {
	git_status
	if test -s "${sf}"
	then
		: some changes exist
		return 0
	fi
	: no pending changes
	return 1
}
#
if git merge --no-commit kerncvs/${branch}
then
	: no conflicts after git merge
	if spr
	then
		bash
	fi
	git_status
	test -n "${stop_before_commit}" && bash
	git_status_check && git commit
else
	git_status
	if test -n "${mergetool}" && git mergetool --tool=git-sort series.conf
	then
		: no conflicts after git mergetool
	else
		git status
		bash
	fi
fi
if git_status_check
then
	git diff HEAD || :
	bash
fi
if spr
then
	bash
fi

if git_status_check
then
	test -n "${stop_before_commit}" && bash
	echo "really commit in $PWD?"
	read
	git_status_check && git commit
fi
echo "really push to kerncvs from $PWD?"
read
test -n "${stop_before_push}" && bash
git push kerncvs HEAD:users/ohering/${branch}-AZURE/for-next
popd
rm -rf kerncvs.kernel-source.${branch}-AZURE.merge
exit 0
