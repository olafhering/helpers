#!/bin/bash
apiurl=
project=
package=
repo=
arch=
force=$1
last=
: $PWD
cd .osc
read apiurl < _apiurl
read project < _project
read package < _package
cd ..
osc -A "${apiurl}" results ${project} ${package} | while read repo arch state rest
do
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

