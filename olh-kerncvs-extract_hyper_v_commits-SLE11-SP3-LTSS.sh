#!/bin/bash
set -e
#set -x
#
trap "echo $0 <opts>" EXIT
unset LANG
unset ${!LC_*}
maj_tag=3
min_tag=0
kerncvs_branch_script="olh-kerncvs-extract_hyper_v_commits-kerncvs_branch"
tmpdir=
topdir=
kerncvs_branch=
kerncvs_dir=
script_dir=
upstream_git=
upstream_remote=
upstream_branch=
hv_dir=
#
while test $# -gt 0
do
	case "$1" in
		--tmpdir)
		tmpdir=$2
		shift
		;;
		--topdir)
		topdir=$2
		shift
		;;
		--upstream_git)
		upstream_git=$2
		shift
		;;
		--upstream_remote)
		upstream_remote=$2
		shift
		;;
		--upstream_branch)
		upstream_branch=$2
		shift
		;;
		--hv_dir)
		hv_dir=$2
		shift
		;;
		--kerncvs_branch)
		kerncvs_branch=$2
		shift
		;;
		--kerncvs_dir)
		kerncvs_dir=$2
		shift
		;;
		--script_dir)
		script_dir=$2
		shift
		;;
	esac
	shift
done
#
test -n "${tmpdir}"
test -n "${topdir}"
test -n "${upstream_git}"
test -n "${upstream_remote}"
test -n "${upstream_branch}"
test -n "${kerncvs_dir}"
test -n "${kerncvs_branch}"
test -n "${hv_dir}"
test -n "${script_dir}"
#
exec \
	bash "${script_dir}/${kerncvs_branch_script}" \
		--maj_tag "${maj_tag}" \
		--min_tag "${min_tag}" \
		--topdir "${topdir}" \
		--upstream_git "${upstream_git}" \
		--upstream_remote "${upstream_remote}" \
		--upstream_branch "${upstream_branch}" \
		--kerncvs_dir "${kerncvs_dir}" \
		--kerncvs_branch "${kerncvs_branch}" \
		--hv_dir "${hv_dir}" \
		--script_dir "${script_dir}" \
		--tmpdir "${tmpdir}"
exit 1
