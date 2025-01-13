#!/bin/bash
APIHOST='api.suse.com'
APIUSER='olh'
exec olh-osc-wrapper "${APIUSER}" "${APIHOST}" "$@"
