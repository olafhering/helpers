#!/bin/sh
apiurl=
if test -f .osc/_apiurl
then
	read apiurl < .osc/_apiurl
	case "${apiurl}" in
	*//api.opensuse.org) exec obs "$@" ;;
	*//api.suse.com) exec sbs "$@" ;;
	*//api.suse.de) exec ibs "$@" ;;
	*//pmbs-api.links2linux.org) exec pbs "$@" ;;
	esac
fi
export OSC_CONFIG=$HOME/.osc/oscrc
exec /usr/bin/osc --config=$OSC_CONFIG "$@"
