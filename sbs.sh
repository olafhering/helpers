#!/bin/sh
export OSC_CONFIG=$HOME/.osc/oscrc
exec /usr/bin/osc --config=$OSC_CONFIG -A https://api.suse.com "$@"
