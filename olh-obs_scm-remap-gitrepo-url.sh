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
brotli_dir()          { readlink -f ~/git/for_obs/brotli.git ; }
brotli_url()          { echo "https://github.com/google/brotli" ; }
bsoftfloat3_dir()          { echo "none" ; }
bsoftfloat3_url()          { echo "https://github.com/ucb-bar/berkeley-softfloat-3.git" ; }
btestfloat3_dir()          { echo "none" ; }
btestfloat3_url()          { echo "https://github.com/qemu/berkeley-testfloat-3.git" ; }
claws_dir()       { readlink -f ~/git/for_obs/claws.git ; }
claws_url()       { echo "git://git.claws-mail.org/claws.git" ; }
gnulib_dir()       { echo "none" ; }
gnulib_url()       { echo "https://github.com/coreutils/gnulib.git" ; }
grub_dir()         { readlink -f ~/git/for_obs/grub.git ; }
grub_url()         { echo "https://git.savannah.gnu.org/git/grub.git" ; }
ipxe_dir()         { readlink -f ~/git/for_obs/ipxe.git ; }
ipxe_url()         { echo "https://github.com/ipxe/ipxe.git" ; }
keycodemapdb_dir() { readlink -f ~/git/for_obs/keycodemapdb.git ; }
keycodemapdb_url() { echo "https://gitlab.com/keycodemap/keycodemapdb.git" ; }
libvirt_dir()      { readlink -f ~/git/for_obs/libvirt.git ; }
libvirt_url()      { echo "https://gitlab.com/libvirt/libvirt.git" ; }
meson_dir()       { echo "none" ; }
meson_url()       { echo "https://github.com/mesonbuild/meson.git" ; }
minios_dir()       { readlink -f ~/git/for_obs/mini-os.git ; }
minios_url()       { echo "https://xenbits.xen.org/git-http/mini-os.git" ; }
ovmf_dir()          { readlink -f ~/git/for_obs/ovmf.git ; }
ovmf_url()          { echo "https://github.com/tianocore/edk2.git" ; }
openssl_dir()          { echo "none" ; }
openssl_url()          { echo "https://github.com/openssl/openssl" ; }
qemu_dir()         { readlink -f ~/git/for_obs/qemu.git ; }
qemu_url()         { echo "https://github.com/qemu/qemu.git" ; }
qemu_xen_dir()     { readlink -f ~/git/for_obs/qemu-xen.git ; }
qemu_xen_url()     { echo "https://xenbits.xen.org/git-http/qemu-xen.git" ; }
qemu_xen_trad_dir(){ readlink -f ~/git/for_obs/qemu-xen-traditional.git ; }
qemu_xen_trad_url(){ echo "https://xenbits.xen.org/git-http/qemu-xen-traditional.git" ; }
seabios_dir()      { readlink -f ~/git/for_obs/seabios.git ; }
seabios_url()      { echo "https://github.com/coreboot/seabios.git" ; }
seabios_xenbits_dir() { readlink -f ~/git/for_obs/seabios.git ; }
seabios_xenbits_url() { echo "https://xenbits.xen.org/git-http/seabios.git" ; }
sgabios_dir()      { echo "none" ; }
sgabios_url()      { echo "https://gitlab.com/qemu-project/sgabios.git" ; }
valgrind_dir()     { readlink -f ~/git/for_obs/valgrind.git ; }
valgrind_url()     { echo "git://sourceware.org/git/valgrind.git" ; }
xen_dir()          { readlink -f ~/git/for_obs/xen.git ; }
xen_url()          { echo "https://github.com/olafhering/xen.git" ; }
#
brotli() { case "${mode}" in dir) brotli_dir ;; url) brotli_url ;; *) echo "brotli" ;; esac }
bsoftfloat3() { case "${mode}" in dir) bsoftfloat3_dir ;; url) bsoftfloat3_url ;; *) echo "bsoftfloat3" ;; esac }
btestfloat3() { case "${mode}" in dir) btestfloat3_dir ;; url) btestfloat3_url ;; *) echo "btestfloat3" ;; esac }
claws() { case "${mode}" in dir) claws_dir ;; url) claws_url ;; *) echo "claws" ;; esac }
gnulib() { case "${mode}" in dir) gnulib_dir ;; url) gnulib_url ;; *) echo "gnulib" ;; esac }
grub() { case "${mode}" in dir) grub_dir ;; url) grub_url ;; *) echo "grub" ;; esac }
ipxe() { case "${mode}" in dir) ipxe_dir ;; url) ipxe_url ;; *) echo "ipxe" ;; esac }
keycodemapdb() { case "${mode}" in dir) keycodemapdb_dir ;; url) keycodemapdb_url ;; *) echo "keycodemapdb" ;; esac }
libvirt() { case "${mode}" in dir) libvirt_dir ;; url) libvirt_url ;; *) echo "libvirt" ;; esac }
meson() { case "${mode}" in dir) meson_dir ;; url) meson_url ;; *) echo "meson" ;; esac }
minios() { case "${mode}" in dir) minios_dir ;; url) minios_url ;; *) echo "minios" ;; esac }
ovmf() { case "${mode}" in dir) ovmf_dir ;; url) ovmf_url ;; *) echo "ovmf" ;; esac }
openssl() { case "${mode}" in dir) openssl_dir ;; url) openssl_url ;; *) echo "openssl" ;; esac }
qemu() { case "${mode}" in dir) qemu_dir ;; url) qemu_url ;; *) echo "qemu" ;; esac }
qemu_xen() { case "${mode}" in dir) qemu_xen_dir ;; url) qemu_xen_url ;; *) echo "qemu_xen" ;; esac }
qemu_xen_trad() { case "${mode}" in dir) qemu_xen_trad_dir ;; url) qemu_xen_trad_url ;; *) echo "qemu_xen_trad" ;; esac }
seabios() { case "${mode}" in dir) seabios_dir ;; url) seabios_url ;; *) echo "seabios" ;; esac }
seabios_xenbits() { case "${mode}" in dir) seabios_xenbits_dir ;; url) seabios_xenbits_url ;; *) echo "seabios" ;; esac }
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
  git://git.sv.gnu.org/gnulib) gnulib ;;
  git://git.sv.gnu.org/gnulib.git) gnulib ;;
  git://github.com/coreutils/gnulib.git) gnulib ;;
  git://github.com/cota/berkeley-softfloat-3) unhandled=1 ;;
  git://github.com/cota/berkeley-testfloat-3) unhandled=1 ;;
  git://github.com/hdeller/seabios-hppa.git) unhandled=1 ;;
  git://github.com/libvirt/libvirt.git) libvirt ;;
  git://github.com/olafhering/xen.git) xen ;;
  git://github.com/rth7680/qemu-palcode.git) unhandled=1 ;;
  git://github.com/tianocore/edk2) ovmf ;;
  git://github.com/xen-project/xen.git) xen ;;
  git://libvirt.org/libvirt.git) libvirt ;;
  git://repo.or.cz/qemu-palcode.git) unhandled=1 ;;
  git://sourceware.org/git/valgrind.git) valgrind ;;
  git://xenbits.xen.org/mini-os.git) minios ;;
  git://xenbits.xen.org/ovmf.git) ovmf ;;
  git://xenbits.xen.org/qemu-upstream-4.2-testing.git) qemu_xen ;;
  git://xenbits.xen.org/qemu-xen-4.2-testing.git) qemu_xen_trad ;;
  git://xenbits.xen.org/qemu-xen-traditional.git) qemu_xen_trad ;;
  git://xenbits.xen.org/qemu-xen.git) qemu_xen ;;
  git://xenbits.xen.org/seabios.git) seabios_xenbits ;;
  git://xenbits.xen.org/xen.git) xen ;;
  git@github.com:olafhering/brotli.git) brotli ;;
  git@github.com:olafhering/libvirt.git) libvirt ;;
  git@github.com:olafhering/qemu.git) qemu ;;
  git@github.com:olafhering/xen.git) xen ;;
  git@gitlab.com:olafhering/xen.git) xen ;;
  http://git.claws-mail.org/readonly/claws.git) claws ;;
  http://git.ipxe.org/ipxe.git) ipxe ;;
  http://git.qemu.org/git/QemuMacDrivers.git) unhandled=1 ;;
  http://git.qemu.org/git/SLOF.git) unhandled=1 ;;
  http://git.qemu.org/git/capstone.git) unhandled=1 ;;
  http://git.qemu.org/git/dtc.git) unhandled=1 ;;
  http://git.qemu.org/git/git/qemu.git/) qemu ;;
  http://git.qemu.org/git/ipxe.git) ipxe ;;
  http://git.qemu.org/git/keycodemapdb.git) keycodemapdb ;;
  http://git.qemu.org/git/openbios.git) unhandled=1 ;;
  http://git.qemu.org/git/qemu-palcode.git) unhandled=1 ;;
  http://git.qemu.org/git/qemu.git) qemu ;;
  http://git.qemu.org/git/seabios.git/) seabios ;;
  http://git.qemu.org/git/sgabios.git) sgabios ;;
  http://git.qemu.org/git/skiboot.git) unhandled=1 ;;
  http://git.qemu.org/git/u-boot-sam460ex.git) unhandled=1 ;;
  http://git.qemu.org/git/vgabios.git/) unhandled=1 ;;
  http://xenbits.xen.org/git-http/mini-os.git) minios ;;
  http://xenbits.xen.org/git-http/qemu-xen-traditional.git) qemu_xen_trad ;;
  http://xenbits.xen.org/git-http/qemu-xen.git) qemu_xen ;;
  http://xenbits.xen.org/git-http/seabios.git) seabios ;;
  https://git.cryptomilk.org/projects/cmocka.git) unhandled=1 ;;
  https://git.ipxe.org/ipxe.git) ipxe ;;
  https://git.qemu.org/git/QemuMacDrivers.git) unhandled=1 ;;
  https://git.qemu.org/git/SLOF.git) unhandled=1 ;;
  https://git.qemu.org/git/berkeley-softfloat-3.git) bsoftfloat3 ;;
  https://git.qemu.org/git/berkeley-softfloat-3.git) unhandled=1 ;;
  https://git.qemu.org/git/berkeley-testfloat-3.git) btestfloat3 ;;
  https://git.qemu.org/git/berkeley-testfloat-3.git) unhandled=1 ;;
  https://git.qemu.org/git/capstone.git) unhandled=1 ;;
  https://git.qemu.org/git/dtc.git) unhandled=1 ;;
  https://git.qemu.org/git/edk2.git) ovmf ;;
  https://git.qemu.org/git/ipxe.git) ipxe ;;
  https://git.qemu.org/git/keycodemapdb.git) keycodemapdb ;;
  https://git.qemu.org/git/libslirp.git) unhandled=1 ;;
  https://git.qemu.org/git/meson.git) meson ;;
  https://git.qemu.org/git/openbios.git) unhandled=1 ;;
  https://git.qemu.org/git/openhackware.git) unhandled=1 ;;
  https://git.qemu.org/git/opensbi.git) unhandled=1 ;;
  https://git.qemu.org/git/qboot.git) unhandled=1 ;;
  https://git.qemu.org/git/qemu-palcode.git) unhandled=1 ;;
  https://git.qemu.org/git/qemu.git) qemu ;;
  https://git.qemu.org/git/qemu.git/) qemu ;;
  https://git.qemu.org/git/seabios-hppa.git) unhandled=1 ;;
  https://git.qemu.org/git/seabios.git/) seabios ;;
  https://git.qemu.org/git/sgabios.git) sgabios ;;
  https://git.qemu.org/git/skiboot.git) unhandled=1 ;;
  https://git.qemu.org/git/u-boot-sam460ex.git) unhandled=1 ;;
  https://git.qemu.org/git/u-boot.git) unhandled=1 ;;
  https://git.qemu.org/git/vbootrom.git) unhandled=1 ;;
  https://git.qemu.org/git/vgabios.git/) unhandled=1 ;;
  https://git.savannah.gnu.org/git/gnulib.git) gnulib ;;
  https://git.savannah.gnu.org/git/gnulib.git/) gnulib ;;
  https://git.savannah.gnu.org/git/grub.git) grub ;;
  https://git.seabios.org/cgit/seabios.git) seabios ;;
  https://git.seabios.org/cgit/seabios.git/) seabios ;;
  https://git.seabios.org/seabios.git) seabios ;;
  https://git.seabios.org/seabios.git/) seabios ;;
  https://git.sv.gnu.org/git/gnulib.git) gnulib ;;
  https://git.sv.gnu.org/git/gnulib.git/) gnulib ;;
  https://github.com/akheron/jansson) unhandled=1 ;;
  https://github.com/bonzini/qboot) unhandled=1 ;;
  https://github.com/coreboot/seabios.git) seabios ;;
  https://github.com/coreutils/gnulib.git) gnulib ;;
  https://github.com/cota/berkeley-softfloat-3) bsoftfloat3 ;;
  https://github.com/cota/berkeley-softfloat-3) unhandled=1 ;;
  https://github.com/cota/berkeley-testfloat-3) unhandled=1 ;;
  https://github.com/google/brotli) brotli ;;
  https://github.com/hdeller/seabios-hppa.git) unhandled=1 ;;
  https://github.com/hillbig/esaxx) unhandled=1 ;;
  https://github.com/ipxe/ipxe.git) ipxe ;;
  https://github.com/kkos/oniguruma) unhandled=1 ;;
  https://github.com/libvirt/libvirt.git) libvirt ;;
  https://github.com/mesonbuild/meson) meson ;;
  https://github.com/mesonbuild/meson.git) meson ;;
  https://github.com/olafhering/xen.git) xen ;;
  https://github.com/openssl/openssl) openssl ;;
  https://github.com/qemu/berkeley-testfloat-3.git) btestfloat3 ;;
  https://github.com/qemu/qemu.git) qemu ;;
  https://github.com/tianocore/edk2-cmocka.git) unhandled=1 ;;
  https://github.com/tianocore/edk2.git) ovmf ;;
  https://github.com/ucb-bar/berkeley-softfloat-3.git) bsoftfloat3 ;;
  https://github.com/ucb-bar/berkeley-testfloat-3) btestfloat3 ;;
  https://github.com/y-256/libdivsufsort.git) unhandled=1 ;;
  https://gitlab.com/keycodemap/keycodemapdb.git) keycodemapdb ;;
  https://gitlab.com/libvirt/libvirt-ci) unhandled=1 ;;
  https://gitlab.com/libvirt/libvirt.git) libvirt ;;
  https://gitlab.com/qemu-project/QemuMacDrivers.git) unhandled=1 ;;
  https://gitlab.com/qemu-project/SLOF.git) unhandled=1 ;;
  https://gitlab.com/qemu-project/SLOF.git/) unhandled=1 ;;
  https://gitlab.com/qemu-project/berkeley-softfloat-3.git) bsoftfloat3 ;;
  https://gitlab.com/qemu-project/berkeley-testfloat-3.git) btestfloat3 ;;
  https://gitlab.com/qemu-project/capstone.git) unhandled=1 ;;
  https://gitlab.com/qemu-project/dtc.git) unhandled=1 ;;
  https://gitlab.com/qemu-project/edk2.git) ovmf ;;
  https://gitlab.com/qemu-project/ipxe.git) ipxe ;;
  https://gitlab.com/qemu-project/keycodemapdb.git) keycodemapdb ;;
  https://gitlab.com/qemu-project/libslirp.git) unhandled=1 ;;
  https://gitlab.com/qemu-project/meson.git) meson ;;
  https://gitlab.com/qemu-project/openbios.git) unhandled=1 ;;
  https://gitlab.com/qemu-project/opensbi.git) unhandled=1 ;;
  https://gitlab.com/qemu-project/qboot.git) unhandled=1 ;;
  https://gitlab.com/qemu-project/qemu-palcode.git) unhandled=1 ;;
  https://gitlab.com/qemu-project/seabios-hppa.git) unhandled=1 ;;
  https://gitlab.com/qemu-project/seabios.git/) seabios ;;
  https://gitlab.com/qemu-project/sgabios.git) sgabios ;;
  https://gitlab.com/qemu-project/skiboot.git) unhandled=1 ;;
  https://gitlab.com/qemu-project/u-boot-sam460ex.git) unhandled=1 ;;
  https://gitlab.com/qemu-project/u-boot.git) unhandled=1 ;;
  https://gitlab.com/qemu-project/vbootrom.git) unhandled=1 ;;
  https://libvirt.org/git/libvirt.git) libvirt ;;
  https://xenbits.xen.org/git-http/mini-os.git) minios ;;
  https://xenbits.xen.org/git-http/ovmf.git) ovmf ;;
  https://xenbits.xen.org/git-http/qemu-xen-traditional.git) qemu_xen_trad ;;
  https://xenbits.xen.org/git-http/qemu-xen.git) qemu_xen ;;
  https://xenbits.xen.org/git-http/seabios.git) seabios ;;
  https://xenbits.xen.org/git-http/xen.git) xen ;;
  *) echo "UNHANDLED ${url}" >&2 ; echo 'UNHANDLED' ; exit 1 ;;
esac
#
: unhandled "${unhandled}"
if test -n "${unhandled}"
then
 echo 'unhandled'
fi
exit 0
