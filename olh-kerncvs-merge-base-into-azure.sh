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
branch=
mergetool='mergetool'
case "$1" in
	SLE12-SP3) branch=$1 ; : mergetool= ;;
	SLE12-SP4) branch=$1 ;;
	SLE12-SP5) branch=$1 ;;
	SLE15) branch=$1 ;;
	SLE15-SP1) branch=$1 ;;
	*) ;;
esac
test -n "${branch}"
pushd ~/work/src/kernel/
ls
olh-kerncvs-update
rm -rf kerncvs.kernel-source.${branch}-AZURE.merge
olh-kerncvs-clone_kerncvs_kernel-source -m ${branch}
pushd kerncvs.kernel-source.${branch}-AZURE.merge
. ../kerncvs.env.sh
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
if git merge --no-commit kerncvs/${branch}
then
	: no conflicts after git merge
	if spr
	then
		bash
	fi
	git --no-pager status --porcelain --untracked-files=no | tee "${td}/status.txt"
	git commit
else
	git --no-pager status --porcelain --untracked-files=no | tee "${td}/status.txt"
	if test -n "${mergetool}" && git mergetool --tool=git-sort series.conf
	then
		: no conflicts after git mergetool
	else
		git status
		bash
	fi
fi
git --no-pager status --porcelain --untracked-files=no | tee "${td}/status.txt"
if test -s "${td}/status.txt"
then
	git diff HEAD || :
	bash
fi
if spr
then
	bash
fi
git --no-pager status --porcelain --untracked-files=no | tee "${td}/status.txt"
if test -s "${td}/status.txt"
then
	echo "really commit in $PWD?"
	read
	git commit
fi
echo "really push to kerncvs from $PWD?"
read
git push kerncvs HEAD:users/ohering/${branch}-AZURE/for-next
popd
rm -rf kerncvs.kernel-source.${branch}-AZURE.merge
exit 0
