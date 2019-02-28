#!/bin/bash
#set -e
#set -x
unset LANG
unset ${!LC_*}
redo_patch="olh-kerncvs-redo_patch_from_mainline"
patch_dir=patch
revspec_dir=revspec
tmpdir=
topdir=
script_dir=
upstream_git=
upstream_remote=
upstream_branch=
Linux_remote=
Linux_branch=
hv_dir=
numcpus=`grep -Ec '^cpu[0-9]' /proc/stat || echo 1`
outdir=
_tag_to=
_tag_from=
from_to=
revspec=
upstream_patch_dir=
upstream_revspec_dir=
Linux_patch_dir=
Linux_revspec_dir=
pn=
old=
old_num=
old_nam=
new=
new_num=
new_nam=
nam=
pd=
ignore_Linux_patches=
declare -i count=0
declare -A new_patch_names
declare -A old_patch_names
declare -A new_patch_redo
declare -A new_patch_copy
#
do_symlink() {
	local link_dest=$1
	local symlink=$2
	local p="$(realpath --relative-to=${symlink%/*} ${link_dest%/*} )/${link_dest##*/}"
	ln --symbolic --force "$p" "${symlink}"
}
do_redo() {
	echo "redoing in ${PWD}"
	ls -1 ${@} | xargs \
			--no-run-if-empty \
			-P "${numcpus}" \
			-n "$(( ( (${#new_patch_redo[@]} / ${numcpus}) / 2 ) + 1 ))" \
		bash "${script_dir}/${redo_patch}" \
			--topdir "${topdir}" \
			--upstream_git "${upstream_git}" \
			--tmpdir "${tmpdir}"
}
#
while test $# -gt 0
do
	: "$1" "$2"
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
		--Linux_remote)
		Linux_remote=$2
		shift
		;;
		--Linux_branch)
		Linux_branch=$2
		shift
		;;
		--hv_dir)
		hv_dir=$2
		shift
		;;
		--script_dir)
		script_dir=$2
		shift
		;;
	esac
	shift
done
if test -z "${tmpdir}"
then
	tmpdir=`mktemp --directory --tmpdir=/dev/shm/ XXX`
	trap 'rm -rf "${tmpdir}"' EXIT
fi
outdir="${tmpdir}/${upstream_git}/${upstream_remote}/${upstream_branch}"
upstream_patch_dir="${patch_dir}/${upstream_remote}/${upstream_branch}"
upstream_revspec_dir="${revspec_dir}/${upstream_remote}/${upstream_branch}"
#
if test -z "${tmpdir}" || test -z "${topdir}" || test -z "${upstream_git}" || test -z "${upstream_remote}" || test -z "${upstream_branch}" || test -z "${hv_dir}"
then
	echo "Usage: $0 <opts>"
	exit 1
fi
if test -n "${Linux_remote}" && test -n "${Linux_branch}"
then
	if test "${Linux_remote}" != "${upstream_remote}"
	then
		echo "Ignoring patches in ${Linux_remote}/${Linux_branch}"
		ignore_Linux_patches=true
		Linux_patch_dir="${patch_dir}/${Linux_remote}/${Linux_branch}"
		Linux_revspec_dir="${revspec_dir}/${Linux_remote}/${Linux_branch}"
	fi
fi
#
if ! pushd "${topdir}" > /dev/null
then
	exit 1
fi
#
if ! pushd "${upstream_git}" > /dev/null
then
	exit 1
fi
popd > /dev/null
#
mkdir -vp "${hv_dir}/${upstream_patch_dir}"
if ! pushd "${hv_dir}/${upstream_patch_dir}" > /dev/null
then
	exit 1
fi
upstream_patch_dir=$PWD
popd > /dev/null
#
mkdir -vp "${hv_dir}/${upstream_revspec_dir}"
if ! pushd "${hv_dir}/${upstream_revspec_dir}" > /dev/null
then
	exit 1
fi
popd > /dev/null
#
rm -rf "${outdir}"
mkdir -p "${outdir}"
_tag_from="v3.0"
if test -n "${ignore_Linux_patches}"
then
	_tag_to=`git --git-dir="${upstream_git}/.git" rev-list --max-count=1 ${upstream_remote}/${upstream_branch}`
	from_to="${_tag_from}..${_tag_to}"
else
	_tag_to=`git --git-dir="${upstream_git}/.git" describe --abbrev=0 --tags ${upstream_remote}/${upstream_branch}`
	from_to="${_tag_from}..${_tag_to}"
fi
echo "${upstream_remote}/${upstream_branch} up to: '${_tag_from}..${_tag_to}'"
$(type -P time) \
git --git-dir="${upstream_git}/.git" \
	format-patch \
	--no-signature \
	--output-directory ${outdir} \
	--break-rewrites \
	--keep-subject \
	--stat=-1,-1 \
	--stat-graph-width=-1 \
	--summary \
	--no-merges \
	${from_to} -- \
		arch/x86/hyperv \
		arch/x86/include/asm/hyperv-tlfs.h \
		arch/x86/include/asm/hyperv.h \
		arch/x86/include/asm/mshyperv.h \
		arch/x86/include/asm/trace/hyperv.h \
		arch/x86/include/uapi/asm/hyperv.h \
		arch/x86/kernel/cpu/mshyperv.c \
		arch/x86/kvm/hyperv.c \
		drivers/hid/hid-hyperv.c \
		drivers/hv \
		drivers/input/serio/hyperv-keyboard.c \
		drivers/iommu/hyperv_iommu.c \
		drivers/iommu/hyperv-iommu.c \
		drivers/net/hyperv \
		drivers/pci/controller/pci-hyperv.c \
		drivers/pci/host/hv_pcifront.c \
		drivers/pci/host/pci-hyperv.c \
		drivers/scsi/storvsc_drv.c \
		drivers/uio/uio_hv_generic.c \
		drivers/video/fbdev/hyperv_fb.c \
		drivers/video/hyperv_fb.c \
		include/linux/hyperv.h \
		include/net/af_hvsock.h \
		include/uapi/linux/hyperv.h \
		net/hv_sock \
		tools/hv \
		drivers/staging/hv \
		&> "${tmpdir}/$$"
#
pushd "${outdir}" > /dev/null
	# collect info about current list of patches
	for p in *.patch
	do
		revspec=`grep -m1 '^From ' "$p" | awk '{ print $2}'`
		new_patch_names[${revspec}]="msft-hv-${p##*/}"
		new_patch_copy[${revspec}]=${new_patch_names[${revspec}]}
		mv "${p}" "${new_patch_names[${revspec}]}"
		count=$(( count + 1 ))
	done
	echo "${count} patches exported"
popd > /dev/null
#
if test -n "${ignore_Linux_patches}"
then
	count=0
	for revspec in ${!new_patch_names[@]}
	do
		if test -e "${hv_dir}/${Linux_revspec_dir}/${revspec}"
		then
			count=$(( count + 1 ))
			: "${revspec} ${pn##*/} is upstream"
			if test -e "${hv_dir}/${upstream_revspec_dir}/${revspec}"
			then
				pn="`readlink -f ${hv_dir}/${upstream_revspec_dir}/${revspec}`"
				rm -fv "${pn}" "${hv_dir}/${upstream_revspec_dir}/${revspec}"
			fi
			unset new_patch_names[${revspec}]
			unset new_patch_copy[${revspec}]
		fi
	done
	echo "${count} already upstream"
fi
#
if pushd "${hv_dir}/${upstream_revspec_dir}" > /dev/null
then
	# walk through existing exported patches
	pwd
	count=0
	for p in *
	do
		# catch empty dir
		test -e "${p}" || continue

		unset revspec
		unset revspec_exists

		case "${p}" in
			# drop backup files
			*~) rm -f "${p}" ; continue ;;
		esac

		count=$(( count + 1 ))

		# this entry should probably be removed
		if test -z "${new_patch_names[${p}]}"
		then
			echo "${p} is stale"
		fi
		# this entry should probably be removed
		if ! test -L "${p}"
		then
			echo "${p} is not a symlink"
			continue
		fi

		if test -f "${p}"
		then
			revspec=`grep -m1 Git-commit: ${p} | awk '{ print $2}'`
			if test -z "${revspec}"
			then
				# oddly formated patch, it has to be redone
				echo "${p} lacks Git-commit: tag"
				rm -fv "`readlink -f \"${p}\"`" "${p}"
				continue
			fi
			if test "${p}" != "${revspec}" && test -n "${revspec}"
			then
				# oddly formated patch, it has to be redone
				echo "${p} refers to revspec ${revspec}"
				continue
			fi
			revspec_exists=${revspec}
		else
			echo "${p} target does not exist"
			# redo patch if revspec is known
			if test -z "${new_patch_names[${p}]}"
			then
				continue
			fi
		fi
		: ${p} is valid
		revspec=$p

		pn="`readlink -f ${p}`"
		old_patch_names[${revspec}]="${pn##*/}"
		if test -n "${new_patch_names[${revspec}]}"
		then
			# if this patch has a tag, assume this patch is fully exported
			if test -n "${revspec_exists}" && grep -qm1 '^Git-commit:' "${revspec}"
			then
				unset new_patch_copy[${revspec}]
			else
				new_patch_redo[${revspec}]=${new_patch_names[${revspec}]}
			fi
			#
			if test "${new_patch_names[${revspec}]}" != "${old_patch_names[${revspec}]}"
			then
				# rename existing patch to follow new number, from git format-patch
				old=${old_patch_names[${revspec}]}
				old=${old#*-}
				old=${old#*-}
				old_num=${old%%-*}
				old_nam=${old#*-}
				old_nam=${old_nam%.*}
				new=${new_patch_names[${revspec}]}
				new=${new#*-}
				new=${new#*-}
				new_num=${new%%-*}
				new_nam=${new#*-}
				new_nam=${new_nam%.*}
				if test "${old_nam}" = "${new_nam}"
				then
					nam="${old_nam}"
				else
					nam="${old_nam} -> ${new_nam}"
				fi
				echo "${revspec}: ${old_num} -> ${new_num} ${nam}"
				pd=${pn%/*}
				echo mv -vi "${pn##*/}" "${new_patch_names[${revspec}]}"
				mv -vi "${pn}" "${pd}/${new_patch_names[${revspec}]}"
				do_symlink "${upstream_patch_dir}/${new_patch_names[${revspec}]}" "$PWD/${revspec}"
				if ! test -e "${revspec}"
				then
					echo "dead link to ${new_patch_names[${revspec}]}"
				fi
			fi
		fi
	done

	count=0
	for revspec in ${!new_patch_names[@]}
	do
		test -n "${old_patch_names[${revspec}]}" && continue
		: revspec ${revspec}
		count=$(( count + 1 ))
	done
	echo "${count} new patches ; ${#new_patch_redo[@]} to redo ; ${#new_patch_copy[@]} to copy"

	popd > /dev/null
fi
#
if test "${#new_patch_redo[@]}" -gt 0
then
	pushd "${outdir}" > /dev/null
		do_redo ${new_patch_redo[@]}
		echo "${#new_patch_redo[@]} adjusted"
	popd > /dev/null
fi
#
pushd "${hv_dir}/${upstream_revspec_dir}" > /dev/null
	for revspec in ${!new_patch_redo[@]}
	do
		if test -L "${revspec}"
		then
			if cmp -s "${revspec}" "${outdir}/${new_patch_redo[${revspec}]}"
			then
				unset new_patch_copy[${revspec}]
				continue
			fi
			diff -u "${revspec}" "${outdir}/${new_patch_redo[${revspec}]}"
		else
			echo "${revspec} missing"
		fi
	done
	if test "${#new_patch_copy[@]}" -gt 0
	then
		echo "${#new_patch_copy[@]} to copy"
		pushd "${outdir}" > /dev/null
			do_redo ${new_patch_copy[@]}
		popd > /dev/null
		echo "${#new_patch_copy[@]} adjusted"
	fi
	for revspec in ${!new_patch_copy[@]}
	do
		if test -f "${revspec}"
		then
			cat "${outdir}/${new_patch_copy[${revspec}]}" > "${revspec}"
		else
			cp -avit   "${upstream_patch_dir}" "${outdir}/${new_patch_copy[${revspec}]}"
			do_symlink "${upstream_patch_dir}/${new_patch_copy[${revspec}]}" "$PWD/${revspec}"
		fi
	done
popd > /dev/null
