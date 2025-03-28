#!/bin/bash
for rq in "$@"
do
	num=${rq#rq}
	num=${num%.}
	pbs rq show -d "${num}"
done |& less -Sn
