#!/bin/bash
# vim: ts=2 shiftwidth=2 noexpandtab nowrap
set -e
set +x
do_arch=
do_apply=
do_build=
do_clean=
do_install=
do_tags=
do_upload=
use_config=
declare -a sequence_path=('--rapid')
declare -a build_kernel=()
usage() {
cat <<_EOF_
Usage: $0 -[a|b|c|i|t|u] [-h|--help]
-c: clean SCRATCH_AREA
-a: apply all patches
-b: build a kernel
-i: prepare a kernel install
-u: upload the compiled kernel to azure:/dev/shm/kernel
-t: run ctags
_EOF_
}
while test $# -gt 0
do
	case "$1" in
	-A) do_arch=$2 ; shift ;;
	-a) do_apply='do_apply' ;;
	-b) do_build='do_build' ;;
	-c) do_clean='do_clean' ;;
	-i) do_install='do_install' ;;
	-t) do_tags='do_tags' ;;
	-u) do_upload='do_upload' ;;
	-h|--help) usage ; exit 0 ;;
	*) echo "Unknown option $1" ;;
	esac
	shift
done
read native_arch < <(uname -m)
case "${do_arch}" in
x64|x86|x86_64)
	sequence_path+=('--config=x86_64-default')
	build_cmd=olh-build-x86_64-kernel
	case "${native_arch}" in
	aarch64) build_kernel+=('CC=x86_64-suse-linux-gcc-7' 'CROSS_COMPILE=') ;;
	*) ;;
	esac
;;
a64|arm64|aarch64)
	sequence_path+=('--config=arm64-default')
	build_cmd=olh-build-arm64-kernel
	case "${native_arch}" in
	x86_64) build_kernel+=('CC=aarch64-suse-linux-gcc-7' 'CROSS_COMPILE=') ;;
	*) ;;
	esac
;;
*)
	case "${native_arch}" in
	aarch64) build_cmd=olh-build-arm64-kernel ;;
	x86_64) build_cmd=olh-build-x86_64-kernel ;;
	*)
		echo "Unhandled arch '${do_arch}' on '${native_arch}'"
		exit 1
	esac
;;
esac
f_apply() {
	time scripts/sequence-patch "${sequence_path[@]}"
}
f_build() {
	pushd "$SCRATCH_AREA/current" > /dev/null
	time "${build_cmd}" "${build_kernel[@]}" > /dev/null
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
	time "${build_cmd}" modules_install "${build_kernel[@]}"
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
