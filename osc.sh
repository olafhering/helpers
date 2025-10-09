#!/bin/bash
apiurl=
test -z "${apiurl}" -a test -f '.osc/_apiurl' && read apiurl < "$_"
test -z "${apiurl}" -a test -f '../.osc/_apiurl' && read apiurl < "$_"
case "${apiurl}" in
*//api.opensuse.org) exec obs "$@" ;;
*//api.suse.com) exec sbs "$@" ;;
*//api.suse.de) exec ibs "$@" ;;
*//pmbs-api.links2linux.org) exec pbs "$@" ;;
esac
APIHOST='localhost'
APIUSER='generic'
exec olh-osc-wrapper "${APIUSER}" "${APIHOST}" "$@"
