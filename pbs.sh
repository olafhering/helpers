#!/bin/bash
APIHOST='pmbs-api.links2linux.org'
APIUSER='olh'
exec olh-osc-wrapper "${APIUSER}" "${APIHOST}" "$@"
