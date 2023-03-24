#!/bin/sh
APIHOST='pmbs-api.links2linux.org'
APIUSER='olh'
export OSC_CONFIG=$HOME/.osc/oscrc
export XDG_STATE_HOME="/dev/shm/.osc_cookiejar.${APIUSER}.${APIHOST}"
rm -f ~/.osc_cookiejar ~/.local/state/osc/cookiejar
exec /usr/bin/osc --config=$OSC_CONFIG -A "https://${APIHOST}" "$@"
