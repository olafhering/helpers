#!/bin/bash
#et -x
set -e
unset LANG
unset ${!LC_*}
url=$1
mode=$2
case "${mode}" in
  ""|url) mode=url ;;
  dir) mode=dir ;;
  tag) mode=tag ;;
  *) exit 1 ;;
esac
unset unhandled
#
claws_dir()       { readlink -f ~/git/for_obs/claws.git ; }
claws_url()       { echo "git://git.claws-mail.org/claws.git" ; }
gnulib_dir()       { echo "none" ; }
gnulib_url()       { echo "git://github.com/coreutils/gnulib.git" ; }
grub_dir()         { readlink -f ~/git/for_obs/grub.git ; }
grub_url()         { echo "git://git.savannah.gnu.org/grub.git" ; }
ipxe_dir()         { readlink -f ~/git/for_obs/ipxe.git ; }
ipxe_url()         { echo "git://git.ipxe.org/ipxe.git" ; }
keycodemapdb_dir() { readlink -f ~/git/for_obs/keycodemapdb.git ; }
keycodemapdb_url() { echo "https://gitlab.com/keycodemap/keycodemapdb.git" ; }
libvirt_dir()      { readlink -f ~/git/for_obs/libvirt.git ; }
libvirt_url()      { echo "git://github.com/libvirt/libvirt.git" ; }
minios_dir()       { readlink -f ~/git/for_obs/mini-os.git ; }
minios_url()       { echo "git://xenbits.xen.org/mini-os.git" ; }
mutt_dir()          { readlink -f ~/git/for_obs/mutt.git ; }
mutt_url()          { echo "https://gitlab.com/muttmua/mutt.git" ; }
ovmf_dir()          { readlink -f ~/git/for_obs/ovmf.git ; }
ovmf_url()          { echo "git://github.com/tianocore/edk2" ; }
qemu_dir()         { readlink -f ~/git/for_obs/qemu.git ; }
qemu_url()         { echo "git://git.qemu.org/qemu.git" ; }
qemu_xen_dir()     { readlink -f ~/git/for_obs/qemu-xen.git ; }
qemu_xen_url()     { echo "git://xenbits.xen.org/qemu-xen.git" ; }
qemu_xen_trad_dir(){ readlink -f ~/git/for_obs/qemu-xen-traditional.git ; }
qemu_xen_trad_url(){ echo "git://xenbits.xen.org/qemu-xen-traditional.git" ; }
seabios_dir()      { readlink -f ~/git/for_obs/seabios.git ; }
seabios_url()      { echo "https://git.seabios.org/seabios.git" ; }
sgabios_dir()      { echo "none" ; }
sgabios_url()      { echo "git://git.qemu-project.org/sgabios.git" ; }
valgrind_dir()     { readlink -f ~/git/for_obs/valgrind.git ; }
valgrind_url()     { echo "git://sourceware.org/git/valgrind.git" ; }
xen_dir()          { readlink -f ~/git/for_obs/xen.git ; }
xen_url()          { echo "git://github.com/olafhering/xen.git" ; }
#
claws() { case "${mode}" in dir) claws_dir ;; url) claws_url ;; *) echo "claws" ;; esac }
gnulib() { case "${mode}" in dir) gnulib_dir ;; url) gnulib_url ;; *) echo "gnulib" ;; esac }
grub() { case "${mode}" in dir) grub_dir ;; url) grub_url ;; *) echo "grub" ;; esac }
ipxe() { case "${mode}" in dir) ipxe_dir ;; url) ipxe_url ;; *) echo "ipxe" ;; esac }
keycodemapdb() { case "${mode}" in dir) keycodemapdb_dir ;; url) keycodemapdb_url ;; *) echo "keycodemapdb" ;; esac }
libvirt() { case "${mode}" in dir) libvirt_dir ;; url) libvirt_url ;; *) echo "libvirt" ;; esac }
minios() { case "${mode}" in dir) minios_dir ;; url) minios_url ;; *) echo "minios" ;; esac }
mutt() { case "${mode}" in dir) mutt_dir ;; url) mutt_url ;; *) echo "mutt" ;; esac }
ovmf() { case "${mode}" in dir) ovmf_dir ;; url) ovmf_url ;; *) echo "ovmf" ;; esac }
qemu() { case "${mode}" in dir) qemu_dir ;; url) qemu_url ;; *) echo "qemu" ;; esac }
qemu_xen() { case "${mode}" in dir) qemu_xen_dir ;; url) qemu_xen_url ;; *) echo "qemu_xen" ;; esac }
qemu_xen_trad() { case "${mode}" in dir) qemu_xen_trad_dir ;; url) qemu_xen_trad_url ;; *) echo "qemu_xen_trad" ;; esac }
seabios() { case "${mode}" in dir) seabios_dir ;; url) seabios_url ;; *) echo "seabios" ;; esac }
sgabios() { case "${mode}" in dir) sgabios_dir ;; url) sgabios_url ;; *) echo "sgabios" ;; esac }
valgrind() { case "${mode}" in dir) valgrind_dir ;; url) valgrind_url ;; *) echo "valgrind" ;; esac }
xen() { case "${mode}" in dir) xen_dir ;; url) xen_url ;; *) echo "xen" ;; esac }
#
case "${url}" in
  git://anongit.freedesktop.org/pixman) unhandled=1 ;;
  git://git.claws-mail.org/claws.git) claws ;;
  git://git.ipxe.org/ipxe.git) ipxe ;;
  git://git.qemu-project.org/SLOF.git) unhandled=1 ;;
  git://git.qemu-project.org/dtc.git) unhandled=1 ;;
  git://git.qemu-project.org/ipxe.git) ipxe ;;
  git://git.qemu-project.org/openbios.git) unhandled=1 ;;
  git://git.qemu-project.org/openhackware.git) unhandled=1 ;;
  git://git.qemu-project.org/seabios.git/) seabios ;;
  git://git.qemu-project.org/sgabios.git) sgabios ;;
  git://git.qemu-project.org/u-boot.git) unhandled=1 ;;
  git://git.qemu-project.org/vgabios.git/) unhandled=1 ;;
  git://git.qemu.org/QemuMacDrivers.git) unhandled=1 ;;
  git://git.qemu.org/SLOF.git) unhandled=1 ;;
  git://git.qemu.org/capstone.git) unhandled=1 ;;
  git://git.qemu.org/dtc.git) unhandled=1 ;;
  git://git.qemu.org/ipxe.git) ipxe ;;
  git://git.qemu.org/keycodemapdb.git) keycodemapdb ;;
  git://git.qemu.org/openbios.git) unhandled=1 ;;
  git://git.qemu.org/qemu-palcode.git) unhandled=1 ;;
  git://git.qemu.org/qemu.git) qemu ;;
  git://git.qemu.org/seabios.git/) seabios ;;
  git://git.qemu.org/sgabios.git) sgabios ;;
  git://git.qemu.org/skiboot.git) unhandled=1 ;;
  git://git.qemu.org/u-boot-sam460ex.git) unhandled=1 ;;
  git://git.qemu.org/vgabios.git/) unhandled=1 ;;
  git://git.savannah.gnu.org/gnulib.git) gnulib ;;
  git://git.savannah.gnu.org/grub.git) grub ;;
  git://git.seabios.org/seabios.git) seabios ;;
  git://git.sv.gnu.org/gnulib.git) gnulib ;;
  git://github.com/coreutils/gnulib.git) gnulib ;;
  git://github.com/hdeller/seabios-hppa.git) unhandled=1 ;;
  git://github.com/libvirt/libvirt.git) libvirt ;;
  git://github.com/olafhering/xen.git) xen ;;
  git://github.com/rth7680/qemu-palcode.git) unhandled=1 ;;
  git://github.com/tianocore/edk2) ovmf ;;
  git://github.com/xen-project/xen.git) xen ;;
  git://libvirt.org/libvirt.git) libvirt ;;
  git://sourceware.org/git/valgrind.git) valgrind ;;
  git://xenbits.xen.org/mini-os.git) minios ;;
  git://xenbits.xen.org/ovmf.git) ovmf ;;
  git://xenbits.xen.org/qemu-xen-traditional.git) qemu_xen_trad ;;
  git://xenbits.xen.org/qemu-xen.git) qemu_xen ;;
  git://xenbits.xen.org/seabios.git) seabios ;;
  git://xenbits.xen.org/xen.git) xen ;;
  git@github.com:olafhering/libvirt.git) libvirt ;;
  git@github.com:olafhering/qemu.git) qemu ;;
  git@github.com:olafhering/xen.git) xen ;;
  git@gitlab.com:olafhering/xen.git) xen ;;
  http://git.claws-mail.org/readonly/claws.git) claws ;;
  https://git.savannah.gnu.org/git/gnulib.git) gnulib ;;
  https://git.savannah.gnu.org/git/gnulib.git/) gnulib ;;
  https://git.seabios.org/cgit/seabios.git) seabios ;;
  https://git.seabios.org/cgit/seabios.git/) seabios ;;
  https://git.seabios.org/seabios.git) seabios ;;
  https://git.seabios.org/seabios.git/) seabios ;;
  https://git.sv.gnu.org/git/gnulib.git) gnulib ;;
  https://git.sv.gnu.org/git/gnulib.git/) gnulib ;;
  https://gitlab.com/keycodemap/keycodemapdb.git) keycodemapdb ;;
  https://gitlab.com/muttmua/mutt.git) mutt ;;
  *) echo "UNHANDLED ${url}" >&2 ; unhandled=1 ;;
esac
#
: unhandled "${unhandled}"
if test -n "${unhandled}"
then
 exit 1
fi
exit 0
