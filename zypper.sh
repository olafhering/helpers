#!/bin/bash
exec nice -n 19 ionice -c 3 /usr/bin/zypper --verbose --verbose --verbose --verbose --no-refresh "$@"
