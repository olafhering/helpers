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
	*) exit 1 ;;
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
test -n "${upstream}"
test -n "${gitrev}"
case "${upstream}" in
	Zarith) pkg='ocaml-zarith' ;;
	alcotest) pkg='ocaml-alcotest' ;;
	astring) pkg='ocaml-astring' ;;
	base) pkg='ocaml-base' ;;
	base_quickcheck) pkg='ocaml-base_quickcheck' ;;
	bisect_ppx) pkg='ocaml-bisect_ppx' ;;
	bos) pkg='ocaml-bos' ;;
	camlp5) pkg='ocaml-camlp5' ;;
	cinaps) pkg='ocaml-cinaps' ;;
	coq) pkg='ocaml-coq' ;;
	core) pkg='ocaml-core' ;;
	core_kernel) pkg='ocaml-core_kernel' ;;
	cppo) pkg='ocaml-cppo' ;;
	csexp) pkg='ocaml-csexp' ;;
	dose3) pkg='ocaml-dose' ;;
	dune) pkg='ocaml-dune' ;;
	fpath) pkg='ocaml-fpath' ;;
	fmt) pkg='ocaml-fmt' ;;
	gapi-ocaml) pkg='ocaml-gapi' ;;
	google-drive-ocamlfuse) pkg='google-drive-ocamlfuse' ;;
	graphics) pkg='ocaml-graphics' ;;
	jst-config) pkg='ocaml-jst-config' ;;
	lib-ocamlnet3) pkg='ocaml-ocamlnet' ;;
	luv) pkg='ocaml-luv' ;;
	lwt) pkg='ocaml-lwt' ;;
	lwt) pkg='ocaml-lwt_ppx' ;;
	lwt) pkg='ocaml-lwt_react' ;;
	markup.ml) pkg='ocaml-markup.ml' ;;
	mdx) pkg='ocaml-mdx' ;;
	menhir) pkg='ocaml-menhir' ;;
	merlin) pkg='ocaml-merlin' ;;
	num) pkg='ocaml-num' ;;
	ocaml-base64) pkg='ocaml-base64' ;;
	ocaml-cairo) pkg='ocaml-cairo' ;;
	ocaml-ctypes) pkg='ocaml-ctypes' ; echo 'issue #588' ; exit 1 ;;
	ocaml-compiler-libs) pkg='ocaml-ocaml-compiler-libs' ;;
	ocaml-extlib) pkg='ocaml-extlib' ;;
	ocaml-integers) pkg='ocaml-integers' ;;
	ocaml-migrate-parsetree) pkg='ocaml-migrate-parsetree' ;;
	ocaml-re) pkg='ocaml-re' ;;
	ocaml-sha) pkg='ocaml-sha' ;;
	ocaml-ssl) pkg='ocaml-ssl' ;;
	ocaml-version) pkg='ocaml-version' ;;
	ocamlformat) pkg='ocaml-ocamlformat' ;;
	ocamlgraph) pkg='ocaml-ocamlgraph' ;;
	ocplib-endian) pkg='ocaml-ocplib-endian' ;;
	odoc) pkg='ocaml-odoc' ;;
	opam) pkg='opam' ;;
	opam-file-format) pkg='opam-file-format' ;;
	ounit) pkg='ocaml-ounit' ;;
	parmap) pkg='ocaml-parmap' ;;
	parsexp) pkg='ocaml-parsexp' ;;
	pcre-ocaml) pkg='ocaml-pcre' ;;
	ppx_custom_printf) pkg='ocaml-ppx_custom_printf' ;;
	ppx_deriving) pkg='ocaml-ppx_deriving' ;;
	ppx_deriving_yojson) pkg='ocaml-ppx_deriving_yojson' ;;
	ppx_expect) pkg='ocaml-ppx_expect' ;;
	ppx_fields_conv) pkg='ocaml-ppx_fields_conv' ;;
	ppx_inline_test) pkg='ocaml-ppx_inline_test' ;;
	ppx_js_style) pkg='ocaml-ppx_js_style' ;;
	ppx_optcomp) pkg='ocaml-ppx_optcomp' ;;
	ppx_sexp_conv) pkg='ocaml-ppx_sexp_conv' ;;
	ppx_sexp_message) pkg='ocaml-ppx_sexp_message' ;;
	ppx_string) pkg='ocaml-ppx_string' ;;
	ppx_tools) pkg='ocaml-ppx_tools' ;;
	ppx_typerep_conv) pkg='ocaml-ppx_typerep_conv' ;;
	ppx_variants_conv) pkg='ocaml-ppx_variants_conv' ;;
	ppxlib) pkg='ocaml-ppxlib' ;;
	pyml) pkg='ocaml-pyml' ;;
	qcheck) pkg='ocaml-qcheck' ;;
	qtest) pkg='ocaml-qtest' ;;
	result) pkg='ocaml-result' ;;
	rresult) pkg='ocaml-rresult' ;;
	sedlex) pkg='ocaml-sedlex' ;;
	stdcompat) pkg='ocaml-stdcompat' ;;
	stdlib-shims) pkg='ocaml-stdlib-shims' ;;
	sqlite3-ocaml) pkg='ocaml-sqlite' ;;
	unison) pkg='unison' ;;
	utop) pkg='ocaml-utop' ;;
	uucd) pkg='ocaml-uucd' ;;
	uucp) pkg='ocaml-uucp' ;;
	uuseg) pkg='ocaml-uuseg' ;;
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
		e) exit 1 ;;
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
		read -n 1 -p "[d]iff [c]ontinue [e]xit ..."
		case "${REPLY}" in
		d) diff -u "${obs_path}/${service}" "${service}" 2>&1 | less -S ;;
		c) break ;;
		e) exit 1 ;;
		esac
	done
fi
cp -avit . "${obs_path}/${service}"
osc add "${service}"
sed -i~ "s@<param name=\"revision\">[^<]\\+</param>@<param name=\"revision\">${gitrev}</param>@" "${service}"
if diff -u "${obs_path}/${service}" "${service}"
then
	echo "No difference in $_?. Continue?"
fi
read
vi _service
if pushd */.git
then
	cd ..
	git --no-pager fetch --all --prune --tags --prune-tags
	git --no-pager tag --list | xargs git --no-pager tag --delete
	git --no-pager reset --hard "${gitrev}"
	popd
fi
for f in *.tar.xz
do
	test -f "${f}" && osc rm -f "${f}"
done
osc service dr
osc add *.tar.xz
osc diff | cat
vi _service *.spec */*opam
osc commit --noservice -m "${gitrev}" 
