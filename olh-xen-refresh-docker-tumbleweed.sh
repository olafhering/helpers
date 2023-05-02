#!/bin/bash
set -ex
push=
test "$1" = 'push' && push='PUSH=1'
pushd ~/git/xen.git
git --no-pager status
docker login registry.gitlab.com/xen-project/xen
git --no-pager checkout staging
make -C automation/build suse/opensuse-tumbleweed
env \
	CONTAINER_NO_PULL=1 \
	CONTAINER=tumbleweed \
	automation/scripts/containerize bash -exc './configure && make -j$(nproc)'
make -C automation/build suse/opensuse-tumbleweed ${push}
echo $?
