#!/bin/bash
declare -a files
declare -i num=0
grep_search_string=
vim_search_string=
#
grep_search_string+='('

for string in "$@"
do
	: $(( num++ ))
	if test ${num} -gt 1
	then
		grep_search_string+='|'
		vim_search_string+='\|'
	fi
	grep_search_string+="${string}"
	vim_search_string+="${string}"
done
grep_search_string+=')'
#
while read
do
	files+=("${REPLY}")
done < <(git --no-pager grep -El "${grep_search_string}")
exec view -bn -c "silent! /${vim_search_string}" -- "${files[@]}"
