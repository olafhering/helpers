#!/bin/bash
pkgs=(
'bc'
'bison'
'ctags'
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
'rsync'
'time'
'wdiff'
)
set -x
exec zypper --no-refresh install --no-confirm "${pkgs[@]}"
