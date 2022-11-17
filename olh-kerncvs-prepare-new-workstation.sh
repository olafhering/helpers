#!/bin/bash
# vim: ts=2 shiftwidth=2 noexpandtab nowrap
set -ex
unset LANG
unset ${!LC_*}
local_username='olaf'
local_home_basedir='/vm_images'
local_homedir="${local_home_basedir}/${local_username}"


as_root() {
	if id "${local_username}"
	then
		return 0
	fi
	pushd "${local_home_basedir}"
	useradd --create-home --uid 72 --home-dir "${local_homedir}" "${local_username}"
	id "${local_username}"
	echo "${local_username}:${local_username}" | chpasswd
	pushd "${local_homedir}"
	mkdir -vpm 0700 '.ssh'
	tee -a '.ssh/authorized_keys' <<'_EOAK_'
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJx/y+w/YjMOJyqhiW9q3eOxvTy7aQFXFq6UvX1NLPdd6KojPFMXgBWTDAXaHwRcn8Lv3tiHzO3v5rZK/e73w7NG8wZS6wRnoSST1Vmp7Rr2MGwe04pzYjCKjuxaP58j/ZFE6TTMtNGVfQenrS1yXYiLBv/6Aq5yMXJeX5k9qDyiNgmgKFnOFj0/3l6NUaZ24/3dSQ98/u8Msy8ZdfLiA6od/VTlc9e5tPtxLRsVeCpxVk9go4nQ+LlMRbjdoZSMFM+xrUslXeW2KWk5rsJSYoAazV9JVE/H+iTpzKHA8c+QZjU1M7/wtOPSEXzsbYrMRL/MGib4TrEE57ezLs5Qth ohering@suse.de
_EOAK_
	tee -a '.ssh/config' <<'_EOC_'
host *
	ForwardAgent yes
	AddressFamily = inet
	user = root
_EOC_
	chown --recursive --changes --reference=. .ssh
	popd > /dev/null
	popd > /dev/null

	. /etc/os-release

	case "${VERSION}" in
	12*) URL_repository='SLE_12' ;;
	15*) URL_repository='SLE_15' ;;
	*) URL_repository='openSUSE_Tumbleweed' ;;
	esac
	URL="http://download.opensuse.org/repositories/home:/olh/${URL_repository}"
	zypper ar -cf "${URL}" 'olh'
	zypper mr -p 123 'olh'

	case "${VERSION}" in
	15-SP3) URL_repository='SLE_15_SP3' ;;
	15-SP4) URL_repository='SLE_15_SP4' ;;
	15-SP5) URL_repository='SLE_15_SP5' ;;
	*) URL_repository='openSUSE_Factory' ;;
	esac
	URL="https://download.opensuse.org/repositories/Kernel:/tools/${URL_repository}"
	zypper ar -cf "${URL}" 'Kernel_tools'
	zypper mr -p 123 'Kernel_tools'

	zypper ref -s
	zypper in -y helpers
	/usr/share/helpers/bin/olh-install-devel_kernel-pattern
}

as_user() {
	pushd ~

	if ! test -d '.git'
	then
		git --no-pager init --initial-branch=master
		git --no-pager remote add 'github_olafhering' 'https://github.com/olafhering/dotfiles.git'
		git --no-pager fetch --all
		git --no-pager reset --hard 'github_olafhering/master'
	fi

	. /usr/share/helpers/bin/olh-kerncvs-env

	if ! test -d "${LINUX_GIT}"
	then
		mkdir -vp "${_}"
		pushd "${_}"
		git --no-pager init --initial-branch=master
		case "$(hostname -f)" in
		*.devlab.pgu1.suse.com)
			git --no-pager remote add --no-tags 'code-mirror' 'git://code-mirror/linux.git'
			git --no-pager fetch 'code-mirror'
		;;
		esac
		git --no-pager remote add --no-tags 'github' 'https://github.com/torvalds/linux.git'
		git --no-pager fetch 'github'
		git --no-pager remote remove 'github'
		git --no-pager remote add 'LINUX_GIT' 'https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git'
		git --no-pager fetch 'LINUX_GIT'
		popd
	fi

	/usr/share/helpers/bin/olh-kerncvs-__-clone_upstream_linux_mirror.git
	/usr/share/helpers/bin/olh-kerncvs-clone_kerncvs_kernel-source_bare -c
	/usr/share/helpers/bin/olh-kerncvs-clone_kerncvs_kernel_bare -c
}

read id < <(id -u)

case "${id}" in
0) as_root ;;
*) as_user ;;
esac
