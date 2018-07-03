#!/bin/bash
#et -x
set -e
unset LANG
unset ${!LC*}

work_dir=
out_dir=
git_dir=
git_upstream_url=
git_upstream_remote=
git_upstream_branch=
git_upstream_commit=
#
git=$(type -P git)
declare -i counter=0
t=`mktemp`
xf=`mktemp`
trap "rm -f \"${t}\" \"${xf}\" ; : $0" EXIT
#
while test $# -gt 0
do
  : $1
  case "$1" in
    --outdir) out_dir=$2 ; shift ;;
    --workdir) work_dir=$2 ; shift ;;
    --git-dir) git_dir=$2 ; shift ;;
    --git-upstream-url) git_upstream_url=$2 ; shift ;;
    --git-upstream-remote) git_upstream_remote=$2 ; shift ;;
    --git-upstream-branch) git_upstream_branch=$2 ; shift ;;
    *) echo "UNHANDLED: $0 $*" >&2 ; exit 1 ;;
  esac
  shift
done
#
: work_dir "${work_dir}"
test -n "${work_dir}"
pushd "${work_dir}" > /dev/null
#
: out_dir "${out_dir}"
test -n "${out_dir}"
pushd "${out_dir}" > /dev/null
#
: git_dir "${git_dir}"
test -d "${git_dir}"
git_dir="${git_dir}/.git"
#
g() {
  ${git} \
  "--git-dir=${git_dir}" \
  "--no-pager" \
  "$@" < /dev/null
}
#
get_tag_hash() {
  local tag=$1
  if g log --max-count=1 '--pretty=format:%H%n' "${tag}" > "${t}" 2>/dev/null
  then
    : good
  elif g log --max-count=1 '--pretty=format:%H%n' "${git_upstream_remote}/${tag}" > "${t}"
  then
    : also good
  fi
  test -s "${t}"
}
#
get_tip_hash() {
  get_tag_hash "${git_upstream_remote}/${git_upstream_branch}"
  test -s "${t}"
  read git_upstream_commit < "${t}"
}
#
get_xen_file() {
  local file=$1
  g show "${git_upstream_remote}/${git_upstream_branch}:${file}" > "${xf}"
}
#
create_submodule() {
  local url=$1
  local rev=$2
  local path=$3
  local o_git_dir="${git_dir}"
  local git_dir="` olh-obs_scm-remap-gitrepo-url ${url} 'dir' `"

  test -d "${git_dir}"
  git_dir="${git_dir}/.git"
  get_tag_hash "${rev}"
  read rev < "${t}"
  submodule="git.submodule.$(( counter++ )).txt"
  {
    echo "path='${path}'"
    echo "url='${url}'"
    echo "rev='${rev}'"
  } > "${submodule}"

  git_dir="${o_git_dir}"
}
#
get_tip_hash
echo "tip @ ${git_upstream_commit}"
#
get_xen_file xen/Makefile
xen_version=`awk '/[[:blank:]]XEN_VERSION[[:blank:]]+=/ { print $4 }' ${xf}`.`awk '/[[:blank:]]XEN_SUBVERSION[[:blank:]]+=/ { print $4 }' ${xf}`
case "${xen_version}" in
        *.|.*) exit 1 ;;
        *) : good ;;
esac
echo "${xen_version}" > version_prefix.txt
#
#
get_xen_file Config.mk
qemu_xen_traditional_git_url=` sed -n '/^QEMU_\(TRADITIONAL_URL\|REMOTE\).*git:\/\//{s@^.* @@;p;q}' ${xf} `
qemu_xen_traditional_tag=` sed -n '/^QEMU_\(TRADITIONAL_REVISION\|TAG\)/{s@^.* @@;p;q};/^QEMU_TAG/{s@^.* @@;p;q}' ${xf} `
qemu_xen_traditional_extract_dir=tools/qemu-xen-traditional-dir-remote
create_submodule \
	"${qemu_xen_traditional_git_url}" \
	"${qemu_xen_traditional_tag}" \
	"${qemu_xen_traditional_extract_dir}"
#
qemu_xen_upstream_git_url=`sed -n '/^QEMU_UPSTREAM_URL.*git:\/\//{s@^.* @@;p;q}' ${xf}`
qemu_xen_upstream_tag=`sed -n '/^QEMU_UPSTREAM_REVISION/{s@^.* @@;p;q}' ${xf}`
qemu_xen_upstream_extract_dir=tools/qemu-xen-dir-remote
create_submodule \
	"${qemu_xen_upstream_git_url}" \
	"${qemu_xen_upstream_tag}" \
	"${qemu_xen_upstream_extract_dir}"
#
seabios_git_url=`sed -n '/^SEABIOS_UPSTREAM_URL.*git:\/\//{;s@^.* @@;p;q}' ${xf}`
seabios_tag=`sed -n '/^SEABIOS_UPSTREAM_\(REVISION\|TAG\)/{s@^.* @@;p;q}' ${xf}`
seabios_extract_dir=tools/firmware/seabios-dir-remote
create_submodule \
	"${seabios_git_url}" \
	"${seabios_tag}" \
	"${seabios_extract_dir}"
#
minios_git_url=`sed -n '/^MINIOS_UPSTREAM_URL.*git:\/\//{;s@^.* @@;p;q}' ${xf}`
minios_tag=`sed -n '/^MINIOS_UPSTREAM_REVISION/{/OVMF_UPSTREAM_TAG/d;s@^.* @@;p;q}' ${xf}`
minios_extract_dir=extras/mini-os-remote
if test -n "${minios_git_url}" && test -n "${minios_tag}"
then
	create_submodule \
	"${minios_git_url}" \
	"${minios_tag}" \
	"${minios_extract_dir}"
fi
#
ovmf_git_url=`sed -n '/^OVMF_UPSTREAM_URL.*git:\/\//{;s@^.* @@;p;q}' ${xf}`
ovmf_tag=`sed -n '/^OVMF_UPSTREAM_REVISION/{/OVMF_UPSTREAM_TAG/d;s@^.* @@;p;q}' ${xf}`
ovmf_extract_dir=tools/firmware/ovmf-dir-remote
create_submodule \
	"${ovmf_git_url}" \
	"${ovmf_tag}" \
	"${ovmf_extract_dir}"
#
#
get_xen_file tools/firmware/etherboot/Makefile
ipxe_git_url=`sed -n '/^IPXE_GIT_URL.*git:\/\//{s@^.* @@;p;q}' ${xf} `
ipxe_tag=`sed -n '/^IPXE_GIT_TAG/{s@^.* @@;p;q}' ${xf} `
ipxe_extract_dir=tools/firmware/etherboot/ipxe
create_submodule \
	"${ipxe_git_url}" \
	"${ipxe_tag}" \
	"${ipxe_extract_dir}"
#
