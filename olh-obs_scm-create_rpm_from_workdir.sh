#!/bin/bash
#et -x
set -e
unset LANG
unset ${!LC*}

_sed() { /z_crypt_lvm_btrfs/sle12/usr/bin/sed "$@" ; }
work_dir=
pkg_tag=
#
rpm_spec=
declare -i counter=0
t=`mktemp`
O=`mktemp`
N=`mktemp`
trap "rm -f \"${O}\" \"${N}\" ; : $0" EXIT
#
while test $# -gt 0
do
  : $1
  case "$1" in
    --workdir) work_dir=$2 ; shift ;;
    --pkg-tag) pkg_tag=$2 ; shift ;;
    *) echo "UNHANDLED: $0 $*" >&2 ; exit 1 ;;
  esac
  shift
done
#
: pkg_tag "${pkg_tag}"
test -n "${pkg_tag}"
rpm_spec="${pkg_tag}.spec"
test -f "${rpm_spec}"
#
: work_dir "${work_dir}"
test -n "${work_dir}"
pushd "${work_dir}" > /dev/null
#
{
  echo "<services>"
  cat */service.txt
  echo ""
  echo "</services>"
} > _service
#
{
  cat */spec.Commit.txt
} > spec.Commit.txt
#
counter=0
{
  for i in */service.txt
  do
    f=${i%/*}/spec.Patch.txt
    if test -e "${f}"
    then
      _sed "s/@SOURCE_COUNTER@/${counter}/" "${f}"
    fi
  counter=$(( $counter + 1 ))
  done
} > spec.Patch.txt
#
counter=0
{
  echo "%setup -q"
  for i in */service.txt
  do
    f=${i%/*}/spec.patch.txt
    if test -e "${f}"
    then
      _sed "s/@SOURCE_COUNTER@/${counter}/" "${f}"
    fi
  counter=$(( $counter + 1 ))
  done
  echo ""
} > spec.patch.txt
#

#ead -n 1234 _service *.txt

popd > /dev/null
_sed "
 /^Patch:/d
 /^Patch[0-9]:/d
 /^Patch[0-9][0-9]:/d
 /^Patch[0-9][0-9][0-9]:/d
 /^Source:/d
 /^Source[0-9]:/d
 /^Source[0-9][0-9]:/d
 /^Source[0-9][0-9][0-9]:/d
 /^Source[0-9][0-9][0-9]:/d
 /^Version:/d
 /^Release:/d
 /^Name:.*/s@^.*@Name:           ${pkg_tag}\\
Version:        0\\
Release:        0@
 /^Version:.*/s@^.*@Version:        0@
" "${rpm_spec}" |
_sed -n "
/^Url:/{
 p
 r ${work_dir}/spec.Commit.txt
 r ${work_dir}/spec.Patch.txt
 :url
 /^BuildRoot:/b url_replace
 n
 b url
 :url_replace
}

/^%prep.*/ {
 p
 r ${work_dir}/spec.patch.txt
 :prep
 /^%build.*/b prep_replace
 n
 b prep
 :prep_replace
}
p
" > "${work_dir}/rpm.spec" 
test -s "${work_dir}/rpm.spec"
if diff -u "${rpm_spec}" "${work_dir}/rpm.spec"
then
 : no differences
else
  cp -avib "${work_dir}/rpm.spec" "${rpm_spec}"
fi
if diff -u "_service" "${work_dir}/_service"
then
 : no differences
else
 cp -avib "${work_dir}/_service" "_service"
fi

for patch in "${work_dir}"/*/*.patch
do
  test -f "${patch}" || continue
  update_patch=true
  old_patch=".osc/${patch##*/}"
  wc_patch="${patch##*/}"
  new_patch="${patch}"
  if test -e "${old_patch}"
  then
    sed '/^@@[[:blank:]]-[0-9]/d' "${old_patch}" > "${O}"
    sed '/^@@[[:blank:]]-[0-9]/d' "${new_patch}" > "${N}"
    diff -u "${O}" "${N}" && update_patch=
  fi
  if ! test -f "${wc_patch}"
  then
    update_patch=true
  fi
  if test -n "${update_patch}"
  then
   mv -vibt . "${new_patch}"
  fi
done
{
  for tag in "${work_dir}"/*/tag.txt
  do
      test -f "${tag}" || continue
      timestamp=
      tag_dir="${tag%/*}"
      read git_hash < "${tag_dir}"/git_hash.txt
      if test -f "${tag_dir}"/date_unix.txt
      then
        read date_unix < "${tag_dir}"/date_unix.txt
        timestamp="`date -ud @${date_unix}`"
      fi
      read pkg_tag < "${tag}"
      echo "${pkg_tag} ${git_hash} ${timestamp}"
  done
} > "${t}"
if test -f ../.osc/_apiurl && test -f ../.osc/_packages && test -f ../.osc/_project
then
  rm -f ../.osc/_commit_msg
  cat "${t}" | tee ../.osc/_commit_msg
fi
