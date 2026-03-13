#!/bin/bash
# vim: ts=2 shiftwidth=2 noexpandtab nowrap
set -e
set +x
do_apply=
do_build=
do_clean=
do_install=
do_tags=
do_upload=
use_config=
declare -a sequence_path=('--rapid')
declare -a build_kernel=()
while test $# -gt 0
do
	case "$1" in
	-a) do_apply='do_apply' ;;
	-b) do_build='do_build' ;;
	-c) do_clean='do_clean' ;;
	-i) do_install='do_install' ;;
	-t) do_tags='do_tags' ;;
	-u) do_upload='do_upload' ;;
	*) echo "Unknown option $1" ;;
	esac
	shift
done
f_apply() {
	time scripts/sequence-patch "${sequence_path[@]}"
}
f_build() {
	pushd "$SCRATCH_AREA/current" > /dev/null
	time olh-build-x86_64-kernel "${build_kernel[@]}" > /dev/null
	popd > /dev/null
}
f_clean() {
	if rm -rf "$SCRATCH_AREA"
	then
		:
	else
		sleep 1
		rm -rf "$SCRATCH_AREA"
	fi
}
f_install() {
	pushd "$SCRATCH_AREA/current" > /dev/null
	time olh-build-x86_64-kernel modules_install "${build_kernel[@]}"
	popd > /dev/null
}
f_tags() {
	pushd "$SCRATCH_AREA/current" > /dev/null
	bash -c 'exec make tags &>/dev/null & '
	popd > /dev/null
}
f_upload() {
	time rsync -a --delete /Tmpfs/kernel.$$/ azure:/dev/shm/kernel
}
git --no-pager log --oneline -1
. /usr/share/helpers/bin/olh-kerncvs-env
test -n "${do_clean}" && f_clean
test -n "${do_apply}" && f_apply
test -n "${do_tags}" && f_tags
test -n "${do_build}" && f_build
test -n "${do_install}" && f_install
test -n "${do_upload}" && f_upload
exit 0
