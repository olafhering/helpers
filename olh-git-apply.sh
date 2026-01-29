#!/bin/bash
set -e
unset LANG
unset ${!LC_*}
export LC_ALL=en_US.UTF-8
trap "echo 'Usage: ${0##*/} GITDIR < git_patch'" EXIT
gitdir=
until test $# -lt 1
do
  case "$1" in
    *) gitdir=$1
  esac
  shift
done
#
test -n "${gitdir}"
td=`mktemp --directory --tmpdir=/Tmpfs XXX`
trap "rm -rf '${td}'" EXIT
export TMPDIR=${td}
pushd "${gitdir}"
stdin=${td}/stdin.txt
cat > "${stdin}"
DATE="`grep -im1 ^Date: \"${stdin}\" | cut -d : -f 2-`"
export GIT_AUTHOR_DATE="${DATE}"
export GIT_COMMITTER_DATE="${DATE}"
git am --keep-cr < "${stdin}"
