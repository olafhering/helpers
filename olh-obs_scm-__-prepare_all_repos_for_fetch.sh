#!/bin/bash
set -x
set -e
unset LANG
unset ${!LC_*}
pushd ~/git/for_obs
#
repo_dir=claws.git
if ! pushd "${repo_dir}" > /dev/null
then
  mkdir -v "${repo_dir}"
  pushd "${repo_dir}" > /dev/null
fi
if pushd .git > /dev/null
then
  popd > /dev/null
else
  git init
  git remote add    --tags upstream            git://git.claws-mail.org/claws.git
  git remote add --no-tags github_olafhering   git@github.com:olafhering/claws.git
  git remote add --no-tags gitlab_olafhering   git@gitlab.com:olafhering/claws.git
  git remote add --no-tags gitlab_olh          gitlab@gitlab.suse.de:olh/claws.git
fi
popd > /dev/null
#
repo_dir=grub.git
if ! pushd "${repo_dir}" > /dev/null
then
  mkdir -v "${repo_dir}"
  pushd "${repo_dir}" > /dev/null
fi
if pushd .git > /dev/null
then
  popd > /dev/null
else
  git init
  git remote add    --tags upstream            git://git.savannah.gnu.org/grub.git
  git remote add --no-tags github_olafhering   git@github.com:olafhering/grub.git
  git remote add --no-tags gitlab_olafhering   git@gitlab.com:olafhering/grub.git
  git remote add --no-tags gitlab_olh          gitlab@gitlab.suse.de:olh/grub.git
fi
popd > /dev/null
#
repo_dir=ipxe.git
if ! pushd "${repo_dir}" > /dev/null
then
  mkdir -v "${repo_dir}"
  pushd "${repo_dir}" > /dev/null
fi
if pushd .git > /dev/null
then
  popd > /dev/null
else
  git init
  git remote add    --tags upstream            git://git.ipxe.org/ipxe.git
  git remote add --no-tags github_ipxe         git://github.com/ipxe/ipxe.git
  git remote add --no-tags github_olafhering   git@github.com:olafhering/ipxe.git
  git remote add --no-tags gitlab_olafhering   git@gitlab.com:olafhering/ipxe.git
  git remote add --no-tags gitlab_olh          gitlab@gitlab.suse.de:olh/ipxe.git
fi
popd > /dev/null
#
repo_dir=mini-os.git
if ! pushd "${repo_dir}" > /dev/null
then
  mkdir -v "${repo_dir}"
  pushd "${repo_dir}" > /dev/null
fi
if pushd .git > /dev/null
then
  popd > /dev/null
else
  git init
  git remote add    --tags upstream            git://xenbits.xen.org/mini-os.git
  git remote add    --tags xenbits_minios      git://xenbits.xen.org/mini-os.git
  git remote add --no-tags github_olafhering   git@github.com:olafhering/mini-os.git
  git remote add --no-tags gitlab_olafhering   git@gitlab.com:olafhering/mini-os.git
  git remote add --no-tags gitlab_olh          gitlab@gitlab.suse.de:olh/mini-os.git
fi
popd > /dev/null
#
repo_dir=mutt.git
if ! pushd "${repo_dir}" > /dev/null
then
  mkdir -v "${repo_dir}"
  pushd "${repo_dir}" > /dev/null
fi
if pushd .git > /dev/null
then
  popd > /dev/null
else
  git init
  git remote add    --tags upstream            git@gitlab.com:muttmua/mutt.git
  git remote add --no-tags github_olafhering   git@github.com:olafhering/mutt.git
  git remote add --no-tags gitlab_olafhering   git@gitlab.com:olafhering/mutt.git
  git remote add --no-tags gitlab_olh          gitlab@gitlab.suse.de:olh/mutt.git
fi
popd > /dev/null
#
repo_dir=ovmf.git
if ! pushd "${repo_dir}" > /dev/null
then
  mkdir -v "${repo_dir}"
  pushd "${repo_dir}" > /dev/null
fi
if pushd .git > /dev/null
then
  popd > /dev/null
else
  git init
  git remote add    --tags upstream            git://github.com/tianocore/edk2.git
  git remote add    --tags xenbits_ovmf        git://xenbits.xen.org/ovmf.git
  git remote add --no-tags github_olafhering   git@github.com:olafhering/edk2.git
  git remote add --no-tags gitlab_olafhering   git@gitlab.com:olafhering/edk2.git
  git remote add --no-tags gitlab_olh          gitlab@gitlab.suse.de:olh/ovmf.git
fi
popd > /dev/null
#
repo_dir=qemu.git
if ! pushd "${repo_dir}" > /dev/null
then
  mkdir -v "${repo_dir}"
  pushd "${repo_dir}" > /dev/null
fi
if pushd .git > /dev/null
then
  popd > /dev/null
else
  git init
  git remote add    --tags upstream            git://git.qemu.org/qemu.git
  git remote add --no-tags github_qemu         git://github.com/qemu/qemu.git
  git remote add --no-tags github_olafhering   git@github.com:olafhering/qemu.git
  git remote add --no-tags gitlab_olafhering   git@gitlab.com:olafhering/qemu.git
  git remote add --no-tags gitlab_olh          gitlab@gitlab.suse.de:olh/qemu.git
fi
popd > /dev/null
#
repo_dir=qemu-xen.git
if ! pushd "${repo_dir}" > /dev/null
then
  mkdir -v "${repo_dir}"
  pushd "${repo_dir}" > /dev/null
fi
if pushd .git > /dev/null
then
  popd > /dev/null
else
  git init
  git remote add    --tags upstream            git://xenbits.xen.org/qemu-xen.git
  git remote add    --tags xenbits_qemu        git://xenbits.xen.org/qemu-xen.git
  git remote add --no-tags github_olafhering   git@github.com:olafhering/qemu-xen.git
  git remote add --no-tags gitlab_olafhering   git@gitlab.com:olafhering/qemu-xen.git
  git remote add --no-tags gitlab_olh          gitlab@gitlab.suse.de:olh/qemu-xen.git
fi
popd > /dev/null
#
repo_dir=qemu-xen-traditional.git
if ! pushd "${repo_dir}" > /dev/null
then
  mkdir -v "${repo_dir}"
  pushd "${repo_dir}" > /dev/null
fi
if pushd .git > /dev/null
then
  popd > /dev/null
else
  git init
  git remote add    --tags upstream            git://xenbits.xen.org/qemu-xen-traditional.git
  git remote add    --tags xenbits_qemu_trad   git://xenbits.xen.org/qemu-xen-traditional.git
  git remote add --no-tags github_olafhering   git@github.com:olafhering/qemu-xen-traditional.git
  git remote add --no-tags gitlab_olafhering   git@gitlab.com:olafhering/qemu-xen-traditional.git
  git remote add --no-tags gitlab_olh          gitlab@gitlab.suse.de:olh/qemu-xen-traditional.git
fi
popd > /dev/null
#
repo_dir=keycodemapdb.git
if ! pushd "${repo_dir}" > /dev/null
then
  mkdir -v "${repo_dir}"
  pushd "${repo_dir}" > /dev/null
fi
if pushd .git > /dev/null
then
  popd > /dev/null
else
  git init
  git remote add    --tags upstream            git@gitlab.com:keycodemap/keycodemapdb.git
  git remote add --no-tags gitlab_keycodemapdb git@gitlab.com:keycodemap/keycodemapdb.git
  git remote add --no-tags github_olafhering   git@github.com:olafhering/keycodemapdb.git
  git remote add --no-tags gitlab_olafhering   git@gitlab.com:olafhering/keycodemapdb.git
  git remote add --no-tags gitlab_olh          gitlab@gitlab.suse.de:olh/keycodemapdb.git
fi
popd > /dev/null
#
repo_dir=libvirt.git
if ! pushd "${repo_dir}" > /dev/null
then
  mkdir -v "${repo_dir}"
  pushd "${repo_dir}" > /dev/null
fi
if pushd .git > /dev/null
then
  popd > /dev/null
else
  git init
  git remote add    --tags upstream          git://libvirt.org/libvirt.git
  git remote add --no-tags libvirt_libvirt   git://libvirt.org/libvirt.git
  git remote add --no-tags github_libvirt    git://github.com/libvirt/libvirt.git
  git remote add --no-tags github_olafhering git@github.com:olafhering/libvirt.git
  git remote add --no-tags gitlab_olafhering git@gitlab.com:olafhering/libvirt.git
  git remote add --no-tags gitlab_olh        gitlab@gitlab.suse.de:olh/libvirt.git
fi
popd > /dev/null
#
repo_dir=seabios.git
if ! pushd "${repo_dir}" > /dev/null
then
  mkdir -v "${repo_dir}"
  pushd "${repo_dir}" > /dev/null
fi
if pushd .git > /dev/null
then
  popd > /dev/null
else
  git init
  git remote add    --tags upstream          https://git.seabios.org/cgit/seabios.git/
  git remote add --no-tags seabios_seabios   https://git.seabios.org/cgit/seabios.git/
  git remote add --no-tags seabios_xenbits   git://xenbits.xen.org/seabios.git
  git remote add --no-tags github_olafhering git@github.com:olafhering/seabios.git
  git remote add --no-tags gitlab_olafhering git@gitlab.com:olafhering/seabios.git
  git remote add --no-tags gitlab_olh        gitlab@gitlab.suse.de:olh/seabios.git
fi
popd > /dev/null
#
repo_dir=valgrind.git
if ! pushd "${repo_dir}" > /dev/null
then
  mkdir -v "${repo_dir}"
  pushd "${repo_dir}" > /dev/null
fi
if pushd .git > /dev/null
then
  popd > /dev/null
else
  git init
  git remote add    --tags upstream            git://sourceware.org/git/valgrind.git
  git remote add --no-tags sourceware_valgrind git://sourceware.org/git/valgrind.git
  git remote add --no-tags github_olafhering   git@github.com:olafhering/valgrind.git
  git remote add --no-tags gitlab_olafhering   git@gitlab.com:olafhering/valgrind.git
  git remote add --no-tags gitlab_olh          gitlab@gitlab.suse.de:olh/valgrind.git
fi
popd > /dev/null
#
repo_dir=xen.git
if ! pushd "${repo_dir}" > /dev/null
then
  mkdir -v "${repo_dir}"
  pushd "${repo_dir}" > /dev/null
fi
if pushd .git > /dev/null
then
  popd > /dev/null
else
  git init
  git remote add    --tags upstream          git://xenbits.xen.org/xen.git
  git remote add --no-tags xenbits_xen       git://xenbits.xen.org/xen.git
  git remote add --no-tags github_xen        git://github.com/xen-project/xen.git
  git remote add --no-tags gitlab_xen        git@gitlab.com:xen-project/xen.git
  git remote add --no-tags github_olafhering git@github.com:olafhering/xen.git
  git remote add --no-tags gitlab_olafhering git@gitlab.com:olafhering/xen.git
  git remote add --no-tags gitlab_olh        gitlab@gitlab.suse.de:olh/xen.git
fi
popd > /dev/null
#
