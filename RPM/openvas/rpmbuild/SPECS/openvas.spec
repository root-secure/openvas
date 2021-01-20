Name:           openvas
Version:        6.0.2
Release:        awn1%{?dist}
Group:          System Environment/Libraries
Summary:        The Open Vulnerability Assessment (OpenVAS) suite

License:        GPLv2+
URL:            http://www.openvas.org
Source:         https://github.com/greenbone/openvas/archive/v6.0.2.tar.gz
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
mkdir -p %{buildroot}/bin
mkdir -p %{buildroot}/sbin
mkdir -p %{buildroot}/lib64
mkdir -p %{buildroot}/var/log/gvm
mkdir -p %{buildroot}/etc/openvas/gnupg
mkdir -p %{buildroot}/var/lib/openvas/gnupg
mkdir -p %{buildroot}/var/lib/openvas/plugins
mkdir -p %{buildroot}/share/openvas
mkdir -p %{buildroot}/share/man/man1
mkdir -p %{buildroot}/share/man/man8
mkdir -p %{buildroot}/share/doc/openvas-scanner/redis_config_examples
ln -s /lib64/libopenvas_misc.so.10.0.2 %{buildroot}/lib64/libopenvas_misc.so
ln -s /lib64/libopenvas_misc.so.10.0.2 %{buildroot}/lib64/libopenvas_misc.so.10
cp /lib64/libopenvas_misc.so.10.0.2 %{buildroot}/lib64/
cp -r /etc/openvas/* %{buildroot}/etc/openvas/
cp -r /var/lib/openvas/* %{buildroot}/var/lib/openvas/
ln -s /lib64/libopenvas_nasl.so.10.0.2 %{buildroot}/lib64/libopenvas_nasl.so
ln -s /lib64/libopenvas_nasl.so.10.0.2 %{buildroot}/lib64/libopenvas_nasl.so.10
cp /lib64/libopenvas_nasl.so.10.0.2 %{buildroot}/lib64/
cp /bin/openvas-nasl* %{buildroot}/bin/
cp /share/man/man1/openvas-nasl* %{buildroot}/share/man/man1/
cp /sbin/openvassd %{buildroot}/sbin/
cp /sbin/greenbone-nvt-sync %{buildroot}/sbin/
cp /share/man/man8/openvassd.8 %{buildroot}/share/man/man8/
cp /share/man/man8/greenbone-nvt-sync.8 %{buildroot}/share/man/man8/
cp /share/doc/openvas-scanner/redis_config_examples/* %{buildroot}/share/doc/openvas-scanner/redis_config_examples/

%files
/lib64/libopenvas_misc.so.10.0.2
/lib64/libopenvas_misc.so.10
/lib64/libopenvas_misc.so
/var/log/gvm
/share/openvas
/etc/openvas
/etc/openvas/gnupg
/var/lib/openvas/gnupg
/lib64/libopenvas_nasl.so.10.0.2
/lib64/libopenvas_nasl.so.10
/lib64/libopenvas_nasl.so
/bin/openvas-nasl
/bin/openvas-nasl-lint
/share/man/man1/openvas-nasl.1
/share/man/man1/openvas-nasl-lint.1
/sbin/openvassd
/etc/openvas/openvassd_log.conf
/sbin/greenbone-nvt-sync
/share/man/man8/openvassd.8
/share/man/man8/greenbone-nvt-sync.8
/share/doc/openvas-scanner/redis_config_examples/redis_2_4.conf
/share/doc/openvas-scanner/redis_config_examples/redis_2_6.conf
/share/doc/openvas-scanner/redis_config_examples/redis_2_8.conf
/share/doc/openvas-scanner/redis_config_examples/redis_3_0.conf
/share/doc/openvas-scanner/redis_config_examples/redis_3_2.conf
/share/doc/openvas-scanner/redis_config_examples/redis_4_0.conf
/var/lib/openvas/plugins

%changelog
* Wed Aug 5 2020 aschryver Arctic Wolf Networks
-
