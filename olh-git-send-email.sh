#!/bin/bash
set -ex
reroll_count="$1"
rev_range="$2"
if test -n "${reroll_count}"
then
	shift
else
	reroll_count='1'
fi
if test -n "${rev_range}"
then
	shift
else
	rev_range='HEAD^'
fi
cmd=(
"$(type -P git)"
'send-email'
'--confirm=always'
'--annotate'
'--to-cmd' './scripts/get_maintainer.pl --norolestats --no-s --no-m --no-r'
'--cc-cmd' './scripts/get_maintainer.pl --norolestats --no-l'
"$@"
)
cmd+=( "--reroll-count=${reroll_count}" )
cmd+=( "${rev_range}" )
echo "cmd ok?
${cmd[@]}"
read
"${cmd[@]}"
echo "$?"
