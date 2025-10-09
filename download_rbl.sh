#!/bin/bash
apiurl=
project=
package=
repo=
arch=
force=$1
last=
: $PWD
if test -f .osc/_apiurl && test -f .osc/_project && test -f .osc/_package
then
	read apiurl  < .osc/_apiurl
	read project < .osc/_project
	read package < .osc/_package
	test -n "${apiurl}" || exit 1
	test -n "${project}" || exit 1
	test -n "${package}" || exit 1
elif test -f ../.osc/_apiurl && test -f ../.osc/_project && test -d .git
then
	read apiurl  < ../.osc/_apiurl
	read project < ../.osc/_project
	package=${PWD##*/}
else
	exit 1
fi
osc -A "${apiurl}" results --no-multibuild ${project} ${package} | while read repo arch state rest
do
	if test -n "${rest}"
	then
		package="${state}"
		state="${rest}"
	fi
	rbl=.log.${project}.${package}.${repo}.${arch}.txt
	if test -n "$force"
	then
		state=succeeded
		last=-l
	fi
	case "${state}" in
		building|building\*|signing|signing*|finished|finished\*|succeeded|succeeded\*|failed|failed\*)
		(
		rm -f ${rbl}
		osc -A "${apiurl}" rbl ${last} ${project} ${package} ${repo} ${arch} > ${rbl}
		sleep 5
		if ! test -s ${rbl}
		then
			rm -fv ${rbl}
		fi
		) &
		sleep 2
		;;
		disabled|disabled\*|excluded|excluded\*)
		;;
		unresolvable|unresolvable\*|broken|blocked|blocked\*|scheduled|scheduled*|dispatching|locked)
		;;
		*)
		echo "state '${state}' unhandled for ${rbl}"
		;;
	esac
done
exit 0
s scheduled           
S signing             
disabled            
B broken              
f finished            
b blocked             
% building            
L locked              
. succeeded           
U unresolvable        
d dispatching         
F failed              
x excluded            
