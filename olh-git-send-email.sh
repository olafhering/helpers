#!/bin/bash
set -ex
reroll_count="$1"
rev_range="$2"
test -z "${reroll_count}" && reroll_count='1'
test -z "${rev_range}" && rev_range='HEAD^'
test "$#" -gt 2 && shift 2
cmd=(
"$(type -P git)"
'send-email'
'--confirm=always'
'--annotate'
'--to-cmd' './scripts/get_maintainer.pl --norolestats --no-s --no-m --no-r'
'--cc-cmd' './scripts/get_maintainer.pl --norolestats --no-l'
"$@"
)
cmd+=( '--reroll-count' "${reroll_count}" )
cmd+=( "${rev_range}" )
echo "cmd ok?
${cmd[@]}"
read
"${cmd[@]}"
echo "$?"
