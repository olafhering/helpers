#!/bin/bash
# vim: ts=2 shiftwidth=2 noexpandtab nowrap
set -ex
unset LANG
unset ${!LC_*}
pkg=
obs=~/work/obs/clean/devel:languages:ocaml
ibs=~/work/ibs/home:olh:obs:devel:languages:ocaml
obs_path=
ibs_path=
spec=
service=
start_pwd=$PWD
#
if test "$#" -eq 1
then
  : $1
	case "${1}" in
	*://github.com/*/commit/*)
: github
	gitrev="${1##*/}"
	upstream="${1%/*}"
	upstream="${upstream%/commit}"
	upstream="${upstream##*/}"
	;;
	*://gitlab.com/*/commit/*)
: gitlab
	gitrev="${1##*/}"
	upstream="${1%/*}"
	upstream="${upstream%/commit}"
	upstream="${upstream%/-}"
	upstream="${upstream##*/}"
	;;
	*://gitlab.inria.fr/*/commit/*)
: gitlab
	gitrev="${1##*/}"
	upstream="${1%/*}"
	upstream="${upstream%/commit}"
	upstream="${upstream%/-}"
	upstream="${upstream##*/}"
	;;
	*)
		test -d .git || exit 1
		read gitrev < <(git --no-pager rev-list -n1 "$1")
		git --no-pager log --oneline -n1 ${gitrev}
		upstream=${PWD##*/}
	;;
	esac
elif test "$#" -eq 2
then
upstream=$1
gitrev=$2
test -n "$3" && ibs="${ibs}:$3"
elif test "$#" -eq 3
then
upstream=$1
gitrev=$2
ibs="${ibs}:$3"
else
	exit 1
fi
#
select_lablgtk() {
	while true
	do
		read -n 1 -p "[2] ocaml-lablgtk2, [3] ocaml-lablgtk3"
		case "${REPLY}" in
		2) pkg='ocaml-lablgtk2' ; break ;;
		3) pkg='ocaml-lablgtk3' ; break ;;
		esac
	done
}
select_lwt() {
	while true
	do
		read -n 1 -p "[1] ocaml-lwt, [2] ocaml-lwt_ppx, [3] ocaml-lwt_react"
		case "${REPLY}" in
		1) pkg='ocaml-lwt' ; break ;;
		2) pkg='ocaml-lwt_ppx' ; break ;;
		3) pkg='ocaml-lwt_react' ; break ;;
		esac
	done
}
test -n "${upstream}"
test -n "${gitrev}"
case "${upstream}" in
	Camomile) pkg='ocaml-camomile' ;;
	Zarith) pkg='ocaml-zarith' ;;
	alcotest) pkg='ocaml-alcotest' ;;
	astring) pkg='ocaml-astring' ;;
	base) pkg='ocaml-base' ;;
	base_bigstring) pkg='ocaml-base_bigstring' ;;
	base_quickcheck) pkg='ocaml-base_quickcheck' ;;
	bigarray-compat) pkg='ocaml-bigarray-compat' ;;
	bigstringaf) pkg='ocaml-bigstringaf' ;;
	bin_prot) pkg='ocaml-bin_prot' ;;
	biniou) pkg='ocaml-biniou' ;;
	bisect_ppx) pkg='ocaml-bisect_ppx' ;;
	bos) pkg='ocaml-bos' ;;
	calendar) pkg='ocaml-calendar' ;;
	camlidl) pkg='ocaml-camlidl' ;;
	camlp-streams) pkg='ocaml-camlp-streams' ;;
	camlp5) pkg='ocaml-camlp5' ;;
	camlzip) pkg='ocaml-camlzip' ;;
	charinfo_width) pkg='ocaml-charinfo_width' ;;
	cinaps) pkg='ocaml-cinaps' ;;
	cmdliner) pkg='ocaml-cmdliner' ;;
	coq) pkg='ocaml-coq' ;;
	core) pkg='ocaml-core' ;;
	core_bench) pkg='ocaml-core_bench' ;;
	core_kernel) pkg='ocaml-core_kernel' ;;
	core_unix) pkg='ocaml-core_unix' ;;
	cppo) pkg='ocaml-cppo' ;;
	cryptokit) pkg='ocaml-cryptokit' ;;
	csexp) pkg='ocaml-csexp' ;;
	cudf) pkg='ocaml-cudf' ;;
	curses) pkg='ocaml-curses' ;;
	domain-local-await) pkg='ocaml-domain-local-await' ;;
	dose3) pkg='ocaml-dose' ;;
	dune) pkg='ocaml-dune' ;;
	easy-format) pkg='ocaml-easy-format' ;;
	eio) pkg='ocaml-eio' ;;
	expect_test_helpers_core) pkg='ocaml-expect_test_helpers_core' ;;
	fieldslib) pkg='ocaml-fieldslib' ;;
	fix) pkg='ocaml-fix' ;;
	fmt) pkg='ocaml-fmt' ;;
	fpath) pkg='ocaml-fpath' ;;
	gapi-ocaml) pkg='ocaml-gapi' ;;
	gen) pkg='ocaml-gen' ;;
	google-drive-ocamlfuse) pkg='google-drive-ocamlfuse' ;;
	graphics) pkg='ocaml-graphics' ;;
	hmap) pkg='ocaml-hmap' ;;
	int_repr) pkg='ocaml-int_repr' ;;
	jane-street-headers) pkg='ocaml-jane-street-headers' ;;
	jane_rope) pkg='ocaml-jane_rope' ;;
	jsonm) pkg='ocaml-jsonm' ;;
	jst-config) pkg='ocaml-jst-config' ;;
	lablgtk) select_lablgtk ;;
	lambda-term) pkg='ocaml-lambda-term' ;;
	lib-ocamlnet3) pkg='ocaml-ocamlnet' ;;
	libvirt-ocaml) pkg='ocaml-libvirt' ;;
	logs) pkg='ocaml-logs' ;;
	luv) pkg='ocaml-luv' ;;
	lwt) select_lwt ;;
	lwt-dllist) pkg='ocaml-lwt-dllist' ;;
	lwt_log) pkg='ocaml-lwt_log' ;;
	markup.ml) pkg='ocaml-markup.ml' ;;
	mdx) pkg='ocaml-mdx' ;;
	menhir) pkg='ocaml-menhir' ;;
	merlin) pkg='ocaml-merlin' ;;
	mmap) pkg='ocaml-mmap' ;;
	mtime) pkg='ocaml-mtime' ;;
	num) pkg='ocaml-num' ;;
	ocaml-base64) pkg='ocaml-base64' ;;
	ocaml-benchmark) pkg='ocaml-benchmark' ;;
	ocaml-cairo) pkg='ocaml-cairo' ;;
	ocaml-compiler-libs) pkg='ocaml-ocaml-compiler-libs' ;;
	ocaml-crunch) pkg='ocaml-crunch' ;;
	ocaml-cstruct) pkg='ocaml-cstruct' ;;
	ocaml-ctypes) pkg='ocaml-ctypes' ;;
	ocaml-either) pkg='ocaml-either' ;;
	ocaml-extlib) pkg='ocaml-extlib' ;;
	ocaml-fileutils) pkg='ocaml-fileutils' ;;
	ocaml-gettext) pkg='ocaml-gettext' ;;
	ocaml-integers) pkg='ocaml-integers' ;;
	ocaml-lsp) pkg='ocaml-lsp-server' ;;
	ocaml-lwt-dllist) pkg='ocaml-lwt-dllist' ;;
	ocaml-mccs) pkg='ocaml-mccs' ;;
	ocaml-migrate-parsetree) pkg='ocaml-migrate-parsetree' ;;
	ocaml-minisat) pkg='ocaml-minisat' ;;
	ocaml-re) pkg='ocaml-re' ;;
	ocaml-sha) pkg='ocaml-sha' ;;
	ocaml-ssl) pkg='ocaml-ssl' ;;
	ocaml-uring) pkg='ocaml-uring' ;;
	ocaml-version) pkg='ocaml-version' ;;
	ocaml-wayland) pkg='ocaml-wayland' ;;
	ocaml_intrinsics) pkg='ocaml-ocaml_intrinsics' ;;
	ocamlbuild) pkg='ocaml-ocamlbuild' ;;
	ocamlfind) pkg='ocaml-findlib' ; echo "download tar.gz" ; exit 1 ;;
	ocamlformat) pkg='ocaml-ocamlformat' ;;
	ocamlfuse) pkg='ocaml-fuse' ;;
	ocamlgraph) pkg='ocaml-ocamlgraph' ;;
	ocp-indent) pkg='ocaml-ocp-indent' ;;
	ocplib-endian) pkg='ocaml-ocplib-endian' ;;
	ocurl) pkg='ocaml-ocurl' ;;
	odoc) pkg='ocaml-odoc' ;;
	odoc-parser) pkg='ocaml-odoc-parser' ;;
	omd) pkg='ocaml-omd' ;;
	opam) pkg='opam' ;;
	opam-file-format) pkg='opam-file-format' ;;
	optint) pkg='ocaml-optint' ;;
	ounit) pkg='ocaml-ounit' ;;
	parmap) pkg='ocaml-parmap' ;;
	parsexp) pkg='ocaml-parsexp' ;;
	pcre-ocaml) pkg='ocaml-pcre' ;;
	pp) pkg='ocaml-pp' ;;
	ppx_assert) pkg='ocaml-ppx_assert' ;;
	ppx_base) pkg='ocaml-ppx_base' ;;
	ppx_bench) pkg='ocaml-ppx_bench' ;;
	ppx_bin_prot) pkg='ocaml-ppx_bin_prot' ;;
	ppx_cold) pkg='ocaml-ppx_cold' ;;
	ppx_compare) pkg='ocaml-ppx_compare' ;;
	ppx_custom_printf) pkg='ocaml-ppx_custom_printf' ;;
	ppx_deriving) pkg='ocaml-ppx_deriving' ;;
	ppx_deriving_yojson) pkg='ocaml-ppx_deriving_yojson' ;;
	ppx_disable_unused_warnings) pkg='ocaml-ppx_disable_unused_warnings' ;;
	ppx_enumerate) pkg='ocaml-ppx_enumerate' ;;
	ppx_expect) pkg='ocaml-ppx_expect' ;;
	ppx_fields_conv) pkg='ocaml-ppx_fields_conv' ;;
	ppx_fixed_literal) pkg='ocaml-ppx_fixed_literal' ;;
	ppx_globalize) pkg='ocaml-ppx_globalize' ;;
	ppx_hash) pkg='ocaml-ppx_hash' ;;
	ppx_here) pkg='ocaml-ppx_here' ;;
	ppx_ignore_instrumentation) pkg='ocaml-ppx_ignore_instrumentation' ;;
	ppx_inline_test) pkg='ocaml-ppx_inline_test' ;;
	ppx_jane) pkg='ocaml-ppx_jane' ;;
	ppx_js_style) pkg='ocaml-ppx_js_style' ;;
	ppx_let) pkg='ocaml-ppx_let' ;;
	ppx_log) pkg='ocaml-ppx_log' ;;
	ppx_module_timer) pkg='ocaml-ppx_module_timer' ;;
	ppx_optcomp) pkg='ocaml-ppx_optcomp' ;;
	ppx_optional) pkg='ocaml-ppx_optional' ;;
	ppx_pipebang) pkg='ocaml-ppx_pipebang' ;;
	ppx_sexp_conv) pkg='ocaml-ppx_sexp_conv' ;;
	ppx_sexp_message) pkg='ocaml-ppx_sexp_message' ;;
	ppx_sexp_value) pkg='ocaml-ppx_sexp_value' ;;
	ppx_stable) pkg='ocaml-ppx_stable' ;;
	ppx_stable_witness) pkg='ocaml-ppx_stable_witness' ;;
	ppx_string) pkg='ocaml-ppx_string' ;;
	ppx_tools) pkg='ocaml-ppx_tools' ;;
	ppx_tydi) pkg='ocaml-ppx_tydi' ;;
	ppx_typerep_conv) pkg='ocaml-ppx_typerep_conv' ;;
	ppx_variants_conv) pkg='ocaml-ppx_variants_conv' ;;
	ppx_yojson_conv_lib) pkg='ocaml-ppx_yojson_conv_lib' ;;
	ppxlib) pkg='ocaml-ppxlib' ;;
	psq) pkg='ocaml-psq' ;;
	ptime) pkg='ocaml-ptime' ;;
	pyml) pkg='ocaml-pyml' ;;
	qcheck) pkg='ocaml-qcheck' ;;
	qtest) pkg='ocaml-qtest' ;;
	re2) pkg='ocaml-re2' ;;
	react) pkg='ocaml-react' ;;
	regex_parser_intf) pkg='ocaml-regex_parser_intf' ;;
	result) pkg='ocaml-result' ;;
	rresult) pkg='ocaml-rresult' ;;
	sedlex) pkg='ocaml-sedlex' ;;
	sexp_pretty) pkg='ocaml-sexp_pretty' ;;
	sexplib) pkg='ocaml-sexplib' ;;
	sexplib0) pkg='ocaml-sexplib0' ;;
	spawn) pkg='ocaml-spawn' ;;
	spdx_licenses) pkg='ocaml-spdx_licenses' ;;
	splittable_random) pkg='ocaml-splittable_random' ;;
	sqlite3-ocaml) pkg='ocaml-sqlite' ;;
	stdcompat) pkg='ocaml-stdcompat' ;;
	stdio) pkg='ocaml-stdio' ;;
	stdlib-shims) pkg='ocaml-stdlib-shims' ;;
	textutils) pkg='ocaml-textutils' ;;
	textutils_kernel) pkg='ocaml-textutils_kernel' ;;
	thread-table) pkg='ocaml-thread-table' ;;
	time_now ) pkg='ocaml-time_now' ;;
	timezone ) pkg='ocaml-timezone' ;;
	tiny_httpd) pkg='ocaml-tiny_httpd' ;;
	typerep) pkg='ocaml-typerep' ;;
	tyxml) pkg='ocaml-tyxml' ;;
	unison) pkg='unison' ;;
	utop) pkg='ocaml-utop' ;;
	uucd) pkg='ocaml-uucd' ;;
	uucp) pkg='ocaml-uucp' ;;
	uuidm) pkg='ocaml-uuidm' ;;
	uuseg) pkg='ocaml-uuseg' ;;
	uutf) pkg='ocaml-uutf' ;;
	variantslib) pkg='ocaml-variantslib' ;;
	virt-top) pkg='virt-top' ;;
	xml-light) pkg='ocaml-xml-light' ;;
	xmlm) pkg='ocaml-xmlm' ;;
	yojson) pkg='ocaml-yojson' ;;
	zed) pkg='ocaml-zed' ;;
	*) exit 1 ;;
esac
#
pushd "${obs}" > /dev/null
	pushd "${pkg}/.osc" > /dev/null
		cd ..
		obs_path="$PWD"
		ls -alt
		osc up -u
	popd > /dev/null
popd > /dev/null
#
pushd "${ibs}" > /dev/null
	pushd "${pkg}/.osc" > /dev/null
		cd ..
		ibs_path="$PWD"
		ls -alt
		osc up -u
	popd > /dev/null
popd > /dev/null
#
pushd "${ibs_path}"
spec="${pkg}.spec"
if test -f "${spec}"
then
	echo "$_ exists. Continue?"
	while true
	do
		read -n 1 -p "[d]iff [c]ontinue [e]xit ..."
		case "${REPLY}" in
		d) diff -u "${obs_path}/${spec}" "${spec}" 2>&1 | less -S ;;
		c) break ;;
		e) exit 0 ;;
		esac
	done
else
	cp -avit . "${obs_path}/${spec}"
	osc add "${spec}"
	osc commit --noservice -m 'upstream' 
fi
#
service='_service'
if test -f "${service}"
then
	echo "$_ exists. Continue?"
	while true
	do
		read -n 1 -p "[d]iff [c]ontinue [e]xit [l]og [p]atch ..."
		case "${REPLY}" in
		d) diff -u "${obs_path}/${service}" "${service}" 2>&1 | less -S ;;
		c) break ;;
		e) exit 0 ;;
		l)
		read current_gitrev < <(sed -n 's@^\(.*<param name=.revision.>\)\([^<]\+\)\(.*\)@\2@p' "${service}")
		new_gitrev="${gitrev}"
		if pushd "${start_pwd}/.git" > /dev/null
		then
			cd ..
			git log -p -M --stat --pretty=fuller -b -B -w "${current_gitrev}..${new_gitrev}" || : git-log $?
			popd > /dev/null
		fi
		;;
		p)
		read current_gitrev < <(sed -n 's@^\(.*<param name=.revision.>\)\([^<]\+\)\(.*\)@\2@p' "${service}")
		new_gitrev="${gitrev}"
		if pushd "${start_pwd}/.git" > /dev/null
		then
			cd ..
			git diff -p -b -B -w "${current_gitrev}..${new_gitrev}" || : git-diff $?
			popd > /dev/null
		fi
		;;
		esac
	done
else
	cp -avit . "${obs_path}/${service}"
	while true
	do
		read -n 1 -p "[c]ontinue [e]xit [l]og [p]atch ..."
		case "${REPLY}" in
		c) break ;;
		e) exit 0 ;;
		l)
		read current_gitrev < <(sed -n 's@^\(.*<param name=.revision.>\)\([^<]\+\)\(.*\)@\2@p' "${service}")
		new_gitrev="${gitrev}"
		if pushd "${start_pwd}/.git" > /dev/null
		then
			cd ..
			git log -p -M --stat --pretty=fuller -b -B -w "${current_gitrev}..${new_gitrev}" || : git-log $?
			popd > /dev/null
		fi
		;;
		p)
		read current_gitrev < <(sed -n 's@^\(.*<param name=.revision.>\)\([^<]\+\)\(.*\)@\2@p' "${service}")
		new_gitrev="${gitrev}"
		if pushd "${start_pwd}/.git" > /dev/null
		then
			cd ..
			git diff -p -b -B -w "${current_gitrev}..${new_gitrev}" || : git-diff $?
			popd > /dev/null
		fi
		;;
		esac
	done
fi
osc add "${service}"
sed -i~ "
s@<param name=\"revision\">[^<]\\+</param>@<param name=\"revision\">${gitrev}</param>@
s@mode=['\"]disabled['\"]@mode=\"manual\"@
" "${service}"
if diff -u "${obs_path}/${service}" "${service}"
then
	echo "No difference in $_?. Continue?"
fi
read
vi _service
if pushd */.git
then
	cd ..
	git --no-pager tag --list | xargs git --no-pager tag --delete
	git --no-pager fetch --all --prune --tags --prune-tags
	git --no-pager reset --hard "${gitrev}"
	popd
fi
for f in *.tar.xz
do
	test -f "${f}" && osc rm -f "${f}"
done
osc service manualrun
osc add *.tar.xz
osc diff | cat
vi _service *.spec */*opam
osc commit --noservice -m "${gitrev}" 
