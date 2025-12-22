prjs=(
KMP
Essentials
Multimedia
Games
Extra
Staging
SLE15
)

repositories=(
Factory
openSUSE_Tumbleweed
openSUSE_Slowroll
openSUSE_Leap_16.1
openSUSE_Leap_16.0
openSUSE_Leap_15.6
SLE_15
)

declare -i i=0 j known
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
		known=0
		while test $j -lt ${#repositories[@]}
		do
			if test "${a[0]}" = "${repositories[$j]}"
			then
				repository=$(( (${#repositories[@]} - $j) + 1 ))
				known=1
				break
			fi
			: $(( j++ ))
		done
		if test "${known}" -eq 0
		then
			continue
		fi
		project=$(( ( ${#prjs[@]} - $i ) * 2 ))
		adjust=$(( (${project} * ${repository} * ${arch}) + 1))
		echo "<prio adjust='${adjust}' project='${prj}' repository='${a[0]}' arch='${a[1]}' />"
	done < <(pbs repositories "${prj}")
	: $(( i++ ))
done | sort -n -t "'" -k 2 -r
echo '<!-- pbs api -e /build/_dispatchprios -->'
echo '</dispatchprios>'
