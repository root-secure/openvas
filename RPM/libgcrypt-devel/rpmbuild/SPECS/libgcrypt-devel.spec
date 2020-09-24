Name:           libgcrypt-devel
Version:        1.8.6
Release:        1%{?dist}
Group:          Development/Libraries
Summary:        Development files for the libgcrypt package

License:        LGPLv2+ and GPLv2+
URL:            http://www.gnupg.org/
Source:         https://gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.8.6.tar.bz2
Vendor:         CentOS

ExclusiveArch:  x86_64

Prefix:         /opt/awn

BuildRoot:      /tmp/rpmbuild

%description
Libgcrypt is a general purpose crypto library based on the code used
in GNU Privacy Guard.  This package contains files needed to develop
applications using libgcrypt.

%install
mkdir -p %{buildroot}/opt/awn/bin
mkdir -p %{buildroot}/opt/awn/usr/include
mkdir -p %{buildroot}/opt/awn/lib64/pkgconfig
mkdir -p %{buildroot}/opt/awn/share
mkdir -p %{buildroot}/opt/awn/share/aclocal
mkdir -p %{buildroot}/opt/awn/share/info
mkdir -p %{buildroot}/opt/awn/share/man/man1
mkdir -p %{buildroot}/etc/ld.so.conf.d
cp /bin/dumpsexp %{buildroot}/opt/awn/bin/
cp /bin/hmac256 %{buildroot}/opt/awn/bin/
cp /bin/libgcrypt-config %{buildroot}/opt/awn/bin/
cp /bin/mpicalc %{buildroot}/opt/awn/bin/
cp /usr/include/gcrypt.h %{buildroot}/opt/awn/usr/include/
cp /lib64/libgcrypt.la %{buildroot}/opt/awn/lib64/
ln -s /lib64/libgcrypt.so.20.2.6 %{buildroot}/opt/awn/lib64/libgcrypt.so
ln -s /lib64/libgcrypt.so.20.2.6 %{buildroot}/opt/awn/lib64/libgcrypt.so.20
cp /lib64/libgcrypt.so.20.2.6 %{buildroot}/opt/awn/lib64/
cp /lib64/pkgconfig/libgcrypt.pc %{buildroot}/opt/awn/lib64/pkgconfig/
cp /share/aclocal/libgcrypt.m4 %{buildroot}/opt/awn/share/aclocal/
cp /share/info/dir %{buildroot}/opt/awn/share/info/
cp /share/info/gcrypt.info %{buildroot}/opt/awn/share/info/
cp /share/info/gcrypt.info-1 %{buildroot}/opt/awn/share/info/
cp /share/info/gcrypt.info-2 %{buildroot}/opt/awn/share/info/
cp /share/man/man1/hmac256.1 %{buildroot}/opt/awn/share/man/man1/
mv /ld.so.conf.libgcrypt %{buildroot}/etc/ld.so.conf.d/libgcrypt.conf

%files
/opt/awn/bin/dumpsexp
/opt/awn/bin/hmac256
/opt/awn/bin/libgcrypt-config
/opt/awn/bin/mpicalc
/opt/awn/usr/include/gcrypt.h
/opt/awn/lib64/libgcrypt.la
/opt/awn/lib64/libgcrypt.so
/opt/awn/lib64/libgcrypt.so.20
/opt/awn/lib64/libgcrypt.so.20.2.6
/opt/awn/lib64/pkgconfig/libgcrypt.pc
/opt/awn/share/aclocal/libgcrypt.m4
/opt/awn/share/info/dir
/opt/awn/share/info/gcrypt.info
/opt/awn/share/info/gcrypt.info-1
/opt/awn/share/info/gcrypt.info-2
/opt/awn/share/man/man1/hmac256.1
/etc/ld.so.conf.d/libgcrypt.conf

%changelog
* Wed Sep 23 2020 smahood Arctic Wolf Networks
* Wed Aug 5 2020 aschryver Arctic Wolf Networks
-
