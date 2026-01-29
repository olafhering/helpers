#!/bin/bash
set -ex
unset LANG
unset ${!LC_*}
declare -a args
root=/Tmpfs
apiurl=
api=
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
	if test -n "${repo}" && test -n "${arch}"
	then
		time \
		osc build \
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
