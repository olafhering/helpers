#!/bin/bash
for rq in "$@"
do
	obs rq show -d "${rq}" |& less -Sn
done
