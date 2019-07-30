set -e
remote=kerncvs
user=ohering

pushd ~/work/src/kernel
pushd kerncvs.kernel-source.bare.mirror
while read b; do
    : branch $b
    pb="${b%/*}"
    pb="${pb#users/$user/}"
    case "$pb" in
      SLE12-SP3) pb=SLE12-SP3-LTSS ;;
      SLE12-SP2) pb=SLE12-SP2-LTSS ;;
      SLE12-SP1) pb=SLE12-SP1-LTSS ;;
      SLE11-SP4) pb=SLE11-SP4-LTSS ;;
    esac
    git --no-pager rev-list --max-count=1 "${pb}" &> /dev/null || continue

    if git merge-base --is-ancestor "$b" "${pb}" </dev/null; 
    then
        echo -e "\ngit push -d ${remote} ${b}"
    else
        echo -e "\n${pb}:"
        git --no-pager log --oneline "${pb}..${b}" </dev/null
    fi
done < <( git branch -a --list "users/${user}/*/*" )

