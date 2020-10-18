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
brotli_dir()          { echo "none" ; }
brotli_url()          { echo "https://github.com/google/brotli" ; }
claws_dir()       { readlink -f ~/git/for_obs/claws.git ; }
claws_url()       { echo "git://git.claws-mail.org/claws.git" ; }
gnulib_dir()       { echo "none" ; }
gnulib_url()       { echo "https://github.com/coreutils/gnulib.git" ; }
gplugin_dir()          { readlink -f ~/git/for_obs/gplugin.git ; }
gplugin_url()          { echo "https://github.com/olafhering/gplugin.git" ; }
grub_dir()         { readlink -f ~/git/for_obs/grub.git ; }
grub_url()         { echo "git://git.savannah.gnu.org/grub.git" ; }
ipxe_dir()         { readlink -f ~/git/for_obs/ipxe.git ; }
ipxe_url()         { echo "https://git.ipxe.org/ipxe.git" ; }
keycodemapdb_dir() { readlink -f ~/git/for_obs/keycodemapdb.git ; }
keycodemapdb_url() { echo "https://gitlab.com/keycodemap/keycodemapdb.git" ; }
libetpan_dir()      { readlink -f ~/git/for_obs/libetpan.git ; }
libetpan_url()      { echo "https://github.com/dinhviethoa/libetpan.git" ; }
libgnt_dir()          { readlink -f ~/git/for_obs/libgnt.git ; }
libgnt_url()          { echo "https://github.com/olafhering/libgnt.git" ; }
libvirt_dir()      { readlink -f ~/git/for_obs/libvirt.git ; }
libvirt_url()      { echo "https://github.com/libvirt/libvirt.git" ; }
meson_dir()       { echo "none" ; }
meson_url()       { echo "https://github.com/mesonbuild/meson.git" ; }
minios_dir()       { readlink -f ~/git/for_obs/mini-os.git ; }
minios_url()       { echo "https://xenbits.xen.org/git-http/mini-os.git" ; }
mutt_dir()          { readlink -f ~/git/for_obs/mutt.git ; }
mutt_url()          { echo "https://gitlab.com/muttmua/mutt.git" ; }
ovmf_dir()          { readlink -f ~/git/for_obs/ovmf.git ; }
ovmf_url()          { echo "https://github.com/tianocore/edk2.git" ; }
pidgin_dir()          { readlink -f ~/git/for_obs/pidgin.git ; }
pidgin_url()          { echo "https://github.com/olafhering/pidgin.git" ; }
purple_rocketchat_dir()          { readlink -f ~/git/for_obs/purple-rocketchat.git ; }
purple_rocketchat_url()          { echo "https://github.com/olafhering/purple-rocketchat.git" ; }
openssl_dir()          { echo "none" ; }
openssl_url()          { echo "https://github.com/openssl/openssl" ; }
qemu_dir()         { readlink -f ~/git/for_obs/qemu.git ; }
qemu_url()         { echo "https://git.qemu.org/git/qemu.git/" ; }
qemu_xen_dir()     { readlink -f ~/git/for_obs/qemu-xen.git ; }
qemu_xen_url()     { echo "https://xenbits.xen.org/git-http/qemu-xen.git" ; }
qemu_xen_trad_dir(){ readlink -f ~/git/for_obs/qemu-xen-traditional.git ; }
qemu_xen_trad_url(){ echo "https://xenbits.xen.org/git-http/qemu-xen-traditional.git" ; }
seabios_dir()      { readlink -f ~/git/for_obs/seabios.git ; }
seabios_url()      { echo "https://git.seabios.org/seabios.git" ; }
seabios_xenbits_dir() { readlink -f ~/git/for_obs/seabios.git ; }
seabios_xenbits_url() { echo "https://xenbits.xen.org/git-http/seabios.git" ; }
sgabios_dir()      { echo "none" ; }
talkatu_dir()          { readlink -f ~/git/for_obs/talkatu.git ; }
talkatu_url()          { echo "https://github.com/olafhering/talkatu.git" ; }
sgabios_url()      { echo "git://git.qemu-project.org/sgabios.git" ; }
valgrind_dir()     { readlink -f ~/git/for_obs/valgrind.git ; }
valgrind_url()     { echo "git://sourceware.org/git/valgrind.git" ; }
xen_dir()          { readlink -f ~/git/for_obs/xen.git ; }
xen_url()          { echo "https://github.com/olafhering/xen.git" ; }
#
brotli() { case "${mode}" in dir) brotli_dir ;; url) brotli_url ;; *) echo "brotli" ;; esac }
claws() { case "${mode}" in dir) claws_dir ;; url) claws_url ;; *) echo "claws" ;; esac }
gnulib() { case "${mode}" in dir) gnulib_dir ;; url) gnulib_url ;; *) echo "gnulib" ;; esac }
gplugin() { case "${mode}" in dir) gplugin_dir ;; url) gplugin_url ;; *) echo "gplugin" ;; esac }
grub() { case "${mode}" in dir) grub_dir ;; url) grub_url ;; *) echo "grub" ;; esac }
ipxe() { case "${mode}" in dir) ipxe_dir ;; url) ipxe_url ;; *) echo "ipxe" ;; esac }
keycodemapdb() { case "${mode}" in dir) keycodemapdb_dir ;; url) keycodemapdb_url ;; *) echo "keycodemapdb" ;; esac }
libetpan() { case "${mode}" in dir) libetpan_dir ;; url) libetpan_url ;; *) echo "libetpan" ;; esac }
libgnt() { case "${mode}" in dir) libgnt_dir ;; url) libgnt_url ;; *) echo "libgnt" ;; esac }
libvirt() { case "${mode}" in dir) libvirt_dir ;; url) libvirt_url ;; *) echo "libvirt" ;; esac }
meson() { case "${mode}" in dir) meson_dir ;; url) meson_url ;; *) echo "meson" ;; esac }
minios() { case "${mode}" in dir) minios_dir ;; url) minios_url ;; *) echo "minios" ;; esac }
mutt() { case "${mode}" in dir) mutt_dir ;; url) mutt_url ;; *) echo "mutt" ;; esac }
ovmf() { case "${mode}" in dir) ovmf_dir ;; url) ovmf_url ;; *) echo "ovmf" ;; esac }
pidgin() { case "${mode}" in dir) pidgin_dir ;; url) pidgin_url ;; *) echo "pidgin" ;; esac }
purple_rocketchat() { case "${mode}" in dir) purple_rocketchat_dir ;; url) purple_rocketchat_url ;; *) echo "purple_rocketchat" ;; esac }
openssl() { case "${mode}" in dir) openssl_dir ;; url) openssl_url ;; *) echo "openssl" ;; esac }
qemu() { case "${mode}" in dir) qemu_dir ;; url) qemu_url ;; *) echo "qemu" ;; esac }
qemu_xen() { case "${mode}" in dir) qemu_xen_dir ;; url) qemu_xen_url ;; *) echo "qemu_xen" ;; esac }
qemu_xen_trad() { case "${mode}" in dir) qemu_xen_trad_dir ;; url) qemu_xen_trad_url ;; *) echo "qemu_xen_trad" ;; esac }
seabios() { case "${mode}" in dir) seabios_dir ;; url) seabios_url ;; *) echo "seabios" ;; esac }
seabios_xenbits() { case "${mode}" in dir) seabios_xenbits_dir ;; url) seabios_xenbits_url ;; *) echo "seabios" ;; esac }
sgabios() { case "${mode}" in dir) sgabios_dir ;; url) sgabios_url ;; *) echo "sgabios" ;; esac }
talkatu() { case "${mode}" in dir) talkatu_dir ;; url) talkatu_url ;; *) echo "talkatu" ;; esac }
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
  git://github.com/dinhviethoa/libetpan.git) libetpan ;;
  git://github.com/hdeller/seabios-hppa.git) unhandled=1 ;;
  git://github.com/libvirt/libvirt.git) libvirt ;;
  git://github.com/olafhering/gplugin.git) gplugin ;;
  git://github.com/olafhering/libgnt.git) libgnt ;;
  git://github.com/olafhering/pidgin.git) pidgin ;;
  git://github.com/olafhering/purple-rocketchat.git) purple_rocketchat ;;
  git://github.com/olafhering/talkatu.git) talkatu ;;
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
  git@github.com:olafhering/gplugin.git) gplugin ;;
  git@github.com:olafhering/libgnt.git) libgnt ;;
  git@github.com:olafhering/libvirt.git) libvirt ;;
  git@github.com:olafhering/pidgin.git) pidgin ;;
  git@github.com:olafhering/purple-rocketchat.git) purple_rocketchat ;;
  git@github.com:olafhering/qemu.git) qemu ;;
  git@github.com:olafhering/talkatu.git) talkatu ;;
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
  https://git.ipxe.org/ipxe.git) ipxe ;;
  https://git.qemu.org/git/QemuMacDrivers.git) unhandled=1 ;;
  https://git.qemu.org/git/SLOF.git) unhandled=1 ;;
  https://git.qemu.org/git/berkeley-softfloat-3.git) unhandled=1 ;;
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
  https://git.qemu.org/git/qemu-palcode.git) unhandled=1 ;;
  https://git.qemu.org/git/qemu.git) qemu ;;
  https://git.qemu.org/git/qemu.git/) qemu ;;
  https://git.qemu.org/git/seabios-hppa.git) unhandled=1 ;;
  https://git.qemu.org/git/seabios.git/) seabios ;;
  https://git.qemu.org/git/sgabios.git) sgabios ;;
  https://git.qemu.org/git/skiboot.git) unhandled=1 ;;
  https://git.qemu.org/git/u-boot-sam460ex.git) unhandled=1 ;;
  https://git.qemu.org/git/u-boot.git) unhandled=1 ;;
  https://git.qemu.org/git/vgabios.git/) unhandled=1 ;;
  https://git.savannah.gnu.org/git/gnulib.git) gnulib ;;
  https://git.savannah.gnu.org/git/gnulib.git/) gnulib ;;
  https://git.seabios.org/cgit/seabios.git) seabios ;;
  https://git.seabios.org/cgit/seabios.git/) seabios ;;
  https://git.seabios.org/seabios.git) seabios ;;
  https://git.seabios.org/seabios.git/) seabios ;;
  https://git.sv.gnu.org/git/gnulib.git) gnulib ;;
  https://git.sv.gnu.org/git/gnulib.git/) gnulib ;;
  https://github.com/coreutils/gnulib.git) gnulib ;;
  https://github.com/cota/berkeley-softfloat-3) unhandled=1 ;;
  https://github.com/cota/berkeley-testfloat-3) unhandled=1 ;;
  https://github.com/dinhviethoa/libetpan) libetpan ;;
  https://github.com/google/brotli) brotli ;;
  https://github.com/hdeller/seabios-hppa.git) unhandled=1 ;;
  https://github.com/libvirt/libvirt.git) libvirt ;;
  https://github.com/mesonbuild/meson) meson ;;
  https://github.com/mesonbuild/meson.git) meson ;;
  https://github.com/olafhering/gplugin.git) gplugin ;;
  https://github.com/olafhering/libgnt.git) libgnt ;;
  https://github.com/olafhering/pidgin.git) pidgin ;;
  https://github.com/olafhering/purple-rocketchat.git) purple_rocketchat ;;
  https://github.com/olafhering/talkatu.git) talkatu ;;
  https://github.com/olafhering/xen.git) xen ;;
  https://github.com/openssl/openssl) openssl ;;
  https://github.com/tianocore/edk2.git) ovmf ;;
  https://github.com/ucb-bar/berkeley-softfloat-3.git) unhandled=1 ;;
  https://gitlab.com/keycodemap/keycodemapdb.git) keycodemapdb ;;
  https://gitlab.com/muttmua/mutt.git) mutt ;;
  https://xenbits.xen.org/git-http/mini-os.git) minios ;;
  https://xenbits.xen.org/git-http/ovmf.git) ovmf ;;
  https://xenbits.xen.org/git-http/qemu-xen-traditional.git) qemu_xen_trad ;;
  https://xenbits.xen.org/git-http/qemu-xen.git) qemu_xen ;;
  https://xenbits.xen.org/git-http/seabios.git) seabios ;;
  https://xenbits.xen.org/git-http/xen.git) xen ;;
  *) echo "UNHANDLED ${url}" >&2 ; unhandled=1 ;;
esac
#
: unhandled "${unhandled}"
if test -n "${unhandled}"
then
 exit 1
fi
exit 0
