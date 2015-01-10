# $Id: smeserver-bugreport.spec,v 0.1 2015/01/05 23:33:15 stephdl Exp $
# Authority: mats
# Name: Mats Schuh

%define name smeserver-bugreport
%define version 0.1
%define release 2
Summary: SME Server-Manager Panel to create a downloadable system configuration report.
Name: %{name}
Version: %{version}
Release: %{release}%{?dist}
License: GNU GPL version 2
URL: http://www.neckargeo.net
Group: SMEserver/addon
Source: %{name}-%{version}.tar.gz
BuildArchitectures: noarch
BuildRoot: /var/tmp/%{name}-%{version}
Requires: e-smith-release >= 7.0,
Requires: e-smith-formmagick >= 1.4.0-12
BuildRequires: e-smith-devtools >= 1.13.1-03
AutoReqProv: no

%description
SME Server-Manager Panel to create a downloadable system configuration report.
Instructions are provided encouraging users to attach this report to any bug they raise.

%changelog
* Sat Jan 10 2015 mats schuh <m.schuh@neckargeo.net> 0.1-2.test
- Corrected spec file and create links
- Courtesy Stephane de Labrusse

* Fri Jan 9 2015 mats schuh <m.schuh@neckargeo.net> 0.1-1.test
- Initial release

%prep
%setup

%build
perl createlinks

#LEXICONS=$(find root/etc/e-smith/{locale/,web/functions/} -type f )
#for lexicon in $LEXICONS
#do
#    /sbin/e-smith/validate-lexicon $lexicon
#done

%install
rm -rf $RPM_BUILD_ROOT
(cd root   ; find . -depth -print | cpio -dump $RPM_BUILD_ROOT)
rm -f %{name}-%{version}-filelist
/sbin/e-smith/genfilelist $RPM_BUILD_ROOT > %{name}-%{version}-filelist
echo "%doc COPYING"  >> %{name}-%{version}-filelist

%clean
rm -rf $RPM_BUILD_ROOT

%pre
%preun

%post
#if [ -d /etc/e-smith/events/conf-userpanel ] ; then
#   /sbin/e-smith/signal-event conf-userpanel
#fi

%postun
#uninstall
#if [ $1 = 0 ] ; then
#
# DBS=`find /home/e-smith/db/navigation -type f -name "navigation.*"`
# for db in $DBS ; do
#          /sbin/e-smith/db $db delete bugreport 2>/dev/null
#	done
#fi


%files -f %{name}-%{version}-filelist
%defattr(-,root,root)
