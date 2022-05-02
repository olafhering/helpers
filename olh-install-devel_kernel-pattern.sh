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
'pkgconfig(libelf)'
'pkgconfig(openssl)'
'quilt'
'rapidquilt'
'rsync'
'time'
'wdiff'
)
set -x
exec zypper --no-refresh install --no-confirm "${pkgs[@]}"
