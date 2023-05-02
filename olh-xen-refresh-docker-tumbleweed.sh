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
git --no-pager checkout staging
make -C automation/build suse/opensuse-tumbleweed
env \
	CONTAINER_NO_PULL=1 \
	CONTAINER=tumbleweed \
	automation/scripts/containerize bash -exc "./configure && make ${make_args[*]} || : make failed with \$?"
make -C automation/build suse/opensuse-tumbleweed ${push}
echo $?
