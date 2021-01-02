#!/bin/bash
args=()
verbose='--verbose --verbose --verbose --verbose'
for arg in "$@"
do
	case "${arg}" in
		--quiet|-q) verbose= ; break ;;
		--) break ;;
	esac
done
$(type -P env) \
	INITRD_IN_POSTTRANS=1 \
	$(type -P nice ) -n 19 \
	$(type -P ionice) -c 3 \
	/usr/bin/zypper ${verbose} --no-refresh "$@"

if test -L /boot/initrd
then
	if test -f /boot/initrd
	then
		: good
	else
		$(type -P mkinitrd) -B
	fi
fi
