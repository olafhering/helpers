#!/bin/bash
set -e
declare -a args
unset LANG
unset ${!LC_*}
oIFS=$IFS
IFS=/
set -- $@
IFS=$oIFS
: $*
: $4/$5
case "$4/$5" in
# https://api-host/request/show/RQ#-comment-NR
request/show)
	host=$3
	target=$4
	RQ_comment=$6
	;;
# https://api-host/project/show/PRJ#comment-NR
project/show)
	host=$3
	target=$4
	RQ_comment=$6
	;;
*) echo "${0##*/}: Unknown request $4/$5" ; exit 1 ;;
esac
#
case "${host}" in
pmbs.links2linux.de) cmd='pbs' ;;
pmbs.links2linux.org) cmd='pbs' ;;
build.opensuse.org) cmd='obs' ;;
build.suse.de) cmd='ibs' ;;
*) echo "Unknown API host ${host}" ; exit 1 ;;
esac
#
RQ=${RQ_comment%%#*}
comment=${RQ_comment##*-}
args+=('comment' 'create')
test "${RQ}" != "${comment}" && args+=('-p' "${comment}")
args+=("${target}" "${RQ}")
exec "${cmd}" "${args[@]}"
