#!/bin/bash
set -ex
unset LANG
unset ${!LC_*}
declare -a args
root=/dev/shm
api=sbs
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
	: $1
	case "$1" in
	-d|--debug|--debuginfo) dbg=--debuginfo ;;
	*.spec) spec=$1 ;;
	--alternative-project|-t|-j|-x|-k|-p|-M) args+=( "$1" "$2" ) ; shift ;;
	--*) args+=( "$1" ) ;;
	-*) args+=( "$1" ) ;;
	esac
	shift
done
if test -f .osc/_apiurl && test -f .osc/_project && test -f .osc/_package
then
	read apiurl  < .osc/_apiurl
	read prj < .osc/_project
	read pkg < .osc/_package
elif test -f ../.osc/_apiurl && test -f ../.osc/_project && test -d .git
	read apiurl  < ../.osc/_apiurl
	read prj < ../.osc/_project
	pkg=${PWD##*/}
fi
if test -n "${prj}" && test -n "${pkg}"
then
	if test -z "${repo}"
	then
		repo=`sbs repos ${prj} ${pkg} | sed -n '1{s@[[:blank:]]\\+@:@p}'`
		arch=${repo##*:}
		repo=${repo%:*}
	fi
	if test -n "${repo}" && test -n "${arch}"
	then
		time \
		sbs build \
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
