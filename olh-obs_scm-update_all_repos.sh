#!/bin/bash
set -e
unset LANG
unset ${!LC_*}
pushd ~/git/for_obs
td=`mktemp --directory --tmpdir=/dev/shm`
trap "rm -rf $td" EXIT
#
fetch_and_push() {
  git fetch --all
  git fetch --tags upstream
  git push --tags github_olafhering &
  git push --tags gitlab_olafhering &
  git push --tags gitlab_olh &
  wait
}
#
push_master() {
(
  git push github_olafhering 'refs/remotes/upstream/master:refs/heads/master' &
  git push gitlab_olafhering 'refs/remotes/upstream/master:refs/heads/master' &
  git push gitlab_olh        'refs/remotes/upstream/master:refs/heads/master' &
  wait
)
}
#
claws() {
(
if pushd claws.git > /dev/null
then
  fetch_and_push
  push_master
  popd > /dev/null
fi
) &> ${td}/ipxe.log < /dev/null &
}
ipxe() {
(
if pushd ipxe.git > /dev/null
then
  fetch_and_push
  popd > /dev/null
fi
) &> ${td}/ipxe.log < /dev/null &
}
mini_os() {
(
if pushd mini-os.git > /dev/null
then
  fetch_and_push
  push_master
  popd > /dev/null
fi
) &> ${td}/mini_os.log < /dev/null &
}
ovmf() {
(
if pushd ovmf.git > /dev/null
then
  git fetch --all
  push_master
  popd > /dev/null
fi
) &> ${td}/ovmf.log < /dev/null &
}
qemu() {
(
if pushd qemu.git > /dev/null
then
  fetch_and_push
  push_master
  git push github_olafhering 'refs/remotes/upstream/stable-2.*:refs/heads/stable-2.*'
  git push gitlab_olafhering 'refs/remotes/upstream/stable-2.*:refs/heads/stable-2.*'
  git push gitlab_olh        'refs/remotes/upstream/stable-2.*:refs/heads/stable-2.*'
  popd > /dev/null
fi
) &> ${td}/qemu.log < /dev/null &
}
qemu_xen() {
(
if pushd qemu-xen.git > /dev/null
then
  fetch_and_push
  push_master
  git push github_olafhering 'refs/remotes/upstream/staging:refs/heads/staging'
  git push gitlab_olafhering 'refs/remotes/upstream/staging:refs/heads/staging'
  git push gitlab_olh        'refs/remotes/upstream/staging:refs/heads/staging'
  git push github_olafhering 'refs/remotes/upstream/staging-4.*:refs/heads/staging-4.*'
  git push gitlab_olafhering 'refs/remotes/upstream/staging-4.*:refs/heads/staging-4.*'
  git push gitlab_olh        'refs/remotes/upstream/staging-4.*:refs/heads/staging-4.*'
  popd > /dev/null
fi
) &> ${td}/qemu_xen.log < /dev/null &
}
qemu_xen_traditional() {
(
if pushd qemu-xen-traditional.git > /dev/null
then
  fetch_and_push
  push_master
  git push github_olafhering 'refs/remotes/upstream/stable-4.*:refs/heads/stable-4.*'
  git push gitlab_olafhering 'refs/remotes/upstream/stable-4.*:refs/heads/stable-4.*'
  git push gitlab_olh        'refs/remotes/upstream/stable-4.*:refs/heads/stable-4.*'
  popd > /dev/null
fi
) &> ${td}/qemu_xen_traditional.log < /dev/null &
}
keycodemapdb() {
(
if pushd keycodemapdb.git > /dev/null
then
  fetch_and_push
  push_master
  popd > /dev/null
fi
) &> ${td}/keycodemapdb.log < /dev/null &
}
libvirt() {
(
if pushd libvirt.git > /dev/null
then
  fetch_and_push
  push_master
  popd > /dev/null
fi
) &> ${td}/libvirt.log < /dev/null &
}
seabios() {
(
if pushd seabios.git > /dev/null
then
  fetch_and_push
  push_master
  git push github_olafhering 'refs/remotes/upstream/1.8-stable:refs/heads/1.8-stable'
  git push gitlab_olafhering 'refs/remotes/upstream/1.8-stable:refs/heads/1.8-stable'
  git push gitlab_olh        'refs/remotes/upstream/1.8-stable:refs/heads/1.8-stable'
  git push github_olafhering 'refs/remotes/upstream/1.9-stable:refs/heads/1.9-stable'
  git push gitlab_olafhering 'refs/remotes/upstream/1.9-stable:refs/heads/1.9-stable'
  git push gitlab_olh        'refs/remotes/upstream/1.9-stable:refs/heads/1.9-stable'
  popd > /dev/null
fi
) &> ${td}/seabios.log < /dev/null &
}
valgrind() {
(
if pushd valgrind.git > /dev/null
then
  fetch_and_push
  push_master
  popd > /dev/null
fi
) &> ${td}/valgrind.log < /dev/null &
}
xen() {
(
if pushd xen.git > /dev/null
then
  fetch_and_push
  git push github_olafhering 'refs/remotes/upstream/staging*:refs/heads/staging*'
  git push gitlab_olafhering 'refs/remotes/upstream/staging*:refs/heads/staging*'
  git push gitlab_olh        'refs/remotes/upstream/staging*:refs/heads/staging*'
  popd > /dev/null
fi
) &> ${td}/xen.log < /dev/null &
}
#
claws
#
ipxe
#
mini_os
#
ovmf
#
qemu
#
qemu_xen
#
qemu_xen_traditional
#
keycodemapdb
#
libvirt
#
seabios
#
valgrind
#
xen
#
time wait
head -n 12345 "${td}"/*.log
