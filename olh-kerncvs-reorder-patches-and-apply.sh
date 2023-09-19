#!/bin/bash
set -e
renice -n 11 -p "$$"
ionice --class 3 -p "$$"
. /usr/share/helpers/bin/olh-kerncvs-env
export TZ=UTC
unset LANG
unset ${!LC_*}
trap "exec bash $0 --error" EXIT
declare -a new_patches_in_series_conf
declare -i array_index
declare -i new_patch_number
declare -i ts
declare -i ts_author
declare -i ts_commit
date_string='now'
git_base=
git_head=
git_test=
stop_after_export=
#
help() {
	local rc=$1
	trap - EXIT
	cat <<_EOF_
Usage: ${0##*/} -b <base_commit> -h <head_commit> -t <new_local_branch> [-d <date_string>] [-s|--stop_after_export]
Usage: ${0##*/} [--help|--error]

This script rebases all new patch files between base..head to a new branch.
The order they need to appear is taken from series.conf.
They will appear as a single group of changes in kernel-source.changes.
An optional string for date(1) can be specified.
After reordering, before applying them with 'git am', the list can be tweaked further in a shell.
_EOF_
	exit "${rc}"
}
#
git_status() {
	git --no-pager status --porcelain --untracked-files=no | tee "${sf}"
}
#
git_status_check() {
	git_status
	if test -s "${sf}"
	then
		: some changes exist
		return 0
	fi
	: no pending changes
	return 1
}
#
#
while test "$#" -gt 0
do
	: arg $1
	case "$1" in
	-b|--base) git_base="$2" ; shift ;;
	-h|--head) git_head="$2" ; shift ;;
	-t|--test) git_test="$2" ; shift ;;
	-d|--date) date_string="$2" ; shift ;;
	-s|--stop_after_export) stop_after_export='stop_after_export' ;;
	--help) help 0 ;;
	--error) help 1 ;;
	*) echo "Unknown: $1" >&2 ; help 1 ;;
	esac
	shift
done
#
test -n "${git_base}" || exit 1
test -n "${git_head}" || exit 1
test -n "${git_test}" || exit 1
#
read ts < <(date -u -d "${date_string}" +%s)
ts_author="${ts}"
ts_commit="${ts}"

# verify if base, head and target branch exist
git --no-pager branch | awk '/^*[[:blank:]]/{ printf "Current branch: %s\n", $2 }'
git --no-pager log --oneline -n1 "${git_base}^!"
git --no-pager log --oneline -n1 "${git_head}^!"
if git --no-pager log --oneline -n1 "${git_test}^!" 2>/dev/null
then
	echo "ERROR: branch '${git_test}' does still exist."
	exit 1
fi
#
read td < <(mktemp --directory --tmpdir=/dev/shm .XXX)
trap "rm -rf '${td}'" EXIT
commits_order_old="${td}/commits_old"
commits_order_new="${td}/commits_new"
sf="${td}/status.txt"
#
mkdir "${commits_order_old}" "${commits_order_new}"

# extract all commits as patch
git --no-pager format-patch \
	--output-directory "${commits_order_old}" \
	--keep-subject \
	--no-renames \
	--stat=1234 \
	--stat-graph-width=1 \
	--stat-name-width=1234 \
	--zero-commit \
	"${git_base}..${git_head}" > /dev/null

# extract all new patches in series.conf in the order they need to appear
new_patches_in_series_conf=( $(git --no-pager diff -u "${git_base}..${git_head}" |
	filterdiff -p1 -i series.conf |
	awk '/^+[[:blank:]]/{print $2}')
	)
#
# look for each patch in existing commits
array_index=0
new_patch_number=10
while test ${array_index} -lt ${#new_patches_in_series_conf[@]}
do
	newly_added_patch=${new_patches_in_series_conf[${array_index}]}
	# 
	for commit_old in "${commits_order_old}"/*.patch
	do
		test -f "${commit_old}" || continue
		if cat "${commit_old}" |
			filterdiff -p1 -i series.conf |
			awk '/^+[[:blank:]]/{print $2}' |
			grep -q "${newly_added_patch}$"
		then
			read commit_number < <(printf '%05d\n' "${new_patch_number}")
			patch_name="${commit_number}-${commit_old##*/}"
			mv "${commit_old}" "${commits_order_new}/${patch_name}"
			break
		fi
			
	done
	: $(( array_index++ ))
	new_patch_number=$(( $new_patch_number + 10 ))
done
#
for commit_old in "${commits_order_old}"/*.patch
do
	test -f "${commit_old}" || continue
	echo "Remaining patch: ${commit_old}"
	read commit_number < <(printf '%05d\n' "${new_patch_number}")
	patch_name="${commit_number}-${commit_old##*/}"
	mv -v "${commit_old}" "${commits_order_new}/${patch_name}"
	new_patch_number=$(( $new_patch_number + 10 ))
done
#
git --no-pager checkout -b "${git_test}" "${git_base}"
#
if test -n "${stop_after_export}"
then
	pushd "${commits_order_new}"
	bash
	popd
fi
#
scripts/git_sort/series_sort.py 'series.conf'
if git_status_check
then
	echo "some changes exist, can not continue"
	exit 1
fi
#
for commit_new in "${commits_order_new}"/*.patch
do
	if git --no-pager am --ignore-space-change --ignore-whitespace --whitespace=nowarn < "${commit_new}"
	then
		: good
	else
		echo "FAILED to apply '${commit_new}'"
		echo "'git am --abort' suggested, followed by manual 'git am'."
		bash
	fi
	scripts/git_sort/series_sort.py 'series.conf'
	git add 'series.conf'
	env \
	GIT_AUTHOR_DATE="@${ts_author}" \
	GIT_COMMITTER_DATE="@${ts_commit}" \
	git --no-pager commit --amend --reset-author
	: $(( ts_commit++ ))
done
