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
# https://api-host/package/live_build_log/prj/pkg/repository/arch
package/live_build_log)
	host=$3
	prj=$6
	pkg=$7
	repository=$8
	arch=$9
	;;
# https://api-host/public/build/prj/repository/arch/pkg/_log
public/build)
	host=$3
	prj=$6
	pkg=$9
	repository=$7
	arch=$8
	;;
*) echo "Unknown request $4/$5" ; exit 1 ;;
esac
#
case "${host}" in
pmbs.links2linux.de) cmd='pbs' ;;
build.opensuse.org) cmd='obs' ;;
build.suse.de) cmd='ibs' ;;
*) echo "Unknown API host ${host}" ; exit 1 ;;
esac
#
case "${pkg}" in
*:*)
	oIFS=$IFS
	IFS=:
	set -- ${pkg}
	IFS=$oIFS
	pkg=$1
	multibuild="-M $2"
	;;
*) multibuild= ;;
esac
#
exec "${cmd}" tr ${multibuild} "${prj}" "${pkg}" "${repository}" "${arch}"
