Name:           helpers
Version:        0
Release:        0
License:        GPL-2.0
Summary:        helpers
Url:            https://github.com/olafhering/helpers
Group:          System/Base
Source:         %name-%version.tar.xz
BuildRoot:      %_tmppath/%name-%version-build
BuildArch:      noarch

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

%files
%defattr(-,root,root)
%doc LICENSE
%_datadir/%name

