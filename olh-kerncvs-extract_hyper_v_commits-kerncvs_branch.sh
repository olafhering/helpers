#!/bin/bash
set -e
#set -x
#
trap "echo '$0 <opts>'" EXIT
unset LANG
unset ${!LC_*}
numcpus=`grep -Ec '^cpu[0-9]' /proc/stat || echo 1`
patch_dir=patch
revspec_dir=revspec
missing_patch_dir=missing_patch
declare -A missing_patch_list
missing_revspec_dir=missing_revspec
declare -A missing_revspec_list
ignore_revspec_dir=ignore_revspec
#
maj_tag=
min_tag=
tmpdir=
topdir=
kerncvs_branch=
kerncvs_dir=
script_dir=
upstream_git=
upstream_remote=
upstream_branch=
hv_dir=
declare -i count
declare -A revspec_names
#
do_symlink() {
	local link_dest=$1
	local symlink=$2
	local p="$(realpath --relative-to=${symlink%/*} ${link_dest%/*} )/${link_dest##*/}"
	ln --symbolic --force "$p" "${symlink}"
}
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
		--maj_tag)
		maj_tag=$2
		shift
		;;
		--min_tag)
		min_tag=$2
		shift
		;;
	esac
	shift
done
test -n "${tmpdir}"
test -n "${topdir}"
test -n "${upstream_git}"
test -n "${upstream_remote}"
test -n "${upstream_branch}"
test -n "${kerncvs_dir}"
test -n "${kerncvs_branch}"
test -n "${hv_dir}"
test -n "${script_dir}"
test -n "${maj_tag}"
test -n "${min_tag}"
trap "echo 'done with ${0##*/} $*'" EXIT

#
if ! pushd "${topdir}" > /dev/null
then
	exit 1
fi
#
if ! pushd "${kerncvs_dir}" > /dev/null
then
	exit 1
fi
kerncvs_dir=$PWD
popd > /dev/null
#
mkdir -vp "${hv_dir}/${ignore_revspec_dir}/${kerncvs_branch}"
if ! pushd "${hv_dir}/${ignore_revspec_dir}/${kerncvs_branch}" > /dev/null
then
	exit 1
fi
ignore_revspec_dir=$PWD
popd > /dev/null
#
mkdir -vp "${hv_dir}/${missing_patch_dir}/${kerncvs_branch}/${upstream_remote}/${upstream_branch}"
if ! pushd "${hv_dir}/${missing_patch_dir}/${kerncvs_branch}/${upstream_remote}/${upstream_branch}" > /dev/null
then
	exit 1
fi
missing_patch_dir=$PWD
pwd
for p in *
do
	do_rm=
	case "${p}" in
		*~) rm -fv "${p}" ; continue ;;
	esac
	test -L "${p}" || do_rm=true
	test -f "${p}" || do_rm=true
	if test -z "${do_rm}"
	then
		revspec=`awk '/^Git-commit:[[:blank:]]+/ { print $2 }' "${p}"`
		if test -z "${revspec}"
		then
			echo "${p} has no Git-commit line"
		else
			patch_name="`readlink -f \"${p}\"`"
			if test "${p}" != "${patch_name##*/}"
			then
				do_rm=true
			else
				missing_patch_list[${revspec}]="${missing_patch_dir}/${p}"
			fi
		fi
	fi
	test -n "${do_rm}" && rm -fv "${p}"
done
popd > /dev/null
#
mkdir -vp "${hv_dir}/${missing_revspec_dir}/${kerncvs_branch}/${upstream_remote}/${upstream_branch}"
if ! pushd "${hv_dir}/${missing_revspec_dir}/${kerncvs_branch}/${upstream_remote}/${upstream_branch}" > /dev/null
then
	exit 1
fi
missing_revspec_dir=$PWD
pwd
for revspec in *
do
	do_rm=
	case "${revspec}" in
		*~) rm -fv "${revspec}" ; continue ;;
	esac
	test -L "${revspec}" || do_rm=true
	test -f "${revspec}" || do_rm=true
	if test -z "${do_rm}"
	then
		p="`readlink -f \"${revspec}\"`"
		if test -f "${p}"
		then
			missing_revspec_list[${revspec}]="${p}"
		else
			echo "${revspec} target '${p}' does not exist"
			do_rm=true
		fi
	fi
	test -n "${do_rm}" && rm -fv "${revspec}"
done
popd > /dev/null
#
mkdir -vp "${hv_dir}/${revspec_dir}/${kerncvs_branch}"
if ! pushd "${hv_dir}/${revspec_dir}/${kerncvs_branch}" > /dev/null
then
	exit 1
fi
kerncvs_revspec=$PWD
popd > /dev/null
#
mkdir -vp "${hv_dir}/${patch_dir}/${kerncvs_branch}"
if ! pushd "${hv_dir}/${patch_dir}/${kerncvs_branch}" > /dev/null
then
	exit 1
fi
kerncvs_patch=$PWD
popd > /dev/null
#
if ! pushd "${hv_dir}/${revspec_dir}/${upstream_remote}/${upstream_branch}" > /dev/null
then
	exit 1
fi
upstream_revspec_dir=$PWD
#
count=0
for revspec in *
do
	case "${revspec}" in
		*~) rm -vf "${revspec}" ; continue ;;
	esac
	test -e "${revspec}" || continue
	test -L "${revspec}" || continue
	test -f "${revspec}" || continue
	grep -im1 ^Patch-mainline: ${revspec} | sed 's@^\([^:]\+:[[:blank:]]*v\)\([0-9]\+\)\.\([^-]\+\)\(.*\)@\2 \3@' > "${tmpdir}/$PPID.$$"
	read pmaj pmin rest < "${tmpdir}/$PPID.$$"
	if test "${pmaj}" -gt "${maj_tag}" || ( test "${pmaj}" -eq "${maj_tag}" && test "${pmin}" -gt "${min_tag}" )
	then
		pn=`readlink -f "${revspec}"`
		revspec_names[${revspec}]="${pn##*/}"
		count=$(( count + 1 ))
	fi
done
echo "${count} upstream patches to consider"
popd > /dev/null
if ! pushd "${kerncvs_dir}" > /dev/null
then
	exit 1
fi
for revspec in ${!revspec_names[@]}
do
	: revspec ${revspec}
	if test -e "${ignore_revspec_dir}/${revspec}"
	then
		: "${revspec} is on ignore list"
		id_upstream_patch="`readlink -f \"${ignore_revspec_dir}/${revspec}\"`"
		id_missing_revspec="`readlink -f \"${missing_revspec_dir}/${revspec}\"`"
		if test "${id_upstream_patch}" = "${id_missing_revspec}"
		then
			rm -fv "${missing_revspec_dir}/${revspec}"
		fi
		for i in ${missing_patch_dir}/*
		do
			if test -L "${i}"
			then
				id_missing_patch="`readlink -f \"${i}\"`"
				if test "${id_upstream_patch}" = "${id_missing_patch}"
				then
					rm -fv "${i}"
				fi
			fi
		done
		unset revspec_names[${revspec}]
		continue
	fi
	patches="`git grep --threads ${numcpus} --extended-regexp --files-with-matches \"Git-commit:[[:blank:]]${revspec}\" || :`"
	if test -n "${patches}"
	then
		: "${revspec} merged: ${patches} "
		if test -e "${missing_revspec_dir}/${revspec}"
		then
			echo "merged ${_} `readlink \"${_}\"` `readlink -f \"${_}\"`"
			echo "${missing_revspec_list[${revspec}]}"
			rm -fv "${missing_revspec_dir}/${revspec}"
		fi
		unset revspec_names[${revspec}]
		continue
	fi
done
echo "${#revspec_names[@]} upstream patches to consider"
: "${!revspec_names[@]}"
: "${revspec_names[@]}"
for revspec in ${!revspec_names[@]}
do
	do_symlink "${upstream_revspec_dir}/${revspec}" "${missing_revspec_dir}/${revspec}"
	do_symlink "${missing_revspec_dir}/${revspec}" "${missing_patch_dir}/${revspec_names[${revspec}]}"
done


exit 0
