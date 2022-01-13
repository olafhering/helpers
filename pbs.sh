#!/bin/sh
export OSC_CONFIG=$HOME/.osc/oscrc
exec /usr/bin/osc --config=$OSC_CONFIG -A https://pmbs-api.links2linux.org "$@"
