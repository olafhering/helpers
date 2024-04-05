#!/bin/bash
# vim: ts=2 shiftwidth=2 noexpandtab nowrap
set -ex
unset LANG
unset ${!LC_*}
local_username='olaf'
local_home_basedir='/vm_images'
local_homedir="${local_home_basedir}/${local_username}"
declare -i uid='72'
group_users='users'

adjust_user() {
	local homedir
	local group_primary
	local -i existing_uid

	read existing_uid < <(id -u "${local_username}")
	if test "${existing_uid}" = "${uid}"
	then
		echo "Local user ${local_username} with uid ${uid} exists already"
		return
	fi
	echo "Local user ${local_username} has unexpected uid ${existing_uid}, changing to ${uid}"
	if getent group "${group_users}"
	then
		group_primary="-g ${group_users}"
	fi
	if getent group "${local_username}"
	then
		group_primary+=" -a -G ${local_username}"
	fi
	usermod -u "${uid}" ${group_primary} "${local_username}"
	homedir=$( getent passwd "${local_username}" | cut -d: -f6 )
	chown -R -h "${local_username}" "${homedir}"
}

as_root() {
	local group_primary
	local package_hub

	if id "${local_username}"
	then
		adjust_user
		return 0
	fi
	pushd "${local_home_basedir}"
	if getent group "${group_users}"
	then
		group_primary="-g ${group_users}"
	fi
	useradd --create-home --uid "${uid}" ${group_primary} --home-dir "${local_homedir}" "${local_username}"
	id "${local_username}"
	echo "${local_username}:${local_username}" | chpasswd
	pushd "${local_homedir}"
	mkdir -vpm 0700 '.ssh'
	tee -a '.ssh/authorized_keys' <<'_EOAK_'
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDCM4tyGIdcArqS4Kthhui+Y+5XKESRR7vE/EBsmLn0PXVKrp4fvzFngeBHAfyovX45yUZSIqOy9/rSw+44rBAQsfvJxaP9LcszDMyNcoJHHh3/TI3J+cocX7jud1wfARHgwLWmycVq0nr1OrkTnywZBGZTsQg2mz+HuXKnZtjoPvjDzma5DhMb4eiANVVRti/TqmNXSWHSFQuZZNmiTT8xVN1eFB+z51fnlvK3E46vxTUllt1Ihe5TI+k2TJHyzLr2jMh4OvRPE7oYRHTvsLtLoL8R7FgZauPEm5vFuqEyp2MNHpGKl9sOEq6XMjbBAlLSHHaPI/LFJhQbznsUKgQNzb1+Kz/rEWm5FBDsZ0Y0NlQ800bybsj5HmdCJLrekewUFne6/Af6VqBitlEqrpU8fRkLjipKdHMMaEjcT7tNDkXF1x3hfhXTzswHpQF2M+bSSR0EEj4UFi7yXoyCsfZZaddh+t0qMypYpzMi6bjQT8nX+ZkA24u5oUCdJ66T9K8= olaf@aepfle.de
_EOAK_
	tee -a '.ssh/config' <<'_EOC_'
host *
	AddressFamily inet
	ForwardAgent yes
	User root
_EOC_
	chown --recursive --changes --reference=. .ssh
	popd > /dev/null
	popd > /dev/null

	. /etc/os-release

	case "${VERSION}" in
	12*) package_hub=y ; URL_repository='SLE_12' ;;
	15*) package_hub=y ; URL_repository='SLE_15' ;;
	*)   package_hub=n ; URL_repository='openSUSE_Tumbleweed' ;;
	esac
	URL="http://download.opensuse.org/repositories/home:/olh/${URL_repository}"
	if test "${package_hub}" = 'y'
	then
		SUSEConnect -p PackageHub/${VERSION_ID}/$(uname -m) || : FAIL :?
	fi
	zypper ar -cf "${URL}" 'obs-olh' || : FAIL $?
	zypper mr -p 123 'obs-olh' || : FAIL $?

	case "${VERSION}" in
	15-SP3) URL_repository='SLE_15_SP3' ;;
	15-SP4) URL_repository='SLE_15_SP4' ;;
	15-SP5) URL_repository='SLE_15_SP5' ;;
	15-SP6) URL_repository='SLE_15_SP6' ;;
	*) URL_repository='openSUSE_Factory' ;;
	esac
	URL="https://download.opensuse.org/repositories/Kernel:/tools/${URL_repository}"
	zypper ar -cf "${URL}" 'Kernel_tools' || : FAIL $?
	zypper mr -p 123 'Kernel_tools' || : FAIL $?

	zypper ref -s
	zypper in -y helpers || : FAIL $?
	zypper in osc \
		obs-service-download_files \
		obs-service-recompress \
		obs-service-set_version \
		obs-service-tar_scm \
		|| : FAIL $?
	/usr/share/helpers/bin/olh-install-devel_kernel-pattern
}

as_user() {
	pushd ~

	git --no-pager config --global user.name 'Olaf Hering'
	git --no-pager config --global user.email olaf@aepfle.de
	git --no-pager config --global color.ui false
	git --no-pager config --global format.signature ''

	if ! test -d '.git'
	then
		git --no-pager init --initial-branch=master
		git --no-pager remote add 'github_olafhering' 'https://github.com/olafhering/dotfiles.git'
		git --no-pager fetch --all
		git --no-pager reset --hard 'github_olafhering/master'
	fi
	. ~/.shellrc

	. /usr/share/helpers/bin/olh-kerncvs-env
	# update known_hosts early
	ssh -T "${kerncvs_git_user}@${kerncvs_git_srv}" uname -a

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

	olh-kerncvs-__-clone_upstream_linux_mirror.git
	olh-kerncvs-clone_kerncvs_kernel-source_bare -c
	olh-kerncvs-clone_kerncvs_kernel_bare -c
	olh-kerncvs-clone_kerncvs_kernel-source -c
	olh-kerncvs-clone_kerncvs_kernel -c

	for branch in ${kerncvs_active_branches_base[@]} ${kerncvs_active_branches_azure[@]}
	do
		olh-kerncvs-clone_kerncvs_kernel-source_bare "${branch}"
	done
	if pushd kerncvs.kernel-source.git
	then
		for branch in ${kerncvs_active_branches_base[@]} ${kerncvs_active_branches_azure[@]}
		do
			git --no-pager checkout -b "${branch}" "kerncvs/${branch}"
		done
	fi
	olh-kerncvs-update all
}

read id < <(id -u)

case "${id}" in
0) as_root ;;
*) as_user ;;
esac
