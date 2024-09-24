#!/bin/bash
pkgs=(
'bc'
'bison'
'ctags'
'dwarves'
'flex'
'gcc'
'git-core'
'helpers'
'make'
'patchutils'
'pkgconfig(libelf)'
'pkgconfig(openssl)'
'procmail'
'python3-dbm'
'python3-pygit2'
'quilt'
'rapidquilt'
'rcs'
'rpm-build'
'rsync'
'time'
'wdiff'
)
set -x
exec zypper --no-refresh install "${pkgs[@]}"
