#!/bin/bash
set -ex
push=
declare -a make_args
while test $# -gt 0
do
	case "$1" in
	push) push='PUSH=1' ;;
	*) make_args+=( "$1" ) ;;
	esac
	shift
done
pushd ~/git/xen.git
git --no-pager status
docker login registry.gitlab.com/xen-project/xen
make -C automation/build suse/opensuse-leap
env \
	CONTAINER_NO_PULL=1 \
	CONTAINER=leap \
	CONTAINER_ARGS='-e CC=gcc -e CXX=g++ -e debug=n' \
	automation/scripts/containerize automation/scripts/build < /dev/null
make -C automation/build suse/opensuse-leap ${push}
echo $?
