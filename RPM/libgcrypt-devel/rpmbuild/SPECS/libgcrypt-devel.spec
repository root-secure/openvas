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

BuildRoot:      /tmp/rpmbuild

%description
Libgcrypt is a general purpose crypto library based on the code used
in GNU Privacy Guard.  This package contains files needed to develop
applications using libgcrypt.

%install
mkdir %{buildroot}/bin
mkdir -p %{buildroot}/usr/include
mkdir -p %{buildroot}/lib64/pkgconfig
mkdir %{buildroot}/share
mkdir %{buildroot}/share/aclocal
mkdir %{buildroot}/share/info
mkdir -p %{buildroot}/share/man/man1
cp /bin/dumpsexp %{buildroot}/bin/
cp /bin/hmac256 %{buildroot}/bin/
cp /bin/libgcrypt-config %{buildroot}/bin/
cp /bin/mpicalc %{buildroot}/bin/
cp /usr/include/gcrypt.h %{buildroot}/usr/include/
cp /lib64/libgcrypt.la %{buildroot}/lib64/
ln -s /lib64/libgcrypt.so.20.2.6 %{buildroot}/lib64/libgcrypt.so
ln -s /lib64/libgcrypt.so.20.2.6 %{buildroot}/lib64/libgcrypt.so.20
cp /lib64/libgcrypt.so.20.2.6 %{buildroot}/lib64/
cp /lib64/pkgconfig/libgcrypt.pc %{buildroot}/lib64/pkgconfig/
cp /share/aclocal/libgcrypt.m4 %{buildroot}/share/aclocal/
cp /share/info/dir %{buildroot}/share/info/
cp /share/info/gcrypt.info %{buildroot}/share/info/
cp /share/info/gcrypt.info-1 %{buildroot}/share/info/
cp /share/info/gcrypt.info-2 %{buildroot}/share/info/
cp /share/man/man1/hmac256.1 %{buildroot}/share/man/man1/

%files
/bin/dumpsexp
/bin/hmac256
/bin/libgcrypt-config
/bin/mpicalc
/usr/include/gcrypt.h
/lib64/libgcrypt.la
/lib64/libgcrypt.so
/lib64/libgcrypt.so.20
/lib64/libgcrypt.so.20.2.6
/lib64/pkgconfig/libgcrypt.pc
/share/aclocal/libgcrypt.m4
/share/info/dir
/share/info/gcrypt.info
/share/info/gcrypt.info-1
/share/info/gcrypt.info-2
/share/man/man1/hmac256.1

%changelog
* Wed Aug 5 2020 aschryver Arctic Wolf Networks
-