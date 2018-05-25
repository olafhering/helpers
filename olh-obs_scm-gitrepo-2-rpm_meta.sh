#!/bin/bash
#et -x
set -e
unset LANG
unset ${!LC*}
#
work_dir=
out_dir=
direct_submodules=true
git_dir=
git_fixes_base=
git_fixes_branch=
git_fixes_tag=
git_fixes_remote=
git_upstream_branch=
git_upstream_commit=
git_upstream_remote=
git_upstream_url=
pkg_tag=
submodule_tag=
pkg_patch_basedir=
patches_dir=
git=$(type -P git)
t=`mktemp`
tf=`mktemp`
tt=`mktemp`
#
g() {
  ${git} \
  "--git-dir=${git_dir}" \
  "--no-pager" \
  "$@" < /dev/null
}

allow_submodule() {
  local allow=true
  local tag=$1
  local raw_url=$2
  local remap_url
  local url_tag

  remap_url="`olh-obs_scm-remap-gitrepo-url ${raw_url} 'url'`"
  test -n "${remap_url}" || return 1
  url_tag="`olh-obs_scm-remap-gitrepo-url ${remap_url} 'tag'`"
  
  case "${tag}@${url_tag}" in
    qemu_xen@ipxe) allow=false ;;
    qemu_xen@seabios) allow=false ;;
    qemu_xen@sgabios) allow=false ;;
    *) ;;
  esac
  if test "${allow}" = "true"
  then
    echo "submodule ${tag}/${url_tag} allowed"
    return 0
  fi
  echo "submodule ${tag}/${url_tag} denied"
  return 1
}
process_submodules() {
  local rev=$1
  local submodules=$2
  local tag=$3
  local got_path got_url
  local var equal val rest
  local umask commit submod_revision submod_path
  local submodule counter=0
  while read var equal val rest
  do
    : var ${var}
    case "${var}" in
     \[*) unset got_path got_url ;; # ]
    esac
    if test "${got_path}" = "" && test "${var}" = "path"
    then
      got_path="${val}"
    fi
    if test "${got_url}" = "" && test "${var}" = "url"
    then
      got_url="${val}"
    fi
    if test -n "${got_path}" && test -n "${got_url}"
    then
      g ls-tree "${rev}" "${got_path}" > ${t}
      read umask commit submod_revision submod_path rest < ${t}
      if test "${umask}" =  "160000" && allow_submodule "${tag}" "${got_url}"
      then
        submodule="git.submodule.$(( counter++ )).txt"
        {
          echo "path='${got_path}'"
          echo "url='${got_url}'"
          echo "rev='${submod_revision}'"
        } > "${submodule}"
      fi
    fi
  done < "${submodules}"
}
#
while test $# -gt 0
do
  : $1
  case "$1" in
    --outdir) out_dir=$2 ; shift ;;
    --workdir) work_dir=$2 ; shift ;;
    --git-dir) git_dir=$2 ; shift ;;
    --no-direct-submodules) direct_submodules= ;;
    --git-upstream-commit) git_upstream_commit=$2 ; shift ;;
    --git-upstream-url) git_upstream_url=$2 ; shift ;;
    --git-upstream-remote) git_upstream_remote=$2 ; shift ;;
    --git-upstream-branch) git_upstream_branch=$2 ; shift ;;
    --git-fixes-remote) git_fixes_remote=$2 ; shift ;;
    --git-fixes-base) git_fixes_base=$2 ; shift ;;
    --git-fixes-branch) git_fixes_branch=$2 ; shift ;;
    --git-fixes-tag) git_fixes_tag="-$2" ; shift ;;
    --pkg-tag) pkg_tag=$2 ; shift ;;
    --submodule-tag) submodule_tag=$2 ; shift ;;
    --pkg-patch-basedir) pkg_patch_basedir=$2 ; shift ;;
    --patches-dir) patches_dir=$2 ; shift ;;
    *) echo "UNHANDLED: $0 $*" >&2 ; exit 1 ;;
  esac
  shift
done
#
: git_upstream_url "${git_upstream_url}"
test -n "${git_upstream_url}"
test -z "${submodule_tag}" && submodule_tag="`olh-obs_scm-remap-gitrepo-url ${git_upstream_url} 'tag'`"
#
: pkg_tag ${pkg_tag}
test -n "${pkg_tag}"
#
: work_dir "${work_dir}"
test -n "${work_dir}"
pushd "${work_dir}" > /dev/null
#
: out_dir "${out_dir}"
test -n "${out_dir}"
pushd "${out_dir}" > /dev/null
#
if test "${pkg_patch_basedir}" = "."
then
src_path="${pkg_tag//\//_}"
else
src_path="${submodule_tag//\//_}"
src_path="${src_path//./_}"
fi
#
if test "${pkg_patch_basedir}" != "."
then
  {
    echo ""
    echo "rm -rf '${pkg_patch_basedir}'"
    echo "tar xfa %{SOURCE@SOURCE_COUNTER@}"
    echo "mkdir -vp '${pkg_patch_basedir%/*}'"
    echo "mv -v '${src_path}-%{${src_path}_version}' '${pkg_patch_basedir}'"
  } >> spec.patch.txt
fi
git_hash="${git_upstream_commit}"
: git_dir "${git_dir}"
if test -n "${git_dir}" && test "${git_dir}" != "none"
then
  test -d "${git_dir}"
  git_dir="${git_dir}/.git"
  #
  : git_upstream_commit "${git_upstream_commit}"
  : git_upstream_remote "${git_upstream_remote}"
  : git_upstream_branch "${git_upstream_branch}"
  if test -n "${git_upstream_commit}"
  then
    git_hash="`g log --max-count=1 --pretty=format:%H \"${git_upstream_commit}\"`"
  elif test -n "${git_upstream_remote}" && test -n "${git_upstream_branch}"
  then
    git_hash="`g log --max-count=1 --pretty=format:%H \"${git_upstream_remote}/${git_upstream_branch}\"`"
  else
    exit 1
  fi
  #
  : git_hash "${git_hash}"
  test -n "${git_hash}"
  echo "${git_dir}" > gitdir.txt
  echo "${git_upstream_remote}" > git.upstream.remote.txt
  {
    g log --max-count=1 "--pretty=format:%%define ${submodule_tag}_revision_full %H%n"  "${git_hash}"
    g log --max-count=1 "--pretty=format:%%define ${submodule_tag}_revision_short %h%n" "${git_hash}"
    g log --max-count=1 "--pretty=format:%%define ${submodule_tag}_date_unix %ct%n"     "${git_hash}"
    g log --max-count=1 "--pretty=format:%%define ${submodule_tag}_date_commit %ci%n"   "${git_hash}"
    echo
  } > spec.Commit.txt
  #
  fixes_from="${git_fixes_remote}/${git_fixes_base}${git_fixes_tag+${git_fixes_tag}}-${git_upstream_branch}"
  fixes_to="${git_fixes_remote}/${git_fixes_branch}${git_fixes_tag+${git_fixes_tag}}-${git_upstream_branch}"
  echo "${git_upstream_url##*/} ${fixes_from}..${fixes_to}"
  if g log --max-count=1 '--pretty=format:%H%n' "${fixes_from}" > "${tf}" 2>/dev/null && test -s "${tf}"
  then
    read fixes_from < "${tf}"
  fi
  if g log --max-count=1 '--pretty=format:%H%n' "${fixes_to}" > "${tt}" 2>/dev/null && test -s "${tt}"
  then
    read fixes_to < "${tt}"
  fi
  if test -s "${tf}" && test -s "${tt}"
  then
    if test "${pkg_patch_basedir}" != "."
    then
      if test "${git_hash}" != "${fixes_from}"
      then
        echo "MISMATCH in ${submodule_tag}, ${git_fixes_base}${git_fixes_tag+${git_fixes_tag}}-${git_upstream_branch} should be ${git_hash}, but is ${fixes_from}"
      fi
    fi
    echo "pushd '${pkg_patch_basedir}'" >> spec.patch.txt
    g format-patch -k -o .patches "${fixes_from}".."${fixes_to}"
    for patch in .patches/*.patch
    do
      test -f "${patch}" || continue
      orig_patch_date="` sed -n '/^Date:/{s@^Date:@@;p;q}' \"${patch}\" `"
      utc_patch_date="`date -u -d \"${orig_patch_date}\" +%y%m%d%H%M%S`"
      utc_patch_date="`date -u -d \"${orig_patch_date}\" +%s`"
      orig_patch_name=${patch##*/}
      orig_patch_number=${orig_patch_name%%-*}
      spec_patch_name="${submodule_tag}.${orig_patch_name#*-}"
      mkdir "${patches_dir}/${utc_patch_date}"
      mkdir "${patches_dir}/${spec_patch_name}"
      echo "Patch${utc_patch_date}: ${spec_patch_name}" >> spec.Patch.txt
      echo "%patch${utc_patch_date} -p1" >> spec.patch.txt
      sed '
      1{/^From /d}
      /^index [0-9a-f]/d
      /^diff --git a/d
      ' "${patch}" > "${spec_patch_name}"
    done
    echo "popd" >> spec.patch.txt
  fi # tf tt
  if test -n "${direct_submodules}"
  then
    if g show "${git_hash}":.gitmodules > git.submodules.txt 2>/dev/null
    then
      :
    fi
    if test -s git.submodules.txt
    then
      process_submodules "${git_hash}" git.submodules.txt "${submodule_tag}"
    fi
  fi # direct_submodules
fi # git_dir
echo "${git_hash}" > git_hash.txt
echo "${submodule_tag}" > tag.txt
if test "${git_dir}" != "none"
then
  g log --max-count=1 '--pretty=format:%ct%n' "${git_hash}" > date_unix.txt
fi
#
if test "${pkg_patch_basedir}" = "."
then
  version_prefix=
  if test -f version_prefix.txt
  then
    read version_prefix < version_prefix.txt
    test -n "${version_prefix}" && version_prefix="${version_prefix}."
  fi
  service_version_format="<param name='versionformat'>${version_prefix}%ci.%h</param>"
else
  service_version_format="<param name='version'>${git_hash}</param>"
fi
cat >> service.txt <<_EOS_

  <service name="obs_scm">
    <param name="filename">${src_path}</param>
    <param name="revision">${git_hash}</param>
    <param name="scm">git</param>
    <param name="submodules">disable</param>
    <param name="url">${git_upstream_url}</param>
    ${service_version_format}
  </service>
  <service mode="buildtime" name="tar">
    <param name="obsinfo">${src_path}.obsinfo</param>
  </service>
_EOS_
#
if test "${pkg_patch_basedir}" = "."
then
  cat >> service.txt <<_EOS_
  <service mode="buildtime" name="set_version">
    <param name="basename">${src_path}</param>
  </service>
_EOS_
  echo "Source@SOURCE_COUNTER@: %{name}-%{version}.tar" >> spec.Patch.txt
else
  {
    echo "%define ${src_path}_version ${git_hash}"
    echo "Source@SOURCE_COUNTER@: ${src_path}-%{${src_path}_version}.tar"
  } >> spec.Patch.txt
fi
#
for i in git.submodule.*.txt
do
	test -f "${i}" || continue
	. "${i}"
	url="`olh-obs_scm-remap-gitrepo-url ${url} 'url' || :`"
	test -z "${url}" && continue
	submodule_pkg_dir="`olh-obs_scm-create_next_pkgdir \"${work_dir}\"`"
	submodule_pkg_git_dir="`olh-obs_scm-remap-gitrepo-url ${url} 'dir'`"
	submodule_pkg_tag="${pkg_tag}_${path//\//_}"
	submodule_pkg_tag="${submodule_pkg_tag//-/_}"
	"$0" \
	--git-dir "${submodule_pkg_git_dir}" \
	--git-upstream-url "${url}" \
	--git-upstream-remote "${git_upstream_remote}" \
	--git-upstream-branch "${git_upstream_branch}" \
	--git-upstream-commit "${rev}" \
	--git-fixes-remote "${git_fixes_remote}" \
	--git-fixes-base   "${git_fixes_base}" \
	--git-fixes-branch "${git_fixes_branch}" \
	--git-fixes-tag "${pkg_tag}" \
	--pkg-tag "${pkg_tag}" \
	--pkg-patch-basedir "${pkg_patch_basedir}/${path}" \
	--patches-dir "${patches_dir}" \
	--workdir "${work_dir}" \
	--outdir "${submodule_pkg_dir}"
#	--submodule-tag "${submodule_pkg_tag}"
done