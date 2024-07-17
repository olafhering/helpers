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
make -C automation/build opensuse/leap-15.6-x86_64
env \
	CONTAINER_NO_PULL=1 \
	CONTAINER=leap \
	CONTAINER_ARGS='-e CC=clang -e CXX=clang++ -e debug=n -e clang=y' \
	automation/scripts/containerize automation/scripts/build < /dev/null
make -C automation/build opensuse/leap-15.6-x86_64 ${push}
echo $?
