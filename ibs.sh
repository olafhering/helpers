#!/bin/bash
APIHOST='api.suse.de'
APIUSER='olh'
exec olh-osc-wrapper "${APIUSER}" "${APIHOST}" "$@"
