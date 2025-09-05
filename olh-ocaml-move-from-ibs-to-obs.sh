#!/bin/bash
set -ex
obs=~/work/obs/devel:languages:ocaml
clean=~/work/obs/clean/devel:languages:ocaml
ibs=~/work/ibs/home:olh:obs:devel:languages:ocaml

declare -i unix_timestamp=0
declare -i ocaml_rpm_macros=
declare -i ibs_ocaml_rpm_macros=
declare -i obs_ocaml_rpm_macros=
declare -A pkg_to_ignore
declare -a pkg_ignore_list
pkg_ignore_file=
timestamp=
copyright_year=
while test $# -gt 0
do
	case "$1" in
	-ts) unix_timestamp=$2 ; shift ;;
	-orm) ocaml_rpm_macros=$2 ; shift ;;
	-i) pkg_ignore_file=$2 ; shift ;;
	*) echo "unhandled arg $0 $*" ; exit 1 ;;
	esac
	shift
done

read timestamp < <(env -i date -ud @${unix_timestamp} '+%a %b %e %H:%M:%S %Z %Y')
read copyright_year < <(env -i date -ud @${unix_timestamp} '+%Y')
: timestamp ${timestamp}
: copyright_year ${copyright_year}
if test "${ocaml_rpm_macros}" -eq 0
then
	spec="${ibs}/ocaml-rpm-macros/ocaml-rpm-macros.spec"
	if test -f "${spec}"
	then
		read ibs_ocaml_rpm_macros < <(awk '/^Version/{print $2}' "${spec}")
	fi
	spec="${obs}/ocaml-rpm-macros/ocaml-rpm-macros.spec"
	if test -f "${spec}"
	then
		read obs_ocaml_rpm_macros < <(awk '/^Version/{print $2}' "${spec}")
	fi
	: ibs_ocaml_rpm_macros ${ibs_ocaml_rpm_macros}
	: obs_ocaml_rpm_macros ${obs_ocaml_rpm_macros}
	if test "${ibs_ocaml_rpm_macros}" -gt "${obs_ocaml_rpm_macros}"
	then
		ocaml_rpm_macros="${ibs_ocaml_rpm_macros}"
	else
		ocaml_rpm_macros="${obs_ocaml_rpm_macros}"
	fi
fi
test "${unix_timestamp}" -gt 0
#
if test -n "${pkg_ignore_file}"
then
	if test -f "${pkg_ignore_file}"
	then
		read -a pkg_ignore_list < <(xargs < "${pkg_ignore_file}")
	else
		echo "${pkg_ignore_file} is not a file"
		exit 1
	fi
	for i in "${pkg_ignore_list[@]}"
	do
		pkg_to_ignore["$i"]=$i
	done
fi
#
maybe_update() {
	local new_pkg
	local pkg=$1
	shift
	local files=( "$@" )

	if pushd "${obs}/${pkg}" > /dev/null
	then
		osc up -u
		olh-remove-braces-from-rpmspec-macros *.spec
		osc commit --noservice -m 'remove braces from rpmspec macros' *.spec
		popd > /dev/null
	else
		new_pkg=${pkg}
		if pushd "${obs}" > /dev/null
		then
			osc mkpac "${pkg}"
			popd > /dev/null
		fi 
	fi

	echo "${#files[@]}: ${files[@]}" 

	for file in "${files[@]}"
	do
		if pushd "${obs}/${pkg}" > /dev/null
		then
			mv -vt . "${ibs}/${pkg}/${file}"
			osc add "${file}"
			popd > /dev/null
		fi
		if pushd "${ibs}/${pkg}" > /dev/null
		then
			osc rm -f "${file}"
			popd > /dev/null
		fi
	done
	if pushd "${ibs}/${pkg}" > /dev/null
	then
		for f in *
		do
			test "${f}" = '_link' && continue
			test -f "${f}" && osc rm -f "${f}"
		done
		if test -n "${new_pkg}"
		then
			echo "<link project='openSUSE.org:devel:languages:ocaml' cicount='add'/>" > '_link'
			osc add '_link'
		fi
		popd > /dev/null
	fi
	if pushd "${obs}/${pkg}" > /dev/null
	then
		olh-remove-braces-from-rpmspec-macros *.spec
		sed -i~ "
s@^# Copyright .*SUSE.*@# Copyright (c) ${copyright_year} SUSE LLC and contributors@
s@^BuildRequires:[[:blank:]]\\+ocaml-rpm-macros.*@BuildRequires:  ocaml-rpm-macros >= ${ocaml_rpm_macros}@
		" *.spec
		read version < <( awk '/^Version:/{print $2}' "${pkg}.spec" )
		echo "Checking ${obs}/${pkg}/_link"
		if osc meta pkg openSUSE:Factory "`cat .osc/_package`" 2>/dev/null | grep -Eq "devel project=\"`cat .osc/_project`\""
		then
			> "${pkg}.changes"
			changes_file=
			read osclib_version < .osc/_osclib_version
			old_service=
			case "${osclib_version}" in
			1.0) old_service=".osc/_service" ;;
			2.0) old_service=".osc/sources/_service" ;;
			esac
			if test -f "${old_service}" && test -f '_service'
			then
				read old_revision < <(sed -n '/name=.revision/{s@^[^>]\+>@@;s@<.*$@@;p}' "${old_service}")
				read new_revision < <(sed -n '/name=.revision/{s@^[^>]\+>@@;s@<.*$@@;p}' _service)
				echo "revision ${old_revision}..${new_revision}"
				if pushd */.git > /dev/null
				then
					cd ..
					read changes_file < <(git --no-pager ls-tree --name-only "${new_revision}" | grep -E '^(CHANGELOG.md|Changes|Changes.md|CHANGES|CHANGES.md|CHANGES.txt|ChangeLog|Changelog)$' || echo)
					if test -n "${changes_file}"
					then
						git --no-pager log --reverse --oneline "${old_revision}..${new_revision}" >> "../${pkg}.changes" || :
					fi
					popd > /dev/null
				fi
			fi
			cat >> "${pkg}.changes" <<_EOF_
-------------------------------------------------------------------
${timestamp} - ohering@suse.de

- Update to version ${version}
_EOF_
			test -n "${changes_file}" && echo "  see included ${changes_file} file for details" >> "${pkg}.changes"
			echo >> "${pkg}.changes"
			cat "${clean}/${pkg}/${pkg}.changes" >> "${pkg}.changes"
			vi "${pkg}.changes"
		else
			cat > "${pkg}.changes" <<_EOF_
-------------------------------------------------------------------
${timestamp} - ohering@suse.de

- Initial version ${version}

_EOF_
		fi
		osc diff | cat
		if test -f '_service'
		then
			read revision < <(sed -n '/name=.revision/{s@^[^>]\+>@@;s@<.*$@@;p}' _service)
			echo "revision ${revision}"
			if pushd */.git > /dev/null
			then
				cd ..
				git --no-pager reset --hard "${revision}"
				git --no-pager status
				git --no-pager log --oneline -n1 "${revision}^!"
				popd > /dev/null
			fi
			osc rm -f *.tar.xz || :
			osc service manualrun
		fi
		osc ar
		osc st
		echo "starting bash prior 'osc commit --noservice'"
		bash
		osc commit --noservice
		if pushd "${ibs}/${pkg}" > /dev/null
		then
			ls -alt
			osc st
			echo "starting bash, suggested command: 'osc commit --noservice -m upstream'"
			bash
			popd > /dev/null
		fi
		popd > /dev/null
	fi
}
#
process_single_pkg() {
	local pkg=$1
	local -a files
	local file

	for file in *
	do
		test -f "${file}" || continue
		case "${file}" in
		*~) continue ;;
		_link) continue ;;
		*.tar.xz) continue ;;
		esac
		if test -f "${obs}/${pkg}/${file}"
		then
			cmp -s "$_" "${file}" || files+=("${file}")
		else
			files+=("${file}")
		fi
	done
	if test "${#files[@]}" -gt 0
	then
		for file in "${files[@]}"
		do
			if test -f "${obs}/${pkg}/${file}"
			then
				diff -ubBw "${obs}/${pkg}/${file}" "${file}" || : differences
			else
				echo "New file ${file}"
			fi
		done
		test -f "${obs}/${pkg}/_link" && head -n1 "$_"
		while true
		do
			read -n 1 -p "${pkg} [u]pdate, [s]kip ...: "
			case "${REPLY}" in
			u) echo ; maybe_update "${pkg}" "${files[@]}" ; break ;;
			s) echo ; break ;;
			\n) ;;
			*) echo ;;
			esac
		done
		echo
	fi
}
#
if pushd "${ibs}" > /dev/null
then
	for pkgd in */.osc
	do
		if pushd "${pkgd}" > /dev/null
		then
			read pkg < _package
			cd ..
			if test -n "${pkg_to_ignore[${pkg}]}"
			then
				echo "pkg ${pkg} skipped, it is in ${pkg_ignore_file}"
			else
				process_single_pkg "${pkg}"
			fi
			popd > /dev/null
		fi
	done
	popd > /dev/null
fi
