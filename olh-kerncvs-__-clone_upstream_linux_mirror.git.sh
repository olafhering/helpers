set -e
update=
test "$1" = "-u" && update='true'
with_tags="
torvalds.linux.git|https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
stable.linux-stable.git|https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
bwh.linux-3.2.y.git|https://git.kernel.org/pub/scm/linux/kernel/git/bwh/linux-3.2.y.git
jirislaby.linux-stable.git|https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux-stable.git
"

without_tags="
github.olafhering.linux.git|git@github.com:olafhering/linux.git
bp.bp.git|https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git
davem.net-next.git|https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
davem.net.git|https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git
dhowells.linux-fs.git|https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
dledford.rdma.git|https://git.kernel.org/pub/scm/linux/kernel/git/dledford/rdma.git
dtor.input.git|https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
gregkh.char-misc.git|https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
gregkh.tty.git|https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
helgaas.pci.git|https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
herbert.cryptodev-2.6.git|https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
horms.ipvs-next.git|https://git.kernel.org/pub/scm/linux/kernel/git/horms/ipvs-next.git
horms.ipvs.git|https://git.kernel.org/pub/scm/linux/kernel/git/horms/ipvs.git
hyperv.linux.git|https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
jejb.scsi.git|https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git
jeyu.linux.git|https://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git
jj.linux-apparmor.git|https://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor.git
klassert.ipsec-next.git|https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git
klassert.ipsec.git|https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git
konrad.xen.git|https://git.kernel.org/pub/scm/linux/kernel/git/konrad/xen.git
mkp.scsi.git|https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git
nvdimm.nvdimm.git|https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git
pablo.nf-next.git|https://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf-next.git
pablo.nf.git|https://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf.git
powerpc.linux.git|https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
rdma.rdma.git|https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
s390.linux.git|https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git
shli.md.git|https://git.kernel.org/pub/scm/linux/kernel/git/shli/md.git
tip.tip.git|https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
tiwai.sound.git|https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
tj.libata.git|https://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git
tomba.linux.git|https://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git
tytso.ext4.git|https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
viro.vfs.git|https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git
xen.tip.git|https://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
linuxtv.media_tree.git|git://linuxtv.org/media_tree.git
kdave.btrfs-devel.git|https://github.com/kdave/btrfs-devel.git
airlied.linux.git|git://people.freedesktop.org/~airlied/linux
dk.linux-block.git|git://git.kernel.dk/linux-block.git
kvm.kvm.git|git://git.kernel.org/pub/scm/virt/kvm/kvm.git
infradead.nvme.git|git://git.infradead.org/nvme.git
drm.drm-misc.git|git://anongit.freedesktop.org/drm/drm-misc
"
if test -z "${update}"
then
	mkdir /dev/shm/$$
	pushd $_
	git init
fi
for remote in $with_tags
do
	name=${remote%%|*}
	repo=${remote##*|}
	git remote get-url $name > /dev/null && continue
	git remote add --tags $name $repo
done

for remote in $without_tags
do
	name=${remote%%|*}
	repo=${remote##*|}
	git remote get-url $name > /dev/null && continue
	git remote add --no-tags $name $repo
done
git remote show
