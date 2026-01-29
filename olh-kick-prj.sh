#!/bin/bash
# vim: ts=2 shiftwidth=2 noexpandtab nowrap
set -e
unset LANG
unset ${!LC_*}
forever=
test "$1" = "-c" && forever='forever'
test "$1" = "-C" && forever='Forever'
td=`mktemp --directory --tmpdir=/Tmpfs .XXX`
trap "rm -rf '$td'" EXIT
t="${td}/t"
tr="${td}/tr"
tR="${td}/tR"

delay() {
	local r=`printf %05u ${RANDOM}`
	local r2=${r:1:5}
	local -i r1=${r:0:1}
	local -i i=123
	test "${forever}" = "Forever" && i=1234
	sleep $(( ${i} + ${r1} )).${r2}
}
while true
do
	test -n "${forever}" && date
	osc meta prj > "$t"
	sed '
	s@"r"@"R"@
	' < "$t" > "${tR}"
	sed '
	s@"R"@"r"@
	' < "$t" > "${tr}"
	if cmp -s "$t" "${tr}" && cmp -s "$t" "${tR}"
	then
		: identical
		test -n "${forever}" || break
		delay
	elif cmp -s "$t" "${tR}"
	then
		echo "r"
		osc meta prj -F "$tr"
	else
		echo "R"
		osc meta prj -F "$tR"
	fi
	test -n "${forever}" || break
	delay
done
