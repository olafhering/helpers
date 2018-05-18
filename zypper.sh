#!/bin/bash
exec $(type -P env) \
	INITRD_IN_POSTTRANS=1 \
	$(type -P nice ) -n 19 \
	$(type -P ionice) -c 3 \
	$(type -P zypper) --verbose --verbose --verbose --verbose --no-refresh "$@"
