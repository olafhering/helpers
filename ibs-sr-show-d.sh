#!/bin/bash
for rq in "$@"
do
	num=${rq#rq}
	num=${num%.}
	ibs rq show -d "${num}"
done |& less -Sn
