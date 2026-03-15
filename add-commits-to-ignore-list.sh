# vim: nowrap noexpandtab tw=4 ts=4
set -e
read t < <(mktemp --tmpdir=/Tmpfs .XXXX)
trap "rm -f $t" EXIT
. /usr/share/helpers/bin/olh-kerncvs-env
for ignore_file in olh-kerncvs-ignore_hyper_v_commits-*.txt
do
	branch=${ignore_file%.*}
	branch=${branch#olh-kerncvs-ignore_hyper_v_commits-*}
	if [[ " ${kerncvs_active_branches_base[*]} " =~ " ${branch} " ]]
	then
		read SRCVERSION < <(git --no-pager --git-dir=$(ls -1d ${WORK_KERNEL}/kerncvs.kernel-source.bare.mirror) show "${branch}:rpm/config.sh"|awk -F '=' '/^SRCVERSION/{print $2}')
		echo "${branch} ${SRCVERSION}"
	else
		continue
	fi
	for commit in "$@"
	do
		: ${commit}
		read patch_tag < <(git --no-pager --git-dir=${LINUX_GIT}/.git describe --contains "${commit}")
		patch_tag=${patch_tag%%-*}
		patch_tag=${patch_tag%%~*}
		patch_tag=${patch_tag#v*}
		if /usr/bin/zypper --quiet versioncmp "${patch_tag}" "${SRCVERSION}"
		then
			echo "${commit} ${patch_tag} part of ${SRCVERSION}"
			sed -i /${commit}/d "${ignore_file}"
			continue
		else
			case "$?" in
			11)
				: "${patch_tag} > ${SRCVERSION}"
				echo "${commit} ${patch_tag} newer than ${SRCVERSION}"
				;;
			12)
				: "${patch_tag} < ${SRCVERSION}"
				echo "${commit} ${patch_tag} part of ${SRCVERSION}"
				sed -i /${commit}/d "${ignore_file}"
				continue
				;;
			*) echo "Unhandled return value $_ from zypper" ; continue ;;
			esac
		fi
		if git --no-pager --git-dir=$(ls -1d ~/work/src/kernel/kerncvs.kernel-source.bare.mirror) grep -q "${commit}" "${branch}"
		then
			echo "${commit} commited to ${branch}"
			sed -i /${commit}/d "${ignore_file}"
			continue
		fi
		(
			echo ${commit}
			cat "$ignore_file"
		) | sort -u > "$t"
		if cmp -s "$ignore_file" "$t"
		then
			rm "$t"
		else
			mv -v "$t" "$ignore_file"
		fi
	done
done
