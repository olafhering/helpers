#!/bin/bash
#et -x
set -e
unset LANG
unset ${!LC*}
wd=$1
test -n "${wd}"
pushd "${wd}" > /dev/null
for dir in {A..Z} {a..z}
do
  test -d "${dir}" && continue
  mkdir "${dir}"
  echo "${dir}"
  exit 0
done
exit 1
