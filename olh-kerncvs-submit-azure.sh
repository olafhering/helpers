#!/bin/bash
# vim: ts=2 shiftwidth=2 noexpandtab nowrap
# Usage: $0 [-s N] [-e] DIST
# -s N will supersede an existing request, in case N is in state new|review
# -e will submit from the *_EMBARGO branch
set -e
unset LANG
unset ${!LC_*}
#
pkg='kernel-source-azure'
dist=
pkg_rev=
pkg_date=
pkg_githash=
declare -i supersede=0
declare -i counter
declare -a osc_sr_cmd
declare -a osc_sr_cmd_args
osc_sr_cmd_args_str=
#
while test $# -gt 0
do
	case "$1" in
	-s) supersede=$2 ; shift ;;
	-e) use_embargo_branch='yes' ;;
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
sle12sp5() {
	branch='SLE12-SP5-AZURE'
	embargo='SLE12-SP5-AZURE_EMBARGO'
	kerncvs_prj='Devel:Kernel:SLE12-SP5-AZURE'
	kerncvs_prj_embargo='Devel:Kernel:SLE12-SP5-AZURE_EMBARGO'
	update_prj='SUSE:SLE-12-SP5:Update'
}
#
sle15sp4() {
	branch='SLE15-SP4-AZURE'
	embargo='SLE15-SP4-AZURE_EMBARGO'
	kerncvs_prj='Devel:Kernel:SLE15-SP4-AZURE'
	kerncvs_prj_embargo='Devel:Kernel:SLE15-SP4-AZURE_EMBARGO'
	update_prj='SUSE:SLE-15-SP4:Update'
}
sle15sp5() {
	branch='SLE15-SP5-AZURE'
	embargo='SLE15-SP5-AZURE_EMBARGO'
	kerncvs_prj='Devel:Kernel:SLE15-SP5-AZURE'
	kerncvs_prj_embargo='Devel:Kernel:SLE15-SP5-AZURE_EMBARGO'
	update_prj='SUSE:SLE-15-SP5:Update'
}
sle15sp6() {
	branch='SLE15-SP6-AZURE'
	embargo='SLE15-SP6-AZURE_EMBARGO'
	kerncvs_prj='Devel:Kernel:SLE15-SP6-AZURE'
	kerncvs_prj_embargo='Devel:Kernel:SLE15-SP6-AZURE_EMBARGO'
	update_prj='SUSE:SLE-15-SP6:GA'
}
#
case "${dist}" in
sle12sp5|SLE12SP5|SLE12-SP5) sle12sp5 ;;
sle15sp4|SLE15SP4|SLE15-SP4) sle15sp4 ;;
sle15sp5|SLE15SP5|SLE15-SP5) sle15sp5 ;;
sle15sp6|SLE15SP6|SLE15-SP6) sle15sp6 ;;
*) echo "Unknown dist '${dist}'" ; exit 1 ;;
esac
#
src_prj="${kerncvs_prj}"
test -n "${use_embargo_branch}" && src_prj="${kerncvs_prj_embargo}"
#
case "${update_prj}" in
*:GA)
	osc_rq_type='submitrequest'
	ibs rq list "${update_prj}" "${pkg}"
;;
*:Update) osc_rq_type='submitrequest' ;; # maintenancerequest does not work because it lacks options understood by submit
*) echo "Unhandled suffix for ${update_prj}" ; exit 1 ;;
esac
#
#----------------------------------------------------------------------------$
#rN | user | YYYY-MM-DD HH:MM:SS | src_hash | a.b.c | $
#$
#commit git_hash$
#----------------------------------------------------------------------------$
counter=0
got_line=
got_pkg_rev=
while read
do
	: $(( counter++ ))
	case "${REPLY}" in
	---------*) got_line='yes' ;;
	r[0-9]*)
		if test -z "${got_line}"
		then
			echo "Missing separator line in ${src_prj} ${pkg}"
			exit 1
		fi
		got_pkg_rev='yes'
		values=( ${REPLY} )
		pkg_rev="${values[0]}"
		pkg_rev="${pkg_rev:1}"
		pkg_date="${values[4]} ${values[5]}"
	;;
	"")
		if test -z "${got_line}" && test -z "${got_pkg_rev}"
		then
			echo "Missing blank line in ${src_prj} ${pkg}"
			exit 1
		fi
	;;
	commit*)
		values=( ${REPLY} )
		pkg_githash="${values[1]}"
		break
	;;
	esac
	test ${counter} -gt 6 && break
done < <(ibs log "${src_prj}" "${pkg}")
if test ${counter} -gt 6
then
	echo "Failed to parse 'osc log ${src_prj} ${pkg}':"
	ibs log "${src_prj}" "${pkg}" | head
	exit 1
fi

echo "revspec ${pkg_githash}, rev ${pkg_rev} @ ${pkg_date}"
echo "revspec ${pkg_githash:0:12}"
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
echo "Done with rc $?"
