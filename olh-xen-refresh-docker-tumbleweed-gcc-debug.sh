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
make -C automation/build opensuse/tumbleweed-x86_64
env \
	CONTAINER_NO_PULL=1 \
	CONTAINER=tumbleweed \
	CONTAINER_ARGS='-e CC=gcc -e CXX=g++ -e debug=y' \
	automation/scripts/containerize automation/scripts/build < /dev/null
make -C automation/build opensuse/tumbleweed-x86_64 ${push}
echo $?
