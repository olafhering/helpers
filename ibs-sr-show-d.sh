#!/bin/bash
for rq in "$@"
do
	ibs rq show -d "${rq}" |& less -Sn
done
