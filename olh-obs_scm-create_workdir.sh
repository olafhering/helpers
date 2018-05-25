#!/bin/bash
set -e
unset LANG
unset ${!LC*}
exec mktemp --directory --tmpdir=/dev/shm olh-obs_scm.XXX
