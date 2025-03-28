#!/bin/bash
for rq in "$@"
do
	num=${rq#rq}
	num=${num%.}
	obs rq show -d "${num}"
done |& less -Sn
