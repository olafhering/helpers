#!/bin/bash
set -e
remote=kerncvs
user=ohering

pushd ~/work/src/kernel > /dev/null
pushd kerncvs.kernel-source.bare.mirror > /dev/null
while read b; do
    : branch $b
    pb="${b%/*}"
    pb="${pb#users/$user/}"
    case "$pb" in
      SLE15-SP6) pb=SLE15-SP6-LTSS ;;
      SLE15-SP5) pb=SLE15-SP5-LTSS ;;
      SLE15-SP4) pb=SLE15-SP4-LTSS ;;
      SLE15-SP3) pb=SLE15-SP3-LTSS ;;
      SLE15-SP2) pb=SLE15-SP2-LTSS ;;
      SLE15-SP1) pb=SLE15-SP1-LTSS ;;
      SLE12-SP4) pb=SLE12-SP4-LTSS ;;
      SLE12-SP3) pb=SLE12-SP3-LTSS ;;
      SLE12-SP2) pb=SLE12-SP2-LTSS ;;
      SLE12-SP1) pb=SLE12-SP1-LTSS ;;
      SLE11-SP4) pb=SLE11-SP4-LTSS ;;
    esac
    base_branch=
    if git --no-pager rev-list --max-count=1 "${pb}" &> /dev/null
    then
      base_branch="${pb}"
    fi
    if test -z "${base_branch}"
    then
      if git --no-pager rev-list --max-count=1 "${pb%_EMBARGO}" &> /dev/null
      then
        base_branch="${_}"
      fi
    fi
    if test -z "${base_branch}"
    then
      if git --no-pager rev-list --max-count=1 "${pb%-AZURE_EMBARGO}" &> /dev/null
      then
        base_branch="${_}"
      fi
    fi
    if test -z "${base_branch}"
    then
      if git --no-pager rev-list --max-count=1 "${pb%-AZURE_EMBARGO}-LTSS" &> /dev/null
      then
        base_branch="${_}"
      fi
    fi
    test -n "${base_branch}" || continue

    if git merge-base --is-ancestor "$b" "${base_branch}" </dev/null; 
    then
        echo -e "\n git push -d ${remote} ${b}"
    else
        echo -e "\n${base_branch}:"
        git --no-pager log --oneline "${base_branch}..${b}" </dev/null
    fi
done < <( git branch -a --list "users/${user}/*/*" )

