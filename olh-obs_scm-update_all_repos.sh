#!/bin/bash
set -e
unset LANG
unset ${!LC_*}
renice -n 11 -p "$$"
ionice --class 3 -p "$$"
read v1 x < /proc/uptime
myself="`readlink -f \"$0\"`"
push=true
do_fetch_all=
do_fetch_and_push=
do_push_master=
forked=
#
fn_initial_fetch() {
  local name url rest
  git remote -v | while read name url rest
  do
    case "${name}" in
    upstream)
      case "${url}" in
      hg::*)
        git fetch "${name}"
        git gc --aggressive
      ;;
      esac
    ;;
    esac
  done
}
#
fn_fetch_all() {
  test -e .git/objects/info/packs || fn_initial_fetch &> $t/a.a.initial_fetch
  git fetch --all &> $t/a.fetch_all_repos
}
fn_fetch_and_push() {
  fn_fetch_all
  git fetch --tags upstream &> $t/a.fetch_all_tags_upstream
  if ${push}
  then
  git push --tags github_olafhering &> $t/fetch_and_push.github_olafhering &
  git push --tags gitlab_olafhering &> $t/fetch_and_push.gitlab_olafhering &
  git push --tags gitlab_olh        &> $t/fetch_and_push.gitlab_olh        &
  fi
}
fn_push_master() {
  if ${push}
  then
  git push github_olafhering 'refs/remotes/upstream/master:refs/heads/master' &> $t/push_master.github_olafhering &
  git push gitlab_olafhering 'refs/remotes/upstream/master:refs/heads/master' &> $t/push_master.gitlab_olafhering &
  git push gitlab_olh        'refs/remotes/upstream/master:refs/heads/master' &> $t/push_master.gitlab_olh        &
  fi
}
#
while test $# -gt 0
do
  : $1
  case "$1" in
    -forked) forked=true ;;
    -simple_fetch_all) do_fetch_all=true ;;
    -fetch_and_push) do_fetch_and_push=true ;;
    -push_master) do_push_master=true ;;
    -tmpdir) t="$2" ; shift ;;
    -np) push=false ;;
    *) echo "UNHANDLED: $0 $*" >&2 ; exit 1 ;;
  esac
  shift
done
if test -n "${forked}"
then
  export TMPDIR=$t
  test -n "${do_fetch_all}"      && fn_fetch_all
  test -n "${do_fetch_and_push}" && fn_fetch_and_push
  test -n "${do_push_master}"    && fn_push_master
  wait
  exit 0
fi
#
pushd ~/git/for_obs
td=`mktemp --directory --tmpdir=/dev/shm XXX`
export TMPDIR=$td
trap "rm -rf $td" EXIT
#
simple_fetch_all() {
 do_fetch_all=true
}
#
fetch_and_push() {
 do_fetch_and_push=true
}
#
push_master() {
{
 do_push_master=true
}
}
#
finish() {
  local f
  local t=$1
  local args=
  test -n "${do_fetch_all}" && args="${args} -simple_fetch_all"
  test -n "${do_fetch_and_push}" && args="${args} -fetch_and_push"
  test -n "${do_push_master}" && args="${args} -push_master"
  test "${push}" = "false" && args="${args} -np"
  bash "${myself}" ${args} -tmpdir "${t}" -forked
  for f in "$t"/*
  do
  sed "
  /searching for changes/d
  /no changes found/d
  /Everything up-to-date/d
  /^Fetching /d
  /^Please make sure you have the correct access rights/d
  /^and the repository exists./d
  s@^@${f##*.}: @
  " "$f"
  done
  popd > /dev/null
}
#
claws() {
 local do_fetch_all=
 local do_fetch_and_push=
 local do_push_master=
{
t=`mktemp --directory $td/claws.XXX`
if pushd claws.git > /dev/null
then
  fetch_and_push
  push_master
  finish $t
fi
} &> ${td}/claws.log < /dev/null &
}
grub() {
 local do_fetch_all=
 local do_fetch_and_push=
 local do_push_master=
{
t=`mktemp --directory $td/grub.XXX`
if pushd grub.git > /dev/null
then
  fetch_and_push
  push_master
  finish $t
fi
} &> ${td}/grub.log < /dev/null &
}
ipxe() {
 local do_fetch_all=
 local do_fetch_and_push=
 local do_push_master=
{
t=`mktemp --directory $td/ipxe.XXX`
if pushd ipxe.git > /dev/null
then
  fetch_and_push
  push_master
  finish $t
fi
} &> ${td}/ipxe.log < /dev/null &
}
mini_os() {
 local do_fetch_all=
 local do_fetch_and_push=
 local do_push_master=
{
t=`mktemp --directory $td/mini_os.XXX`
if pushd mini-os.git > /dev/null
then
  fetch_and_push
  push_master
  finish $t
fi
} &> ${td}/mini_os.log < /dev/null &
}
mutt() {
 local do_fetch_all=
 local do_fetch_and_push=
 local do_push_master=
{
t=`mktemp --directory $td/mutt.XXX`
if pushd mutt.git > /dev/null
then
  simple_fetch_all
  push_master
  finish $t
fi
} &> ${td}/mutt.log < /dev/null &
}
ovmf() {
 local do_fetch_all=
 local do_fetch_and_push=
 local do_push_master=
{
t=`mktemp --directory $td/ovmf.XXX`
if pushd ovmf.git > /dev/null
then
  simple_fetch_all
  push_master
  finish $t
fi
} &> ${td}/ovmf.log < /dev/null &
}
gplugin() {
 local do_fetch_all=
 local do_fetch_and_push=
 local do_push_master=
{
t=`mktemp --directory $td/gplugin.XXX`
if pushd gplugin.git > /dev/null
then
  fetch_and_push
  if ${push}
  then
  git push github_olafhering 'refs/remotes/upstream/branches/default:refs/heads/default' &> $t/gplugin.github_olafhering &
  git push gitlab_olafhering 'refs/remotes/upstream/branches/default:refs/heads/default' &> $t/gplugin.gitlab_olafhering &
  git push gitlab_olh        'refs/remotes/upstream/branches/default:refs/heads/default' &> $t/gplugin.gitlab_olh        &
  git push github_olafhering 'refs/remotes/upstream/branches/develop:refs/heads/develop' &> $t/gplugin.github_olafhering &
  git push gitlab_olafhering 'refs/remotes/upstream/branches/develop:refs/heads/develop' &> $t/gplugin.gitlab_olafhering &
  git push gitlab_olh        'refs/remotes/upstream/branches/develop:refs/heads/develop' &> $t/gplugin.gitlab_olh        &
  fi
  finish $t
fi
} &> ${td}/gplugin.log < /dev/null &
}
libgnt() {
 local do_fetch_all=
 local do_fetch_and_push=
 local do_push_master=
{
t=`mktemp --directory $td/libgnt.XXX`
if pushd libgnt.git > /dev/null
then
  fetch_and_push
  if ${push}
  then
  git push github_olafhering 'refs/remotes/upstream/branches/default:refs/heads/default' &> $t/libgnt.github_olafhering &
  git push gitlab_olafhering 'refs/remotes/upstream/branches/default:refs/heads/default' &> $t/libgnt.gitlab_olafhering &
  git push gitlab_olh        'refs/remotes/upstream/branches/default:refs/heads/default' &> $t/libgnt.gitlab_olh        &
  fi
  finish $t
fi
} &> ${td}/libgnt.log < /dev/null &
}
talkatu() {
 local do_fetch_all=
 local do_fetch_and_push=
 local do_push_master=
{
t=`mktemp --directory $td/talkatu.XXX`
if pushd talkatu.git > /dev/null
then
  fetch_and_push
  if ${push}
  then
  git push github_olafhering 'refs/remotes/upstream/branches/default:refs/heads/default' &> $t/talkatu.github_olafhering &
  git push gitlab_olafhering 'refs/remotes/upstream/branches/default:refs/heads/default' &> $t/talkatu.gitlab_olafhering &
  git push gitlab_olh        'refs/remotes/upstream/branches/default:refs/heads/default' &> $t/talkatu.gitlab_olh        &
  fi
  finish $t
fi
} &> ${td}/talkatu.log < /dev/null &
}
pidgin() {
 local do_fetch_all=
 local do_fetch_and_push=
 local do_push_master=
{
t=`mktemp --directory $td/pidgin.XXX`
if pushd pidgin.git > /dev/null
then
  fetch_and_push
  if ${push}
  then
  git push github_olafhering 'refs/remotes/upstream/branches/default:refs/heads/default' &> $t/pidgin.github_olafhering &
  git push gitlab_olafhering 'refs/remotes/upstream/branches/default:refs/heads/default' &> $t/pidgin.gitlab_olafhering &
  git push gitlab_olh        'refs/remotes/upstream/branches/default:refs/heads/default' &> $t/pidgin.gitlab_olh        &
  git push github_olafhering 'refs/remotes/upstream/branches/release-2.x.y:refs/heads/release-2.x.y' &> $t/pidgin.github_olafhering &
  git push gitlab_olafhering 'refs/remotes/upstream/branches/release-2.x.y:refs/heads/release-2.x.y' &> $t/pidgin.gitlab_olafhering &
  git push gitlab_olh        'refs/remotes/upstream/branches/release-2.x.y:refs/heads/release-2.x.y' &> $t/pidgin.gitlab_olh        &
  fi
  finish $t
fi
} &> ${td}/pidgin.log < /dev/null &
}
purple_rocketchat() {
 local do_fetch_all=
 local do_fetch_and_push=
 local do_push_master=
{
t=`mktemp --directory $td/purple_rocketchat.XXX`
if pushd purple-rocketchat.git > /dev/null
then
  fetch_and_push
  if ${push}
  then
  git push github_olafhering 'refs/remotes/upstream/branches/default:refs/heads/default' &> $t/purple_rocketchat.github_olafhering &
  git push gitlab_olafhering 'refs/remotes/upstream/branches/default:refs/heads/default' &> $t/purple_rocketchat.gitlab_olafhering &
  git push gitlab_olh        'refs/remotes/upstream/branches/default:refs/heads/default' &> $t/purple_rocketchat.gitlab_olh        &
  fi
  finish $t
fi
} &> ${td}/purple_rocketchat.log < /dev/null &
}
qemu() {
 local do_fetch_all=
 local do_fetch_and_push=
 local do_push_master=
{
t=`mktemp --directory $td/qemu.XXX`
if pushd qemu.git > /dev/null
then
  fetch_and_push
  push_master
  if ${push}
  then
  git push github_olafhering 'refs/remotes/upstream/stable-4.*:refs/heads/stable-4.*' &> $t/qemu.github_olafhering &
  git push gitlab_olafhering 'refs/remotes/upstream/stable-4.*:refs/heads/stable-4.*' &> $t/qemu.gitlab_olafhering &
  git push gitlab_olh        'refs/remotes/upstream/stable-4.*:refs/heads/stable-4.*' &> $t/qemu.gitlab_olh        &
  git push github_olafhering 'refs/remotes/upstream/stable-3.*:refs/heads/stable-3.*' &> $t/qemu.github_olafhering &
  git push gitlab_olafhering 'refs/remotes/upstream/stable-3.*:refs/heads/stable-3.*' &> $t/qemu.gitlab_olafhering &
  git push gitlab_olh        'refs/remotes/upstream/stable-3.*:refs/heads/stable-3.*' &> $t/qemu.gitlab_olh        &
  git push github_olafhering 'refs/remotes/upstream/stable-2.*:refs/heads/stable-2.*' &> $t/qemu.github_olafhering &
  git push gitlab_olafhering 'refs/remotes/upstream/stable-2.*:refs/heads/stable-2.*' &> $t/qemu.gitlab_olafhering &
  git push gitlab_olh        'refs/remotes/upstream/stable-2.*:refs/heads/stable-2.*' &> $t/qemu.gitlab_olh        &
  fi
  finish $t
fi
} &> ${td}/qemu.log < /dev/null &
}
qemu_xen() {
 local do_fetch_all=
 local do_fetch_and_push=
 local do_push_master=
{
t=`mktemp --directory $td/qemu_xen.XXX`
if pushd qemu-xen.git > /dev/null
then
  fetch_and_push
  push_master
  if ${push}
  then
  git push github_olafhering 'refs/remotes/upstream/staging:refs/heads/staging'         &> $t/qemu_xen.staging.github_olafhering     &
  git push gitlab_olafhering 'refs/remotes/upstream/staging:refs/heads/staging'         &> $t/qemu_xen.staging.gitlab_olafhering     &
  git push gitlab_olh        'refs/remotes/upstream/staging:refs/heads/staging'         &> $t/qemu_xen.staging.gitlab_olh            &
  git push github_olafhering 'refs/remotes/upstream/staging-4.*:refs/heads/staging-4.*' &> $t/qemu_xen.staging-4.4.github_olafhering &
  git push gitlab_olafhering 'refs/remotes/upstream/staging-4.*:refs/heads/staging-4.*' &> $t/qemu_xen.staging-4.4.gitlab_olafhering &
  git push gitlab_olh        'refs/remotes/upstream/staging-4.*:refs/heads/staging-4.*' &> $t/qemu_xen.staging-4.4.gitlab_olh        &
  fi
  finish $t
fi
} &> ${td}/qemu_xen.log < /dev/null &
}
qemu_xen_traditional() {
 local do_fetch_all=
 local do_fetch_and_push=
 local do_push_master=
{
t=`mktemp --directory $td/qemu_xen_trad.XXX`
if pushd qemu-xen-traditional.git > /dev/null
then
  fetch_and_push
  push_master
  if ${push}
  then
  git push github_olafhering 'refs/remotes/upstream/stable-4.*:refs/heads/stable-4.*' &> $t/qemu_xen_traditional.stable-4.4.github_olafhering &
  git push gitlab_olafhering 'refs/remotes/upstream/stable-4.*:refs/heads/stable-4.*' &> $t/qemu_xen_traditional.stable-4.4.gitlab_olafhering &
  git push gitlab_olh        'refs/remotes/upstream/stable-4.*:refs/heads/stable-4.*' &> $t/qemu_xen_traditional.stable-4.4.gitlab_olh        &
  fi
  finish $t
fi
} &> ${td}/qemu_xen_traditional.log < /dev/null &
}
keycodemapdb() {
 local do_fetch_all=
 local do_fetch_and_push=
 local do_push_master=
{
t=`mktemp --directory $td/keycodemapdb.XXX`
if pushd keycodemapdb.git > /dev/null
then
  fetch_and_push
  push_master
  finish $t
fi
} &> ${td}/keycodemapdb.log < /dev/null &
}
libetpan() {
 local do_fetch_all=
 local do_fetch_and_push=
 local do_push_master=
{
t=`mktemp --directory $td/libetpan.XXX`
if pushd libetpan.git > /dev/null
then
  fetch_and_push
  push_master
  finish $t
fi
} &> ${td}/libetpan.log < /dev/null &
}
libvirt() {
 local do_fetch_all=
 local do_fetch_and_push=
 local do_push_master=
{
t=`mktemp --directory $td/libvirt.XXX`
if pushd libvirt.git > /dev/null
then
  fetch_and_push
  push_master
  finish $t
fi
} &> ${td}/libvirt.log < /dev/null &
}
seabios() {
 local do_fetch_all=
 local do_fetch_and_push=
 local do_push_master=
{
t=`mktemp --directory $td/seabios.XXX`
if pushd seabios.git > /dev/null
then
  fetch_and_push
  push_master
  if ${push}
  then
  git push github_olafhering 'refs/remotes/upstream/1.8-stable:refs/heads/1.8-stable' &> $t/qemu_xen_traditional.stable-1.8.github_olafhering &
  git push gitlab_olafhering 'refs/remotes/upstream/1.8-stable:refs/heads/1.8-stable' &> $t/qemu_xen_traditional.stable-1.8.gitlab_olafhering &
  git push gitlab_olh        'refs/remotes/upstream/1.8-stable:refs/heads/1.8-stable' &> $t/qemu_xen_traditional.stable-1.8.gitlab_olh        &
  git push github_olafhering 'refs/remotes/upstream/1.9-stable:refs/heads/1.9-stable' &> $t/qemu_xen_traditional.stable-1.9.github_olafhering &
  git push gitlab_olafhering 'refs/remotes/upstream/1.9-stable:refs/heads/1.9-stable' &> $t/qemu_xen_traditional.stable-1.9.gitlab_olafhering &
  git push gitlab_olh        'refs/remotes/upstream/1.9-stable:refs/heads/1.9-stable' &> $t/qemu_xen_traditional.stable-1.9.gitlab_olh        &
  fi
  finish $t
fi
} &> ${td}/seabios.log < /dev/null &
}
valgrind() {
 local do_fetch_all=
 local do_fetch_and_push=
 local do_push_master=
{
t=`mktemp --directory $td/valgrind.XXX`
if pushd valgrind.git > /dev/null
then
  fetch_and_push
  push_master
  finish $t
fi
} &> ${td}/valgrind.log < /dev/null &
}
xen() {
 local do_fetch_all=
 local do_fetch_and_push=
 local do_push_master=
{
t=`mktemp --directory $td/xen.XXX`
if pushd xen.git > /dev/null
then
  fetch_and_push
  if ${push}
  then
  git push github_olafhering 'refs/remotes/upstream/staging*:refs/heads/staging*' &> $t/xen.staging.github_olafhering &
  git push gitlab_olafhering 'refs/remotes/upstream/staging*:refs/heads/staging*' &> $t/xen.staging.gitlab_olafhering &
  git push gitlab_olh        'refs/remotes/upstream/staging*:refs/heads/staging*' &> $t/xen.staging.gitlab_olh        &
  fi
  finish $t
fi
} &> ${td}/xen.log < /dev/null &
}
#
claws
#
grub
#
ipxe
#
mini_os
#
mutt
#
ovmf
#
gplugin
#
libgnt
#
talkatu
#
pidgin
#
purple_rocketchat
#
qemu
#
qemu_xen
#
qemu_xen_traditional
#
keycodemapdb
#
libetpan
#
libvirt
#
seabios
#
valgrind
#
xen
#
wait
read v2 x < /proc/uptime

d=$(( ${v2//./} - ${v1//./} ))
s=$(( ${d} / 100 ))
m=${d: -2}
if test -z "${m}"
then
	if test "${#d}" -gt 1
	then
		m=${d: -2}
	else
		m=${d: -1}
	fi
fi
for i in "${td}"/*.log
do
  test -s "${i}" || rm -f "${i}"
done
head -vn 12345 "${td}"/*.log 2> /dev/null || :
printf 'Update ran for %u.%02u seconds.\n' "${s}" "${m#0}"
date
