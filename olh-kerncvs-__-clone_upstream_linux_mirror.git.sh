set -e
with_tags="
torvalds.linux.git|git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
stable.linux-stable.git|git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
bwh.linux-3.2.y.git|git://git.kernel.org/pub/scm/linux/kernel/git/bwh/linux-3.2.y.git
jirislaby.linux-stable.git|git://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux-stable.git
"

without_tags="
github.olafhering.linux.git|git@github.com:olafhering/linux.git
davem.net-next.git|git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
davem.net.git|git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git
dtor.input.git|git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
gregkh.char-misc.git|git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
helgaas.pci.git|git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
jejb.scsi.git|git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git
konrad.xen.git|git://git.kernel.org/pub/scm/linux/kernel/git/konrad/xen.git
tomba.linux.git|git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git
xen.tip.git|git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
"
mkdir /dev/shm/$$
pushd $_
git init
for remote in $with_tags
do
	name=${remote%%|*}
	repo=${remote##*|}
	git remote add --tags $name $repo
done

for remote in $without_tags
do
	name=${remote%%|*}
	repo=${remote##*|}
	git remote add --no-tags $name $repo
done
git remote show
