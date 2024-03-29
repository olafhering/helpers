Name:           helpers
Version:        0
Release:        0
License:        GPL-2.0
Summary:        helpers
Url:            https://github.com/olafhering/helpers
Group:          System/Base
Source:         %name-%version.tar
BuildRoot:      %_tmppath/%name-%version-build
BuildArch:      noarch
%if %suse_version > 1110
BuildRequires:  python(abi) > 3.0
%endif

%description
helpers

%prep
%setup -q

%build

%install
DESTDIR=%buildroot%_datadir/%name/bin
mkdir -vp "${DESTDIR}"
for bin in *.sh
do
  cp -aviL ${bin} "${DESTDIR}/${bin%.sh}"
done
for txt in *.txt
do
  mv -v "${txt}" "${DESTDIR}/${txt}"
  chmod -c 444 "$_"
done
python="$(type -P false)"
for py in python3 python2 python
do
	if test -x "$(type -P ${py})"
	then
		python="$_"
		break
	fi
done
python="$(readlink -f ${python})"
for py in *.py
do
	file="${DESTDIR}/${py%.py}"
	echo "#!${python}" > "${file}"
	cat "${py}" >> "${file}"
	chmod -v 555 "${file}"
done

%files
%defattr(-,root,root)
%doc LICENSE
%config %_datadir/%name

