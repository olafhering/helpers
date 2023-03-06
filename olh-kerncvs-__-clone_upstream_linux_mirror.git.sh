#!/bin/bash
# vim: ts=2 shiftwidth=2 noexpandtab nowrap
set -ex
unset LANG
unset ${!LC_*}
. /usr/share/helpers/bin/olh-kerncvs-env

update=
test "$1" = "-u" && update='true'
with_tags="
torvalds.linux.git|https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
stable.linux-stable.git|https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
jirislaby.linux-stable.git|https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux-stable.git
"

without_tags="
github.olafhering.linux.git|git@github.com:olafhering/linux.git
davem.net-next.git|https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
davem.net.git|https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git
helgaas.pci.git|https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
hyperv.linux.git|https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
joro.iommu.git|https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
"
test -d "${UPSTREAM_REPOS}" || mkdir -v "${UPSTREAM_REPOS}"
pushd "$_"
if test -z "${update}"
then
	if test -d ".git"
	then
		: already initialized
	else
		git --no-pager init
		git --no-pager remote \
			add \
			--no-tags \
			LINUX_GIT \
			https://github.com/torvalds/linux.git
	fi
fi
for remote in $with_tags
do
	name=${remote%%|*}
	repo=${remote##*|}
	git --no-pager remote get-url $name > /dev/null && continue
	git --no-pager remote add --tags $name $repo
done

for remote in $without_tags
do
	name=${remote%%|*}
	repo=${remote##*|}
	git --no-pager remote get-url $name > /dev/null && continue
	git --no-pager remote add --no-tags $name $repo
done
git --no-pager remote show
