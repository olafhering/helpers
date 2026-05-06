#!/bin/bash
# vim: ts=2 shiftwidth=2 noexpandtab nowrap
set -e
set +x
bisect_exit_bad='123'
bisect_exit_skip='125'
trap "
rc=\$?
case "\${rc}" in
0) exit 0 ;;
${bisect_exit_bad}) exit 1 ;;
*) exit ${bisect_exit_skip} ;;
esac
" EXIT
#
do_apply=
do_arch=
do_bisect_run=
do_build=
do_clean=
do_install=
do_tags=
do_upload=
ssh_dir='/dev/shm/kernel'
ssh_host='azure'
ssh_user=''
use_config=
declare -a sequence_path=('--rapid')
declare -a build_kernel=()
. /usr/share/helpers/bin/olh-kerncvs-env
usage() {
cat <<_EOF_
Usage: $0 -[a|b|c|i|t|u] [-h|--help]
-c: clean SCRATCH_AREA='$SCRATCH_AREA'
-a: apply all patches
-b: build a kernel
-i: prepare a kernel install
-u: upload the compiled kernel to ${ssh_host}:${ssh_dir}
-t: run ctags
-A arch: target arch
-B: interactive, ask for 'bisect run' result
-D dir: upload kernel to this directory instead of '${ssh_dir}'
-H host: ssh host instead of '${ssh_host}'
-U user: ssh user instead of the configured default user
_EOF_
}
while test $# -gt 0
do
	case "$1" in
	-A) do_arch=$2 ; shift ;;
	-B) do_bisect_run='do_bisect_run' ;;
	-D) ssh_dir=$2 ; shift ;;
	-H) ssh_host=$2 ; shift ;;
	-U) ssh_user="$2@" ; shift ;;
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
f_bisect_run() {
	while true
	do
		read -n 1 -p "result for bisect: [G]ood -> exit 0, [B]ad -> exit 1, [S]kip -> exit 123, [X] bash ... "
		case "${REPLY}" in
		g|G) exit 0 ;;
		b|B) exit "${bisect_exit_bad}" ;;
		s|S) exit "${bisect_exit_skip}" ;;
		x|X) echo ; echo "SCRATCH_AREA='$SCRATCH_AREA'" ; bash || : $? ; echo ;;
		esac
	done
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
f_connect_check() {
	echo "Testing upload from '/Tmpfs/kernel.$$/' to '${ssh_user}${ssh_host}:${ssh_dir}'"
	ssh "${ssh_user}${ssh_host}" ls -ld "${ssh_dir%/*}"
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
	echo "Uploading from '/Tmpfs/kernel.$$/' to '${ssh_user}${ssh_host}:${ssh_dir}'"
	time rsync -a --delete /Tmpfs/kernel.$$/ "${ssh_user}${ssh_host}:${ssh_dir}"
}
git --no-pager log --oneline -1
test -n "${do_upload}" && f_connect_check
test -n "${do_clean}" && f_clean
test -n "${do_apply}" && f_apply
test -n "${do_tags}" && f_tags
test -n "${do_build}" && f_build
test -n "${do_install}" && f_install
test -n "${do_upload}" && f_upload
test -n "${do_bisect_run}" && f_bisect_run
exit 0
