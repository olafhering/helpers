#!/bin/bash
set -ex
unset LANG
unset ${!LC_*}
declare -a args
declare -a arg_root
root=/Tmpfs
apiurl=
api=
dbg=--disable-debuginfo
prj=
pkg=
repo=$1
arch=$2
spec=
checks_args=--no-checks
vm_type=
if test $# -gt 1
then
	shift 2
fi
while test $# -gt 0
do
	: $1
	case "$1" in
	-d|--debug|--debuginfo) dbg=--debuginfo ;;
	--checks) checks_args=$1 ;;
	--no-checks) checks_args=$1 ;;
	*.spec) spec=$1 ;;
	--alternative-project|-t|-j|-x|-k|-p|-M) args+=( "$1" "$2" ) ; shift ;;
	--root) arg_root=('--root' "$2") ; shift ;;
	--root*) arg_root=("$1") ;;
	--vm-type=*) vm_type=${1##*=} ;;
	--vm-type) vm_type=$2 ; shift ;;
	--*) args+=( "$1" ) ;;
	-*) args+=( "$1" ) ;;
	esac
	shift
done
args+=( "${checks_args}" )
#
test -z "${apiurl}" && test -f '.osc/_apiurl' && read apiurl < "$_"
test -z "${apiurl}" && test -f '../.osc/_apiurl' && read apiurl < "$_"
case "${apiurl}" in
*//api.opensuse.org) api=obs ;;
*//api.suse.com)     api=sbs ;;
*//api.suse.de)      api=ibs ;;
*//pmbs-api.links2linux.org) api=pbs ;;
*) echo >&2 "Unknown _apiurl '${apiurl}'" ; exit 1 ;;
esac
#
if test -f .osc/_project && test -f .osc/_package
then
	read prj < .osc/_project
	read pkg < .osc/_package
elif test -f ../.osc/_project && test -f .git
then
	read prj < ../.osc/_project
	pkg=${PWD##*/}
fi
if test -n "${prj}" && test -n "${pkg}"
then
	if test -z "${repo}"
	then
		repo=`obs repos ${prj} ${pkg} | sed -n '1{s@[[:blank:]]\\+@:@p}'`
		arch=${repo##*:}
		repo=${repo%:*}
	fi
	if test -n "${arg_root[*]}"
	then
		args+=("${arg_root[@]}")
	else
		case "${vm_type}" in
		chroot) args+=('--vm-type' "${vm_type}") ; root_suffix= ;;
		kvm)    args+=('--vm-type' "${vm_type}") ; root_suffix='.k' ;;
		qemu)   args+=('--vm-type' "${vm_type}") ; root_suffix='.q' ;;
		*) ;;
		esac
		case "${arch}" in
		aarch64) root_arch=a64 ;;
		x86_64) root_arch=x64 ;;
		*) root_arch=${arch} ;;
		esac
		case "${repo}" in
		openSUSE_Factory) root_repo=F ;;
		openSUSE_Leap_*) root_repo=${repo##*_} ;;
		openSUSE_Tumbleweed) root_repo=TW ;;
		*) root_repo=${repo} ;;
		esac
		root_dir="${root}/${pkg}.${api}.${prj}.${root_repo}.${root_arch}${root_suffix}"
		args+=("--root" "${root_dir}")
		: length of root_dir: ${#root_dir}
	fi
	if test -n "${repo}" && test -n "${arch}"
	then
		time \
		osc build \
		${dbg} \
		--no-service \
		--no-verify \
		--release=`date -u +%y%m%d%H%M%S`.0 \
		"${args[@]}" \
		${repo} \
		${arch} \
		${spec}
	fi
fi
