#!/bin/bash
set -e
#et -x
unset LANG
unset ${!LC_*}
renice -n 19 -p $$
export TZ=UTC
export TMPDIR="`mktemp --directory --tmpdir=/dev/shm XXX`"
trap "rm -rf '${TMPDIR}'" EXIT
jobs=`grep -Ec 'cpu[0-9]' /proc/stat || echo 1`
make_jobs=${jobs}
if test -n "$1"
then
	if test "$1" = "modules_install"
	then
		make_jobs=1
	fi
	make_target=($@)
else
	make_target=all
fi
#
if test -d .git
then
	pushd . > /dev/null
elif test -d patches/.git
then
	pushd patches > /dev/null
else
	echo "${PWD##*/} not a git tree"
	exit 1
fi
read git_branch < <(git branch | awk '"*" == $1 { branch=substr($0, 3); gsub("/", "_", branch); print branch; }')
# (no branch, bisect started on fate317533-SLES11-SP4-r4)
# (no branch, rebasing users_ohering_SLE12-SP3-TD_bug1190464-ptf4)
: ${git_branch}
case "$git_branch" in
	*\ bisect\ started\ on\ *)
		git_branch="${git_branch##* bisect started on }"
		git_branch="${git_branch%)}"
	;;
	*\ rebasing\ *)
		git_branch="${git_branch##* rebasing }"
		git_branch="${git_branch%)}"
	;;
	*)
		if test -z "${git_branch}"
		then
			git_branch="no_branch"
		fi
	;;
esac
popd > /dev/null
#
bugnumber=${git_branch}
#
#
case "${HOSTNAME}" in
  *)
  kernel_module_output=/dev/shm/olaf/bug/${bugnumber}
  ;;
esac
I="${kernel_module_output}"
#
kernel_arch=x86_64
kernel_build_output=${kernel_arch}-O-${git_branch}
O="$PWD/../O/${kernel_build_output}"
make_opts=(
ARCH=${kernel_arch}
SUBLEVEL=321
EXTRAVERSION=
LOCALVERSION="-${bugnumber}"
quiet_cmd_modules_install=
INSTALL_MOD_PATH="${I}"
)
if strings /sbin/depmod |grep /usr/lib/modules/%s/modules.devname$
then
make_opts+=(
MODLIB='$(INSTALL_MOD_PATH)/usr/lib/modules/$(KERNELRELEASE)'
)
fi
#
do_copy() {
	local file_src=$1
	local file_dst=$2
	mkdir -vp "${file_dst%/*}"
	cp -avL --remove-destination \
		"${file_src}" \
		"${file_dst}"
}

cond_copy() {
	local file_src=$1
	local file_dst=$2

	if ! test -f "${file_src}"
	then
		: MISSING
	elif ! test -f "${file_dst}"
	then
		do_copy \
			"${file_src}" \
			"${file_dst}"
	elif test "${file_src}" -nt "${file_dst}"
	then
		do_copy \
			"${file_src}" \
			"${file_dst}"
	fi
}

#

mkdir -vp "${O}"
if test -d "${O}" && test -f .config
then
	if test -f "${O}/.config"
	then
		mv -fv .config config.$PPID
	else
		sed -i /_DEBUG_INFO/d .config
		sed -i /CONFIG_MODULE_SIG_KEY=/d .config
		echo '# CONFIG_DEBUG_INFO is not set' >> .config
		echo '# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set' >> .config
		echo '# CONFIG_DEBUG_INFO_DWARF4 is not set' >> .config
		echo '# CONFIG_DEBUG_INFO_DWARF5 is not set' >> .config
		echo 'CONFIG_DEBUG_INFO_NONE=y' >> .config
		echo 'CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"' >> .config
		mv -vi .config "${O}/.config"
	fi
fi
make \
	-j ${make_jobs} \
	"O=${O}" \
	${make_opts[@]} \
	${make_target[@]}
#
if test -d ../unmodified_drivers/linux-2.6 && pushd "$_"
then
	if test "${make_target[@]}" = "all"
	then
		make_target="modules"
		find -type l -delete
	fi
	B="`ls -d ${I}/lib/modules/3*/build`"
	env \
		XL="${B}/source" \
		XEN="${B}/source/include/xen" \
		bash mkbuildtree
	make \
		-j ${make_jobs} \
		-C "${B}" \
		M="${PWD}" \
		INSTALL_MOD_DIR="update" \
		${make_opts[@]} \
		${make_target[@]}
	popd
fi
#
if ls -ld ${I}{,/usr}/lib/modules/*${bugnumber}* &> /dev/null
then
  find ${I}{,/usr}/lib/modules/*${bugnumber}* -name "*.ko" -print0 | xargs --no-run-if-empty -0 -n 1 -P ${jobs} strip --strip-debug
fi
#
if test "$1" = "modules_install"
then
	cond_copy \
		"${O}/arch/x86_64/boot/bzImage" \
		"${I}/boot/vmlinuz${suffix}"
	cond_copy \
		"${O}/System.map" \
		"${I}/boot/System.map${suffix}"
	cond_copy \
		"${O}/.config" \
		"${I}/boot/config${suffix}"
fi

create_copy_script() {
	local script=$1
	local sfx=$2
	local t=`mktemp`

	cat > "${t}" <<-EOF
#!/bin/bash
set -e
unset LANG
unset \${!LC_*}

pushd \${0%/*}
suffix="${sfx}"
kernel=boot/vmlinuz\${suffix}
sysmap=boot/System.map\${suffix}
config=boot/config\${suffix}
kver=\` get_kernel_version \$kernel \`
vmlinuz=vmlinuz-\$kver
initrd=initrd-\$kver
smap=System.map-\$kver
conf=config-\$kver
splash=
mods_file=/etc/modprobe.d/99-local.conf
mods=true

rm -fv /etc/modprobe.d/unsupported-modules
if test -f \$mods_file
then
  if grep -w ^allow_unsupported_modules \$mods_file
  then
    mods=false
  fi
fi
if \$mods
then
  echo "allow_unsupported_modules 1" >> \$mods_file
fi
cp -avL --remove-destination \$kernel /boot/\$vmlinuz
cp -avL --remove-destination \$sysmap /boot/\$smap
cp -avL --remove-destination \$config /boot/\$conf
if test -d lib/modules/\$kver
then
  rsync -a --delete \$_ /lib/modules/
elif test -d usr/lib/modules/\$kver
then
  rsync -a --delete \$_ /usr/lib/modules/
fi
if test -f /lib/mkinitrd/scripts/setup-splash.sh
then
  splash="-s 1x1"
fi
depmod -a \$kver
modules=
for dir in /sys/block/*/device /sys/class/net/*/device
do
  if pushd \${dir} > /dev/null
  then
    cd -P \$PWD
    until test "\$PWD" = "/"
    do
      if test -f modalias 
      then
        read modalias < modalias
        modalias=\$(modinfo --set-version "\$kver" "\${modalias}" | sed -n '/^filename:/{s@^.*/@@;s@\.ko\$@@p}' | xargs)
        modules="\${modules} \${modalias}"
      fi
      cd ..
    done
    popd > /dev/null
  fi
done
popd > /dev/null
if command -V mkinitrd
then
  time mkinitrd -k \$vmlinuz -i \$initrd \$splash -m "xen:vbd xen:vif \${modules}"
elif command -V dracut
then
  add_drivers=()
  for module in xen:vbd xen:vif \${modules}
  do
    add_drivers+=('--add-drivers' "\${module}")
  done
  time dracut --force \${add_drivers[@]} /boot/\$initrd \$kver
  time grub2-mkconfig -o /boot/grub2/grub.cfg 
fi
rm -fv /boot/custom.grub-\$kver.cfg
cat > /boot/custom.grub-\$kver.cfg <<_EOGC_
menuentry '\$kver' {
  insmod part_msdos
  insmod btrfs
  insmod ext2
  search --no-floppy --set=my_kern -f /boot/\$vmlinuz
  search --no-floppy --set=my_ramd -f /boot/\$initrd
  if  [ -n "\\\${my_kern}" -a -n "\\\${my_ramd}" -a "\\\${my_kern}" = "\\\${my_ramd}" ] ; then
    set root="\\\${my_kern}"
    echo	'Loading \$vmlinuz ...'
    linux /boot/\$vmlinuz placeholder sysrq_always_enabled panic=9 console=hvc0
    echo	'Loading \$initrd ...'
    initrd /boot/\$initrd
    echo	'Go'
  else
    echo "\$vmlinuz or \$initrd NOT found"
  fi
}
menuentry 'Xen \$kver' {
  insmod part_msdos
  insmod btrfs
  insmod ext2
  search --no-floppy --set=my_kern -f /boot/\$vmlinuz
  search --no-floppy --set=my_ramd -f /boot/\$initrd
  search --no-floppy --set=my_xen  -f /boot/xen.gz
  if  [ -n "\\\${my_xen}" -a  -n "\\\${my_kern}" -a -n "\\\${my_ramd}" -a "\\\${my_kern}" = "\\\${my_ramd}" ] ; then
    set root="\\\${my_kern}"
    echo 'Loading Xen ...'
    multiboot /boot/xen.gz placeholder  loglvl=all guest_loglvl=all console=com1 com1=57600
    echo 'Loading \$vmlinuz ...'
    module /boot/\$vmlinuz placeholder sysrq_always_enabled panic=9 console=hvc0
    echo 'Loading \$initrd ...'
    module --nounzip   /boot/\$initrd
    echo 'Go'
  else
    echo "xen.gz or \$vmlinuz or \$initrd NOT found"
  fi
}
_EOGC_
date
EOF
	if ! test -e "${script}"
	then
		do_copy "${t}" "${script}"
	elif test -e "${script}" && ! diff -q "${t}" "${script}"
	then
		do_copy "${t}" "${script}"
	fi
	rm -f "${t}"
}

create_copy_script "${I}/copy_to_vm.sh" "${suffix}"
if test "$1" = "modules_install"
then
	pushd "${I}" > /dev/null
	odir="/dev/shm/kernel.$PPID/${suffix}"
	test -d "${odir}" || mkdir -vp "${odir}"
	for f in `find * -type f`
	do
		if test -e "${odir}/${f}"
		then
			if cmp -s "${f}" "${odir}/${f}"
			then
				cp --archive --remove-destination "${odir}/${f}" "${f}"
				continue
			fi
		fi
		cp --parents --archive --verbose "--target-directory=${odir}" "${f}"
	done
	popd > /dev/null
fi
