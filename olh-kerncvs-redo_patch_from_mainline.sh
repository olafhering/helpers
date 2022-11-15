#!/bin/bash
#set -e
#set -x
#
unset LANG
unset ${!LC_*}
tmpdir=
topdir=
script_dir=
upstream_git=
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
		--script_dir)
		script_dir=$2
		shift
		;;
		*)
		break
		;;
	esac
	shift
done
if test -z "${tmpdir}"
then
	exit 1
fi
upstream=
td=`mktemp --directory --tmpdir=${tmpdir}`
trap 'rm -rf "${td}"' EXIT

if pushd "${topdir}" > /dev/null
then
	if pushd "${upstream_git}" > /dev/null
	then
		if test -d .git
		then
			upstream=$PWD
		fi
		popd > /dev/null
	fi
	popd > /dev/null
fi
if test -z "${upstream}"
then
	exit 1
fi
process_patch_file() {
	local pf=$1
	local header="${td}/header"
	local msg_rest="${td}/msg_rest"
	local extra_tags="${td}/extra_tags"
	local upstream_commit="${td}/upstream_commit"
	local t="${td}/t"
	local commit_id
	local tag

	sed '/^[[:blank:]]*$/Q' "${pf}" > "${header}"
	sed -n '/^$/ { : nl ; n ; p ; b nl }' "${pf}" > ${msg_rest}
	grep -Evi '^(From |(From|Date|Patch-mainline|Subject|Git-commit):|[[:blank:]])' \
		"${header}" > "${extra_tags}"

	commit_id="`grep -im1 ^Git-commit: \"${header}\" | awk '{ print $2 }'`"
	if test -z "${commit_id}"
	then
		commit_id="`grep -im1 '^From ' \"${header}\" | awk '{ print $2 }'`"
	fi
	if test -z "${commit_id}"
	then
		echo "No commit id for '${pf}'"
		return
	fi
	if test -n "${commit_id}" && pushd "${upstream}" > /dev/null
	then
		git format-patch \
			--no-signature \
			--stdout \
			--break-rewrites \
			--no-renames \
			--keep-subject \
			--stat-width=88 \
			--stat-name-width=77 \
			--stat-count=1234 \
			--stat-graph-width=9 \
			--summary \
			"${commit_id}^..${commit_id}" > "${upstream_commit}"
		tag=`git tag --sort=taggerdate --contains  ${commit_id} | sed q`
		if test -z "${tag}"
		then
			tag=`git describe ${commit_id} | cut -f 1 -d '~'`
		fi
		popd > /dev/null
	fi
	#
	if test -z "${tag}"
	then
		tag="`grep -i ^Patch-mainline: \"${header}\" | cut -f2 -d :`"
	fi
	#
#	head ${pf} "${upstream_commit}"
	if ! test -s "${upstream_commit}"
	then
		cat "${pf}" > "${upstream_commit}"
	fi
	if test -s "${upstream_commit}"
	then
		sed -n '/^From: / { p ; Q }' ${upstream_commit} >> ${t}
		grep -m1 ^Date: ${upstream_commit} >> ${t}
		if test -n "${tag}"
		then
			echo "Patch-mainline: ${tag}" >> ${t}
		fi
		if grep -q '^References:' "${extra_tags}"
		then
			:
		else
			echo 'References: git-fixes' >> "${extra_tags}"
		fi
		sed -n '/^Subject:/ { h ; n ; /^[[:blank:]]\+/H ; x ; s@\n[[:blank:]]\+@ @g; p ; Q }' ${upstream_commit} >> ${t}
		sed -n '/^From / { s@\(From \)\([^[:blank:]]\+\)\(.*\)@Git-commit: \2@p ; Q }' ${upstream_commit} >> ${t}
		cat "${extra_tags}" >> ${t}
		sed -n "/^$/ { p ; : nl ; n ; p ; b nl }" ${upstream_commit} >> ${t}
		sed -i '/^index[[:blank:]][0-9a-f]\+\.\.[0-9a-f]\+[[:blank:]][0-7]\+$/d' ${t} 
		sed -i '/^---$/{ x ; s|^.*|Acked-by: Olaf Hering <ohering@suse.de>| ; G ; }' ${t} 
#		diff -u ${pf} ${t} || :
		mv -f ${t} ${pf}
	fi
	rm -f "${header}" "${msg_rest}" "${extra_tags}" "${upstream_commit}" "${t}"
}

for patch_file in "$@"
do
	: patch_file "${patch_file}"
	if test -r "${patch_file}"
	then
		echo -n .
		process_patch_file "${patch_file}"
	fi
done
