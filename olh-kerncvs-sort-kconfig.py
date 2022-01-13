#!/usr/bin/python3
# vim: ts=2 shiftwidth=2 noexpandtab nowrap
import locale
import re
import sys
kconfig = {}
locale.setlocale(locale.LC_ALL, "POSIX")
argv = sys.argv
argv.pop(0)
for filename in argv:
	print("{}".format(filename))
	with open(filename) as file:
		for line in file:
			r = re.search(r"^(# |)(CONFIG_[^ =]+)(.*)", line, re.IGNORECASE)
			if not r:
				continue
			config = r.group(2)
			kconfig[config] = line
	with open(filename, "w") as file:
		for config in sorted(kconfig.keys(), key=lambda item: locale.strxfrm(item)):
			file.write("{}".format(kconfig[config]))
