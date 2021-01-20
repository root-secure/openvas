Name:           openvas-scanner
Version:        6.0.2
Release:        awn1%{?dist}
Group:          Unspecified
Summary:        The Open Vulnerability Assessment (OpenVAS) suite

License:        GPLv2+
URL:            http://www.openvas.org
Source:         https://github.com/root-secure/openvas/tree/awn-openvas-scanner-6.0
Vendor:         Greenbone https://www.greenbone.net

ExclusiveArch:  x86_64

BuildRoot:      /tmp/rpmbuild

%description
This is the Open Vulnerability Assessment System (OpenVAS) Scanner of the
Greenbone Vulnerability Management (GVM) Solution.
.
It is used for the Greenbone Security Manager appliances and is a full-featured
scan engine that executes a continuously updated and extended feed of Network
Vulnerability Tests (NVTs).

%install
mkdir -p %{buildroot}/etc/logrotate.d/
mkdir -p %{buildroot}/usr/lib/systemd/system/
cp /etc/logrotate.d/openvas-scanner %{buildroot}/etc/logrotate.d/
cp /etc/systemd/system/multi-user.target.wants/openvas-scanner.service %{buildroot}/usr/lib/systemd/system/

%files
/etc/logrotate.d/openvas-scanner
/usr/lib/systemd/system/openvas-scanner.service

%changelog
* Wed Sep 23 2020 smahood Arctic Wolf Networks
* Wed Aug 5 2020 aschryver Arctic Wolf Networks
-
