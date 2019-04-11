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
get_grub_file() {
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

  if test "${git_dir}" != "none" && test -d "${git_dir}"
  then
    git_dir="${git_dir}/.git"
    get_tag_hash "${rev}"
    read rev < "${t}"
  fi
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
get_grub_file bootstrap.conf
gnulib_tag=` sed -n '/^GNULIB_REVISION/{s@^.*=@@;p;q}' ${xf} `
get_grub_file bootstrap
gnulib_git_url=` sed -n '/^default_gnulib_url/{s@^.*=@@;p;q}' ${xf} `
gnulib_extract_dir='grub-core/lib/gnulib'
create_submodule \
	"${gnulib_git_url}" \
	"${gnulib_tag}" \
	"${gnulib_extract_dir}"
