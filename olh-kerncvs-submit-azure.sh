#!/bin/bash
# vim: ts=2 shiftwidth=2 noexpandtab nowrap
# Usage: $0 [-s N] [-e] [-l] [-r N] DIST
# -s N will supersede an existing request, in case N is in state new|review
# -e will submit from the *_EMBARGO branch
# -l will just run osc log
# -r N will submit the specified pkg revision
set -e
unset LANG
unset ${!LC_*}
#
build_service_user='olh'
pkg='kernel-source-azure'
dist=
gitea_githash=
pkg_rev=
pkg_date=
pkg_githash=
pkg_show_log=
pkg_rev_requested=
declare -i supersede=0
declare -a osc_sr_cmd
declare -a osc_sr_cmd_args
osc_sr_cmd_args_str=
#
while test $# -gt 0
do
	case "$1" in
	-s) supersede=$2 ; shift ;;
	-e) use_embargo_branch='use_embargo_branch' ;;
	-l) pkg_show_log='pkg_show_log' ;;
	-r) pkg_rev_requested=$2 ; shift ;;
	-u) build_service_user=$2 ; shift ;;
	*)
		if test "$#" -gt 1 
		then
			echo "Trailing args $@"
			exit 1
		fi
		dist=$1
		break
	;;
	esac
	shift
done
#
git --no-pager version
ibs version
git-obs login list
#
sle16sp1() {
	branch='SL-16.1-AZURE'
	embargo='SL-16.1-AZURE_EMBARGO'
	kerncvs_prj='Devel:Kernel:SL-16.1-AZURE'
	kerncvs_prj_embargo='Devel:Kernel:SL-16.1-AZURE_EMBARGO'
	update_prj='SUSE:SLFO:Main'
	data_backend='buildservice'
	git_branch='slfo-main'
}
sle16sp0() {
	branch='SL-16.0-AZURE'
	embargo='SL-16.0-AZURE_EMBARGO'
	kerncvs_prj='Devel:Kernel:SL-16.0-AZURE'
	kerncvs_prj_embargo='Devel:Kernel:SL-16.0-AZURE_EMBARGO'
	update_prj='SUSE:SLFO:1.2'
	data_backend='git'
	git_branch='slfo-1.2'
}
sle15sp7() {
	branch='SLE15-SP7-AZURE'
	embargo='SLE15-SP7-AZURE_EMBARGO'
	kerncvs_prj='Devel:Kernel:SLE15-SP7-AZURE'
	kerncvs_prj_embargo='Devel:Kernel:SLE15-SP7-AZURE_EMBARGO'
	update_prj='SUSE:SLE-15-SP7:Update'
	data_backend='buildservice'
}
#
case "${dist}" in
sle16sp1|SLE16SP1|SLE16-SP1) sle16sp1 ;;
sle16sp0|SLE16SP0|SLE16-SP0) sle16sp0 ;;
sle15sp7|SLE15SP7|SLE15-SP7) sle15sp7 ;;
*) echo "Unknown dist '${dist}'" ; exit 1 ;;
esac
#
src_prj="${kerncvs_prj}"
test -n "${use_embargo_branch}" && src_prj="${kerncvs_prj_embargo}"
#
case "${update_prj}" in
SUSE:SLFO:Main)
	osc_rq_type='submitrequest'
	ibs rq list "${update_prj}" "${pkg}"
;;
*:GA)
	osc_rq_type='submitrequest'
	ibs rq list "${update_prj}" "${pkg}"
;;
*:Update) osc_rq_type='submitrequest' ;; # maintenancerequest does not work because it lacks options understood by submit
SUSE:SLFO:1.2)
	echo "ibs log '${update_prj}' '${pkg}'"
	ibs log "${update_prj}" "${pkg}"
;;
*) echo "Unhandled suffix for ${update_prj}" ; exit 1 ;;
esac
if test -n "${pkg_show_log}"
then
	echo "ibs log '${src_prj}' '${pkg}'"
	ibs log "${src_prj}" "${pkg}"
	exit 0
fi
if test -n "${pkg_rev_requested}"
then
	case "${pkg_rev_requested}" in
	[0-9]*) ;;
	r[0-9]*) pkg_rev_requested="${pkg_rev_requested:1}" ;;
	*) echo "Unhandled pkg rev requested: ${pkg_rev_requested}" ; exit 1 ;;
	esac
fi
#
# since  2025-12-04:
#----------------------------------------------------------------------------$
#rN | user | YYYY-MM-DD HH:MM:SS | src_hash | a.b.c | $
#$
#[info=gitea_hash]
#----------------------------------------------------------------------------$
# up to 2025-12-03
#----------------------------------------------------------------------------$
#rN | user | YYYY-MM-DD HH:MM:SS | src_hash | a.b.c | $
#$
#commit git_hash$
#----------------------------------------------------------------------------$
got_line=
got_pkg_rev=
requested_pkg_rev_found=
while read
do
	case "${REPLY}" in
	---------*)
		got_line='got_line'
		pkg_rev=
		pkg_date=
	;;
	r[0-9]*)
		if test -z "${got_line}"
		then
			echo "Missing separator line in ${src_prj} ${pkg}"
			exit 1
		fi
		got_pkg_rev='got_pkg_rev'
		values=( ${REPLY} )
		pkg_rev="${values[0]}"
		pkg_rev="${pkg_rev:1}"
		pkg_date="${values[4]} ${values[5]}"
		if test -n "${pkg_rev_requested}"
		then
			if test "${pkg_rev_requested}" = "${pkg_rev}"
			then
				requested_pkg_rev_found='requested_pkg_rev_found'
			fi
		else
			requested_pkg_rev_found='requested_pkg_rev_found'
		fi
	;;
	"")
		if test -z "${got_line}" && test -z "${got_pkg_rev}"
		then
			echo "Missing blank line in ${src_prj} ${pkg}"
			exit 1
		fi
	;;
	\[info=*)
		if test -n "${got_line}" && test -n "${got_pkg_rev}" && test -n "${requested_pkg_rev_found}"
		then
			read pkg_githash < <(ibs cat -e -r "${pkg_rev}" "${src_prj}" "${pkg}" 'source-timestamp' | awk '/^GIT Revision: /{print $3}')
			: ${pkg_githash}
			break
		fi
	;;
	commit*)
		if test -n "${got_line}" && test -n "${got_pkg_rev}" && test -n "${requested_pkg_rev_found}"
		then
			values=( ${REPLY} )
			pkg_githash="${values[1]}"
			break
		fi
	;;
	*)
		unset got_line
		unset got_pkg_rev
	;;
	esac
done < <(ibs log "${src_prj}" "${pkg}")
if test -z "${pkg_githash}" || test -z "${pkg_rev}" || test -z "${pkg_date}"
then
	echo "Failed to parse 'ibs log ${src_prj} ${pkg}':"
	echo "pkg_githash '${pkg_githash}' pkg_rev '${pkg_rev}' pkg_date '${pkg_date}'"
	ibs log "${src_prj}" "${pkg}" | head -n 22
	exit 1
fi

echo "revspec ${pkg_githash}, rev ${pkg_rev} @ ${pkg_date}"
echo "revspec ${pkg_githash:0:12}"

case "${data_backend}" in
buildservice)
	osc_sr_cmd=(ibs ${osc_rq_type})
	if test "${supersede}" -ne 0
	then
		osc_sr_cmd_args+=( -s "${supersede}" )
	fi
	osc_sr_cmd_args+=( -r "${pkg_rev}" )
	osc_sr_cmd_args+=( -m "kernel-azure ${pkg_githash}" )
	osc_sr_cmd_args+=( --no-update )
	osc_sr_cmd_args+=( --no-cleanup )
	osc_sr_cmd_args+=( "${src_prj}" )
	osc_sr_cmd_args+=( "${pkg}" )
	osc_sr_cmd_args+=( "${update_prj}" )
	for i in "${osc_sr_cmd_args[@]}"
	do
		case "${i}" in
		-*) osc_sr_cmd_args_str+=" ${i}"   ;;
		*)  osc_sr_cmd_args_str+=" '${i}'" ;;
		esac
	done
	#
	while true
	do
		echo
		echo "Run the following command (Yes/No/Diff)?"
		echo "${osc_sr_cmd[@]}${osc_sr_cmd_args_str}"
		read -n 1
		case "${REPLY}" in
		y|Y) echo ; break ;;
		n|N) echo ; exit 1 ;;
		d|D)
			echo
			ibs rdiff "${update_prj}" "${pkg}" "${src_prj}" "${pkg}"
			;;
		esac
	done
	osc_sr_cmd+=( "${osc_sr_cmd_args[@]}" )
	echo
	"${osc_sr_cmd[@]}"
;;
git)
	git-obs --gitea-login ibs \
		pr list \
		--target-branch "${git_branch}" \
		--state open \
		"pool/${pkg}"
	if env -u LANG LC_ALL=C git-obs --gitea-login ibs \
		pr list \
		--export \
		--target-branch "${git_branch}" \
		--state open \
		"pool/${pkg}" 2>/dev/null| grep -E '^\[\]$'
	then
		echo "No open PR for 'pool/${pkg}'"
		read td < <(mktemp --directory --tmpdir=/dev/shm)
		trap "rm -rf '${td}'" EXIT
		pushd "${td}"
			ibs co -e -r "${pkg_rev}" "${kerncvs_prj}" "${pkg}"
			pushd "${kerncvs_prj}/${pkg}"
				ibs st
			popd
			git --no-pager clone --origin='ibs-pool' "gitea@src.suse.de:pool/${pkg}.git" "${pkg}.git"
			pushd "${pkg}.git"
				git --no-pager config set user.name 'Olaf Hering'
				git --no-pager config set user.email 'ohering@suse.de'
				git --no-pager remote add "ibs-${build_service_user}" "gitea@src.suse.de:olh/${pkg}.git"
				git --no-pager fetch --all --prune
				read current_branch < <(git --no-pager branch --show-current)
				if test "${current_branch}" != "${git_branch}"
				then
					git --no-pager branch --move "${git_branch}"
				fi
				git --no-pager reset --hard "ibs-${build_service_user}/${git_branch}"
				git --no-pager branch --set-upstream-to="ibs-pool/${git_branch}"
				git --no-pager log --oneline --max-count=1
				git --no-pager status
				git --no-pager rm --force --quiet -- *
				mv --target-directory=. "${td}/${kerncvs_prj}/${pkg}"/*
				git --no-pager add -- *
				git --no-pager status
				env TZ=UTC git commit -avsm "kernel-azure ${pkg_githash}"
				read gitea_githash < <(git --no-pager rev-list --max-count=1 HEAD)
				git log -p -M --stat --pretty=fuller -b -B -w
				git --no-pager push "ibs-${build_service_user}" 'HEAD'
				git-obs --gitea-login 'ibs' \
					pr create \
					--source-owner "${build_service_user}" \
					--source-repo "${pkg}" \
					--source-branch "${git_branch}" \
					--target-branch "${git_branch}" \
					--description "kernel-azure ${pkg_githash}" \
					--title "${pkg} ${git_branch} ${gitea_githash}"
			popd
		popd
	else
		echo "Pending PR for 'pool/${pkg}' found, aborting."
	fi
;;
esac
echo "Done with rc $?"
