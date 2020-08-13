FROM centos:7.8.2003

# setup environment
ENV ZLIB_VERSION ${ZLIB_VERSION:-1.2.11}
ENV LIBGPG_ERROR_VERSION ${LIBGPG_ERROR_VERSION:-1.38}
ENV LIBASSUAN_VERSION ${LIBASSUAN_VERSION:-2.5.3}
ENV GPGME_VERSION ${GPGME_VERSION:-1.14.0}
ENV LIBGCRYPT_VERSION ${LIBGCRYPT_VERSION:-1.8.6}
ENV LIB_INSTALL_PREFIX ${LIB_INSTALL_PREFIX:-/}
ENV OPENVAS_RPM_BUILD_DIR ${OPENVAS_RPM_BUILD_DIR:-/root/openvas/rpmbuild}
ENV OPENVAS_SCANNER_RPM_BUILD_DIR ${OPENVAS_SCANNER_RPM_BUILD_DIR:-/root/openvas-scanner/rpmbuild}
ENV LIBGCRYPT_DEVEL_RPM_BUILD_DIR ${LIBGCRYPT_DEVEL_RPM_BUILD_DIR:-/root/libgcrypt-devel/rpmbuild}

#install repositories
RUN yum -y install epel-release && \
  yum repolist

# install packages
RUN yum update -y && \
  yum install -q -y \
    git \
    wget \
    which \
    rpm-build \
    rpmlint \
    gnupg2-smime \
    tar \
    bzip2 \
    cmake3 \
    gcc \
    bison \
    glib2-devel \
    gnutls-devel \
    hiredis-devel \
    libssh-devel \
    libuuid-devel \
    libksba-devel \
    libpcap-devel && \
  yum clean all && \
  rm -rf /var/cache/yum/*

# install missing packages from source
WORKDIR /tmp/zlib
RUN wget https://www.zlib.net/zlib-${ZLIB_VERSION}.tar.gz && \
  tar -xzvf zlib-${ZLIB_VERSION}.tar.gz --strip-components=1 && \
  ./configure --prefix=/ --libdir=/lib64 --includedir=/usr/include && make && make install
WORKDIR /tmp/libgpg-error
RUN wget https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-${LIBGPG_ERROR_VERSION}.tar.bz2 && \
  tar -jxvf libgpg-error-${LIBGPG_ERROR_VERSION}.tar.bz2 --strip-components=1 && \
  ./configure --prefix=/ --libdir=/lib64 --includedir=/usr/include && make && make install
WORKDIR /tmp/libassuan
RUN wget https://www.gnupg.org/ftp/gcrypt/libassuan/libassuan-${LIBASSUAN_VERSION}.tar.bz2 && \
  tar -jxvf libassuan-${LIBASSUAN_VERSION}.tar.bz2 --strip-components=1 && \
  ./configure --prefix=/ --libdir=/lib64 --includedir=/usr/include && make && make install
WORKDIR /tmp/gpgme
RUN wget https://www.gnupg.org/ftp/gcrypt/gpgme/gpgme-${GPGME_VERSION}.tar.bz2 && \
  tar -jxvf gpgme-${GPGME_VERSION}.tar.bz2 --strip-components=1 && \
  ./configure CC=c99 --prefix=/ --libdir=/lib64 --includedir=/usr/include && make && make install
WORKDIR /tmp/libgcrypt
RUN wget https://gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-${LIBGCRYPT_VERSION}.tar.bz2 && \
  tar -jxvf libgcrypt-${LIBGCRYPT_VERSION}.tar.bz2 --strip-components=1 && \
  ./configure --prefix=/ --libdir=/lib64 --includedir=/usr/include && make && make install
WORKDIR /tmp/gvm-libs
RUN set -x && \
  git clone https://github.com/root-secure/gvm-libs.git && \
  cd gvm-libs && \
  git fetch && git checkout awn-gvm-libs-10.0 && \
  sed -i 's/uuid>=2.25.0/uuid>=2.23.0/g' util/CMakeLists.txt && \
  mkdir build && cd build && \
  cmake3 -DCMAKE_INSTALL_PREFIX=${LIB_INSTALL_PREFIX} .. && make && make install

# build openvas
WORKDIR /tmp/openvas
COPY . .
RUN set -x && \
  mkdir build && cd build && \
  cmake3 -DCMAKE_INSTALL_PREFIX=${LIB_INSTALL_PREFIX} .. && make && make install

# build the RPM
WORKDIR ${OPENVAS_RPM_BUILD_DIR}
COPY RPM/openvas/rpmbuild .
RUN set -x && \
  rpmbuild -bb SPECS/openvas.spec
WORKDIR ${OPENVAS_SCANNER_RPM_BUILD_DIR}
COPY RPM/openvas-scanner/openvas-scanner.logrotate /etc/logrotate.d/openvas-scanner
COPY RPM/openvas-scanner/openvas-scanner.service /etc/systemd/system/multi-user.target.wants/
COPY RPM/openvas-scanner/rpmbuild .
RUN set -x && \
  rpmbuild -bb SPECS/openvas-scanner.spec
WORKDIR ${LIBGCRYPT_DEVEL_RPM_BUILD_DIR}
COPY RPM/libgcrypt-devel/rpmbuild .
RUN set -x && \
  rpmbuild -bb SPECS/libgcrypt-devel.spec