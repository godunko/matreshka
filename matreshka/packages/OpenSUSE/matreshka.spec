##--------------------------------------------------------------------------##
##                                                                          ##
##                            Matreshka Project                             ##
##                                                                          ##
##                  Specification File for OpenSUSE Package                 ##
##                                                                          ##
##--------------------------------------------------------------------------##
##                                                                          ##
## Copyright © 2011, Vadim Godunko <vgodunko@gmail.com>                     ##
## All rights reserved.                                                     ##
##                                                                          ##
## Redistribution and use in source and binary forms, with or without       ##
## modification, are permitted provided that the following conditions       ##
## are met:                                                                 ##
##                                                                          ##
##  * Redistributions of source code must retain the above copyright        ##
##    notice, this list of conditions and the following disclaimer.         ##
##                                                                          ##
##  * Redistributions in binary form must reproduce the above copyright     ##
##    notice, this list of conditions and the following disclaimer in the   ##
##    documentation and/or other materials provided with the distribution.  ##
##                                                                          ##
##  * Neither the name of the Vadim Godunko, IE nor the names of its        ##
##    contributors may be used to endorse or promote products derived from  ##
##    this software without specific prior written permission.              ##
##                                                                          ##
## THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS      ##
## "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT        ##
## LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR    ##
## A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT     ##
## HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,   ##
## SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED ##
## TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR   ##
## PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF   ##
## LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING     ##
## NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS       ##
## SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.             ##
##                                                                          ##
##--------------------------------------------------------------------------##
##  $Revision$ $Date$
##--------------------------------------------------------------------------##

Name:           matreshka
Version:        0.2.0
Release:        1
License:        BSD
Summary:        Matreshka components for Ada programmers
Url:            http://adaforge.qtada.com/cgi-bin/tracker.fcgi/matreshka
Group:          System/Libraries
Source:         matreshka-0.2.0.tar.gz
##  Patch:
BuildRequires:  gcc-ada postgresql-devel sqlite3-devel
##  PreReq:
##  Provides:
%description
Matreshka is a set of Ada components to develop information systems.

%global RTL_VERSION_SUFFIX %(gcc -v 2>&1 | sed -n -e 's/gcc \\w* \\([0-9]*\\.[0-9]*\\).*/-\\1/p')
%global PACKAGE_SUFFIX %(echo "%{RTL_VERSION_SUFFIX}-%{version}" | tr '.' '_')

%prep
%setup -q -n %{name}-%{version}

%build
make config
%configure
make SMP_MFLAGS=%{?_smp_mflags}

%check
make check

%install
%make_install
export NO_BRP_CHECK_RPATH=true

##  %%clean
##  %%{?buildroot:%%__rm -rf "%%{buildroot}"}

%package -n libleague%{PACKAGE_SUFFIX}
Summary: Matreshka components for Ada programmers
%description -n libleague%{PACKAGE_SUFFIX}
Matreshka is a set of Ada components to develop information systems.

%package -n libleague%{PACKAGE_SUFFIX}-devel
Group: Development/Libraries/Other
Summary: Matreshka components for Ada programmers
Requires: libleague%{PACKAGE_SUFFIX}
%description -n libleague%{PACKAGE_SUFFIX}-devel
Matreshka is a set of Ada components to develop information systems.

%package -n libmatreshka-fastcgi%{PACKAGE_SUFFIX}
Summary: FastCGI library of Matreshka components for Ada programmers
%description -n libmatreshka-fastcgi%{PACKAGE_SUFFIX}
FastCGI library of Matreshka components allows to Ada applications to
communicate to web servers through FastCGI protocol.

%package -n libmatreshka-fastcgi%{PACKAGE_SUFFIX}-devel
Group: Development/Libraries/Other
Summary: FastCGI library of Matreshka components for Ada programmers
Requires: libmatreshka-fastcgi%{PACKAGE_SUFFIX}
%description -n libmatreshka-fastcgi%{PACKAGE_SUFFIX}-devel
FastCGI library of Matreshka components allows to Ada applications to
communicate to web servers through FastCGI protocol.

%package -n libmatreshka-sql%{PACKAGE_SUFFIX}
Summary: SQL database access library of Matreshka components for Ada programmers
%description -n libmatreshka-sql%{PACKAGE_SUFFIX}
SQL database access library of Matreshka components allows to use simple API to
access to different SQL databases.

%package -n libmatreshka-sql%{PACKAGE_SUFFIX}-devel
Group: Development/Libraries/Other
Summary: SQL database access library of Matreshka components for Ada programmers
Requires: libmatreshka-sql%{PACKAGE_SUFFIX}
%description -n libmatreshka-sql%{PACKAGE_SUFFIX}-devel
SQL database access library of Matreshka components allows to use simple API to
access to different SQL databases.

%package -n libmatreshka-sql-postgresql%{PACKAGE_SUFFIX}
Summary: PostgreSQL driver for SQL database access library of Matreshka components
%description -n libmatreshka-sql-postgresql%{PACKAGE_SUFFIX}
PostgreSQL driver for SQL database access library of Matreshka components.

%package -n libmatreshka-sql-postgresql%{PACKAGE_SUFFIX}-devel
Group: Development/Libraries/Other
Summary: PostgreSQL driver for SQL database access library of Matreshka components
Requires: libmatreshka-sql-postgresql%{PACKAGE_SUFFIX}
%description -n libmatreshka-sql-postgresql%{PACKAGE_SUFFIX}-devel
PostgreSQL driver for SQL database access library of Matreshka components.

%package -n libmatreshka-sql-sqlite3%{PACKAGE_SUFFIX}
Summary: SQLite3 driver for SQL database access library of Matreshka components
%description -n libmatreshka-sql-sqlite3%{PACKAGE_SUFFIX}
SQLite3 driver for SQL database access library of Matreshka components.

%package -n libmatreshka-sql-sqlite3%{PACKAGE_SUFFIX}-devel
Group: Development/Libraries/Other
Summary: SQLite3 driver for SQL database access library of Matreshka components
Requires: libmatreshka-sql-sqlite3%{PACKAGE_SUFFIX}
%description -n libmatreshka-sql-sqlite3%{PACKAGE_SUFFIX}-devel
SQLite3 driver for SQL database access library of Matreshka components.

%post -n libleague%{PACKAGE_SUFFIX}
/sbin/ldconfig
%postun -n libleague%{PACKAGE_SUFFIX}
/sbin/ldconfig

%post -n libmatreshka-fastcgi%{PACKAGE_SUFFIX}
/sbin/ldconfig
%postun -n libmatreshka-fastcgi%{PACKAGE_SUFFIX}
/sbin/ldconfig

%post -n libmatreshka-sql%{PACKAGE_SUFFIX}
/sbin/ldconfig
%postun -n libmatreshka-sql%{PACKAGE_SUFFIX}
/sbin/ldconfig

%post -n libmatreshka-sql-postgresql%{PACKAGE_SUFFIX}
/sbin/ldconfig
%postun -n libmatreshka-sql-postgresql%{PACKAGE_SUFFIX}
/sbin/ldconfig

%post -n libmatreshka-sql-sqlite3%{PACKAGE_SUFFIX}
/sbin/ldconfig
%postun -n libmatreshka-sql-sqlite3%{PACKAGE_SUFFIX}
/sbin/ldconfig

%files -n libleague%{PACKAGE_SUFFIX} -f .objs/league-lib.files
%defattr(-,root,root)
##  %%doc ChangeLog README COPYING
%files -n libleague%{PACKAGE_SUFFIX}-devel -f .objs/league-devel.files
%defattr(-,root,root)
%dir %{_includedir}/matreshka
%dir %{_includedir}/matreshka/league
%dir %{_prefix}/lib/gnat
%dir %{_prefix}/lib/gnat/matreshka
%dir %{_libdir}/matreshka

%files -n libmatreshka-fastcgi%{PACKAGE_SUFFIX} -f .objs/fastcgi-lib.files
%defattr(-,root,root)
%files -n libmatreshka-fastcgi%{PACKAGE_SUFFIX}-devel -f .objs/fastcgi-devel.files
%defattr(-,root,root)
%dir %{_includedir}/matreshka/fastcgi

%files -n libmatreshka-sql%{PACKAGE_SUFFIX} -f .objs/sql-lib.files
%defattr(-,root,root)
%files -n libmatreshka-sql%{PACKAGE_SUFFIX}-devel -f .objs/sql-devel.files
%defattr(-,root,root)
%dir %{_includedir}/matreshka/sql

%files -n libmatreshka-sql-postgresql%{PACKAGE_SUFFIX} -f .objs/sql_postgresql-lib.files
%defattr(-,root,root)
%files -n libmatreshka-sql-postgresql%{PACKAGE_SUFFIX}-devel -f .objs/sql_postgresql-devel.files
%defattr(-,root,root)
%dir %{_includedir}/matreshka/sql/postgresql

%files -n libmatreshka-sql-sqlite3%{PACKAGE_SUFFIX} -f .objs/sql_sqlite3-lib.files
%defattr(-,root,root)
%files -n libmatreshka-sql-sqlite3%{PACKAGE_SUFFIX}-devel -f .objs/sql_sqlite3-devel.files
%defattr(-,root,root)
%dir %{_includedir}/matreshka/sql/sqlite3

%changelog
