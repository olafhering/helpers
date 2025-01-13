#!/bin/bash
APIHOST='api.opensuse.org'
APIUSER='olh'
exec olh-osc-wrapper "${APIUSER}" "${APIHOST}" "$@"
