#!/bin/bash
for rq in "$@"
do
	pbs rq show -d "${rq}" |& less -Sn
done
