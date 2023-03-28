#!/bin/bash
APIUSER=$1
APIHOST=$2
shift 2
export OSC_CONFIG=$HOME/.osc/oscrc.${APIUSER}.${APIHOST}
export XDG_STATE_HOME="/dev/shm/.osc_cookiejar.${APIUSER}.${APIHOST}"
rm -f ~/.osc_cookiejar ~/.local/state/osc/cookiejar
exec /usr/bin/osc --config=$OSC_CONFIG -A "https://${APIHOST}" "$@"
