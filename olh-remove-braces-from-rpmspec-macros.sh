#!/bin/bash
exec \
sed -i~ '
	s@%{_bindir}@%_bindir@g
	s@%{_datadir}@%_datadir@g
	s@%{_defaultdocdir}@%_defaultdocdir@g
	s@%{_docdir}@%_docdir@g
	s@%{_fillupdir}@%_fillupdir@g
	s@%{_includedir}@%_includedir@g
	s@%{_infodir}@%_infodir@g
	s@%{_libdir}@%_libdir@g
	s@%{_libexecdir}@%_libexecdir@g
	s@%{_localstatedir}@%_localstatedir@g
	s@%{_mandir}@%_mandir@g
	s@%{_prefix}@%_prefix@g
	s@%{_project}@%_project@g
	s@%{_rpmconfigdir}@%_rpmconfigdir@g
	s@%{_rpmmacrodir}@%_rpmmacrodir@g
	s@%{_rundir}@%_rundir@g
	s@%{_sbindir}@%_sbindir@g
	s@%{_sharedstatedir}@%_sharedstatedir@g
	s@%{_sysconfdir}@%_sysconfdir@g
	s@%{_sysctldir}@%_sysctldir@g
	s@%{_tmppath}@%_tmppath@g
	s@%{_unitdir}@%_unitdir@g
	s@%{build_flavor}@%build_flavor@g
	s@%{buildroot}@%buildroot@g
	s@%{name}@%name@g
	s@%{nil}@%nil@g
	s@%{nsuffix}@%nsuffix@g
	s@%{ocaml_standard_library}@%ocaml_standard_library@g
	s@%{optflags}@%optflags@g
	s@%{pkg}@%pkg@g
	s@%{release}@%release@g
	s@%{tag}@%tag@g
	s@%{version}@%version@g
' "$@"