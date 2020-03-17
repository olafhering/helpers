prjs=(
Essentials
Multimedia
Games
Extra
Staging
SLE12
)

repositories=(
Factory
openSUSE_Leap_15.1
openSUSE_Leap_15.2
openSUSE_Tumbleweed
openSUSE_Factory_ARM
SLE_15
SLE_12
)

declare -i i=0 j
declare -i adjust project repository arch

echo '<dispatchprios>'

while test $i -lt ${#prjs[@]}
do
	prj=${prjs[$i]}
	while read
	do
		unset a
		a=( ${REPLY} )
		case "${a[1]}" in
			i586) arch='0' ;;
			aarch64) arch='4' ;;
			armv6l) arch='0' ;;
			armv7l) arch='1' ;;
			*) arch='1' ;;
		esac
		j=0
		repository=1
		while test $j -lt ${#repositories[@]}
		do
			if test "${a[0]}" = "${repositories[$j]}"
			then
				repository=$(( (${#repositories[@]} - $j) + 1 ))
				break
			fi
			: $(( j++ ))
		done
		project=$(( ( ${#prjs[@]} - $i ) * 2 ))
		adjust=$(( (${project} * ${repository} * ${arch}) + 1))
		echo "<prio adjust='${adjust}' project='${prj}' repository='${a[0]}' arch='${a[1]}' />"
	done < <(pbs repositories "${prj}")
	: $(( i++ ))
done | sort -n -t "'" -k 2 -r
echo '<!-- pbs api -e /build/_dispatchprios -->'
echo '</dispatchprios>'