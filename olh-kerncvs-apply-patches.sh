#!/bin/bash
set -ex
. /usr/share/helpers/bin/olh-kerncvs-env
case "$1" in
insert)
	exec scripts/git_sort/series_insert $(git status --porcelain |awk '/^\?\? patches.suse\/.*.patch$/{print $2}')
;;
add)
	exec git --no-pager add $(git diff HEAD -- series.conf|awk '/^\+[[:blank:]]+patches./{print $2}')
;;
view)
	exec view -bn $(git diff HEAD -- series.conf|awk '/^\+[[:blank:]]+patches./{print $2}')
;;
commit)
	exec env TZ=UTC scripts/log
;;
*)
	echo "Usage: $0 [insert|add|view]
insert: insert missing patches into series.conf
add:    add new patches from series.conf to git
view:   inspect new patches from series.conf
"
;;
esac
