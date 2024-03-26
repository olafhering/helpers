#!/bin/bash
set -ex
unset LANG
unset ${!LC_*}
oIFS=$IFS
IFS=/
set -- $@
IFS=$oIFS
: $*
case "$4/$5" in
# https://api-host/request/show/RQ#-comment-NR
request/show)
	host=$3
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
exec "${cmd}" comment 'create' -p "${comment}" 'request' "${RQ}"
