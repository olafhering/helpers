#!/bin/bash
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
APIHOST='localhost'
APIUSER='generic'
exec olh-osc-wrapper "${APIUSER}" "${APIHOST}" "$@"
