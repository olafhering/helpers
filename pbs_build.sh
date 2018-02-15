#!/bin/bash
set -ex
unset LANG
unset ${!LC_*}
root=/dev/shm
api=pmbs
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
while test $# -gt 0
do
	case "$1" in
	-d|--debug|--debuginfo) dbg=--debuginfo ;;
	*.spec) spec=$1 ;;
	--*) args=( "${args[@]}" $1 ) ;;
	-t|-j|-x|-k|-p) args=( "${args[@]}" $1 $2 ) ; shift ;;
	-*) args=( "${args[@]}" $1  ) ;;
	esac
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
		repo=`pbs repos ${prj} ${pkg} | sed -n '1{s@[[:blank:]]\\+@:@p}'`
		arch=${repo##*:}
		repo=${repo%:*}
	fi
	if test -n "${repo}" && test -n "${arch}"
	then
		time \
		pbs build \
		${dbg} \
		--no-service \
		--no-verify \
		--no-checks \
		--release=`date -u +%y%m%d%H%M%S`.0 \
		"${args[@]}" \
		--root=${root}/${pkg}.${api}.${prj}.${repo}.${arch} \
		${repo} \
		${arch} \
		${spec}
	fi
fi
