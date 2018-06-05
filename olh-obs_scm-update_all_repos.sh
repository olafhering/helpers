#!/bin/bash
set -e
unset LANG
unset ${!LC_*}
pushd ~/git/for_obs
td=`mktemp --directory --tmpdir=/dev/shm XXX`
export TMPDIR=$td
trap "rm -rf $td" EXIT
#
fetch_and_push() {
  git fetch --all &> $t/fetch_all_repos
  git fetch --tags upstream &> $t/fetch_all_tags_upstream
  git push --tags github_olafhering &> $t/fetch_and_push.github_olafhering &
  git push --tags gitlab_olafhering &> $t/fetch_and_push.gitlab_olafhering &
  git push --tags gitlab_olh        &> $t/fetch_and_push.gitlab_olh        &
}
#
push_master() {
(
  git push github_olafhering 'refs/remotes/upstream/master:refs/heads/master' &> $t/push_master.github_olafhering &
  git push gitlab_olafhering 'refs/remotes/upstream/master:refs/heads/master' &> $t/push_master.gitlab_olafhering &
  git push gitlab_olh        'refs/remotes/upstream/master:refs/heads/master' &> $t/push_master.gitlab_olh        &
)
}
#
claws() {
(
t=`mktemp --directory $td/claws.XXX`
export t
if pushd claws.git > /dev/null
then
  fetch_and_push
  push_master
  wait
  cat $t/*
  popd > /dev/null
fi
) &> ${td}/ipxe.log < /dev/null &
}
ipxe() {
(
t=`mktemp --directory $td/ipxe.XXX`
export t
if pushd ipxe.git > /dev/null
then
  fetch_and_push
  wait
  cat $t/*
  popd > /dev/null
fi
) &> ${td}/ipxe.log < /dev/null &
}
mini_os() {
(
t=`mktemp --directory $td/mini_os.XXX`
export t
if pushd mini-os.git > /dev/null
then
  fetch_and_push
  push_master
  wait
  cat $t/*
  popd > /dev/null
fi
) &> ${td}/mini_os.log < /dev/null &
}
mutt() {
(
t=`mktemp --directory $td/mutt.XXX`
export t
if pushd mutt.git > /dev/null
then
  git fetch --all
  push_master
  wait
  cat $t/*
  popd > /dev/null
fi
) &> ${td}/mutt.log < /dev/null &
}
ovmf() {
(
t=`mktemp --directory $td/ovmf.XXX`
export t
if pushd ovmf.git > /dev/null
then
  git fetch --all
  push_master
  wait
  cat $t/*
  popd > /dev/null
fi
) &> ${td}/ovmf.log < /dev/null &
}
qemu() {
(
t=`mktemp --directory $td/qemu.XXX`
export t
if pushd qemu.git > /dev/null
then
  fetch_and_push
  push_master
  git push github_olafhering 'refs/remotes/upstream/stable-2.*:refs/heads/stable-2.*' &> $t/qemu.github_olafhering &
  git push gitlab_olafhering 'refs/remotes/upstream/stable-2.*:refs/heads/stable-2.*' &> $t/qemu.gitlab_olafhering &
  git push gitlab_olh        'refs/remotes/upstream/stable-2.*:refs/heads/stable-2.*' &> $t/qemu.gitlab_olh        &
  wait
  cat $t/*
  popd > /dev/null
fi
) &> ${td}/qemu.log < /dev/null &
}
qemu_xen() {
(
t=`mktemp --directory $td/qemu_xen.XXX`
export t
if pushd qemu-xen.git > /dev/null
then
  fetch_and_push
  push_master
  git push github_olafhering 'refs/remotes/upstream/staging:refs/heads/staging'         &> $t/qemu_xen.staging.github_olafhering     &
  git push gitlab_olafhering 'refs/remotes/upstream/staging:refs/heads/staging'         &> $t/qemu_xen.staging.gitlab_olafhering     &
  git push gitlab_olh        'refs/remotes/upstream/staging:refs/heads/staging'         &> $t/qemu_xen.staging.gitlab_olh            &
  git push github_olafhering 'refs/remotes/upstream/staging-4.*:refs/heads/staging-4.*' &> $t/qemu_xen.staging-4.4.github_olafhering &
  git push gitlab_olafhering 'refs/remotes/upstream/staging-4.*:refs/heads/staging-4.*' &> $t/qemu_xen.staging-4.4.gitlab_olafhering &
  git push gitlab_olh        'refs/remotes/upstream/staging-4.*:refs/heads/staging-4.*' &> $t/qemu_xen.staging-4.4.gitlab_olh        &
  wait
  cat $t/*
  popd > /dev/null
fi
) &> ${td}/qemu_xen.log < /dev/null &
}
qemu_xen_traditional() {
(
t=`mktemp --directory $td/qemu_xen_trad.XXX`
export t
if pushd qemu-xen-traditional.git > /dev/null
then
  fetch_and_push
  push_master
  git push github_olafhering 'refs/remotes/upstream/stable-4.*:refs/heads/stable-4.*' &> $t/qemu_xen_traditional.stable-4.4.github_olafhering &
  git push gitlab_olafhering 'refs/remotes/upstream/stable-4.*:refs/heads/stable-4.*' &> $t/qemu_xen_traditional.stable-4.4.gitlab_olafhering &
  git push gitlab_olh        'refs/remotes/upstream/stable-4.*:refs/heads/stable-4.*' &> $t/qemu_xen_traditional.stable-4.4.gitlab_olh        &
  wait
  cat $t/*
  popd > /dev/null
fi
) &> ${td}/qemu_xen_traditional.log < /dev/null &
}
keycodemapdb() {
(
t=`mktemp --directory $td/keycodemapdb.XXX`
export t
if pushd keycodemapdb.git > /dev/null
then
  fetch_and_push
  push_master
  wait
  cat $t/*
  popd > /dev/null
fi
) &> ${td}/keycodemapdb.log < /dev/null &
}
libvirt() {
(
t=`mktemp --directory $td/libvirt.XXX`
export t
if pushd libvirt.git > /dev/null
then
  fetch_and_push
  push_master
  wait
  cat $t/*
  popd > /dev/null
fi
) &> ${td}/libvirt.log < /dev/null &
}
seabios() {
(
t=`mktemp --directory $td/seabios.XXX`
export t
if pushd seabios.git > /dev/null
then
  fetch_and_push
  push_master
  git push github_olafhering 'refs/remotes/upstream/1.8-stable:refs/heads/1.8-stable' &> $t/qemu_xen_traditional.stable-1.8.github_olafhering &
  git push gitlab_olafhering 'refs/remotes/upstream/1.8-stable:refs/heads/1.8-stable' &> $t/qemu_xen_traditional.stable-1.8.gitlab_olafhering &
  git push gitlab_olh        'refs/remotes/upstream/1.8-stable:refs/heads/1.8-stable' &> $t/qemu_xen_traditional.stable-1.8.gitlab_olh        &
  git push github_olafhering 'refs/remotes/upstream/1.9-stable:refs/heads/1.9-stable' &> $t/qemu_xen_traditional.stable-1.9.github_olafhering &
  git push gitlab_olafhering 'refs/remotes/upstream/1.9-stable:refs/heads/1.9-stable' &> $t/qemu_xen_traditional.stable-1.9.gitlab_olafhering &
  git push gitlab_olh        'refs/remotes/upstream/1.9-stable:refs/heads/1.9-stable' &> $t/qemu_xen_traditional.stable-1.9.gitlab_olh        &
  wait
  cat $t/*
  popd > /dev/null
fi
) &> ${td}/seabios.log < /dev/null &
}
valgrind() {
(
t=`mktemp --directory $td/valgrind.XXX`
export t
if pushd valgrind.git > /dev/null
then
  fetch_and_push
  push_master
  wait
  cat $t/*
  popd > /dev/null
fi
) &> ${td}/valgrind.log < /dev/null &
}
xen() {
(
t=`mktemp --directory $td/xen.XXX`
export t
if pushd xen.git > /dev/null
then
  fetch_and_push
  git push github_olafhering 'refs/remotes/upstream/staging*:refs/heads/staging*' &> $t/xen.staging.github_olafhering &
  git push gitlab_olafhering 'refs/remotes/upstream/staging*:refs/heads/staging*' &> $t/xen.staging.gitlab_olafhering &
  git push gitlab_olh        'refs/remotes/upstream/staging*:refs/heads/staging*' &> $t/xen.staging.gitlab_olh        &
  wait
  cat $t/*
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
mutt
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
