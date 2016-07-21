#!/bin/bash
set -ex
unset LANG
unset ${!LC_*}
root=/dev/shm
api=ibs
dbg=--disable-debuginfo
prj=
pkg=
repo=$1
arch=$2
spec=
if test $# -gt 1
then
	shift 2
fi
case "$1" in
	*.spec) spec=$1 ; shift ;;
esac
while test $# -gt 0
do
	case "$1" in
	-d|--debug) dbg= ;;
	esac
	args=( "${args[@]}" $1 )
	shift
done
if test -e .osc/_project
then
	read prj < .osc/_project
fi
if test -e .osc/_package
then
	read pkg < .osc/_package
fi
if test -n "${prj}" && test -n "${pkg}"
then
	if test -z "${repo}"
	then
		repo=`ibs repos ${prj} ${pkg} | sed -n '1{s@[[:blank:]]\\+@:@p}'`
		arch=${repo##*:}
		repo=${repo%:*}
	fi
	if test -n "${repo}" && test -n "${arch}"
	then
		time \
		ibs build \
		--disable-cpio-bulk-download \
		${dbg} \
		--no-service \
		--no-verify \
		--no-checks \
		--release=`date -u +%y%m%d%H%M%S`.0 \
		"${args[@]}" \
		--root=${root}/${pkg}.${api}.${prj}.${repo}.${arch} \
		${repo} \
		${arch}
		${spec}
	fi
fi
