#!/bin/bash
#set -e
#set -x
#
renice -n 11 -p "$$"
ionice --class 3 -p "$$"
unset LANG
unset ${!LC_*}
tmpdir=`mktemp --directory --tmpdir=/dev/shm/ XXX`
trap "rm -rf '${tmpdir}'" EXIT
test -z "${tmpdir}" && exit 1
script_dir=${0%/*}
case "${script_dir}" in
	*/*);;
	*) script_dir=. ;;
esac
pushd "${script_dir}" > /dev/null
script_dir=$PWD
popd >/dev/null
topdir=~/work/src/kernel
upstream_git=upstream.linux
hv_dir=hv-since-v3.0
kerncvs_branch=$1
kerncvs_dir="kerncvs.kernel-source.${kerncvs_branch}"
script_kerncvs="olh-kerncvs-extract_hyper_v_commits-${kerncvs_branch}"
script_mainline="olh-kerncvs-extract_hyper_v_commits-mainline"
Linux_remote="torvalds.linux.git"
Linux_branch="master"
do_mainline() {
	local remote=$1
	local branch=$2
	local L_remote=$3
	local L_branch=$4
	local opts=()

	if test -n "${L_remote}" && test -n "${L_branch}"
	then
		opts=( ${opts[@]} "--Linux_remote" "${L_remote}" "--Linux_branch" "${L_branch}" )
	fi

	bash "${script_dir}/${script_mainline}" \
		--topdir "$PWD" \
		--upstream_git "${upstream_git}" \
		--upstream_remote "$1" \
		--upstream_branch "$2" \
		--hv_dir "${hv_dir}" \
		--script_dir "${script_dir}" \
		${opts[@]} \
		--tmpdir "${tmpdir}"
}
if pushd ${topdir} > /dev/null
then
	if test -n "${kerncvs_branch}" 
	then
		if test -d "${kerncvs_dir}" && test -d "${kerncvs_dir}/.git"
		then
			bash "${script_dir}/${script_kerncvs}" \
				--topdir "$PWD" \
				--upstream_git "${upstream_git}" \
				--upstream_remote "${Linux_remote}" \
				--upstream_branch "${Linux_branch}" \
				--kerncvs_dir "${kerncvs_dir}" \
				--kerncvs_branch "${kerncvs_branch}" \
				--hv_dir "${hv_dir}" \
				--script_dir "${script_dir}" \
				--tmpdir "${tmpdir}"
				
		fi
	else
		if test -d ${upstream_git}/.git
		then
			if pushd "${upstream_git}" > /dev/null
			then
				time git --no-pager commit-graph write --reachable
				popd > /dev/null
			fi
			do_mainline "${Linux_remote}" "${Linux_branch}"
			remotes="
			davem.net.git
			davem.net-next.git
			gregkh.char-misc.git
			lpieralisi.pci.git
			helgaas.pci.git
			hyperv.linux.git
			joro.iommu.git
			"
			for remote in ${remotes}
			do
				branches="`git \"--git-dir=${upstream_git}/.git\" branch -a | sed -n "/${remote}/s@^[[:blank:]]\+remotes/${remote}/@@p"`"
				for branch in $branches
				do
					do_mainline "${remote}" "$branch" "${Linux_remote}" "${Linux_branch}"
				done
			done
		fi
	fi
fi
