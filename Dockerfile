FROM ubuntu:latest
ENV LIB_INSTALL_PREFIX ${LIB_INSTALL_PREFIX:-/usr}
ENV OPENVAS_DEB_BUILD_DIR ${OPENVAS_DEB_BUILD_DIR:-/tmp/openvas}
ENV OPENVAS_SCANNER_DEB_BUILD_DIR ${OPENVAS_SCANNER_DEB_BUILD_DIR:-/tmp/openvas-scanner}
RUN apt-get update && apt-get install -q -y --fix-missing \
  tar \
  devscripts \
  debhelper \
  cmake \
  gcc \
  pkg-config \
  bison \
  libglib2.0-dev \
  libgcrypt20-dev \
  libgnutls28-dev \
  libgpgme-dev \
  libksba-dev \
  libpcap-dev \
  libsnmp-dev \
  libhiredis-dev \
  uuid-dev \
  libssh-gcrypt-dev && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*
WORKDIR /tmp/build/gvm-libs
RUN set -x && \
  git clone https://github.com/root-secure/gvm-libs.git && \
  cd gvm-libs && \
  git fetch && git checkout awn-gvm-libs-10.0 && \
  mkdir build && cd build && \
  cmake -DCMAKE_INSTALL_PREFIX=${LIB_INSTALL_PREFIX} .. && make && make install
WORKDIR /tmp/build/openvas
COPY . .
RUN set -x && \
  mkdir build && cd build && \
  cmake -DCMAKE_INSTALL_PREFIX=${LIB_INSTALL_PREFIX} .. && make && make install
RUN set -x && \
  # create directories
  mkdir -p ${OPENVAS_DEB_BUILD_DIR}/openvas-6.0.1/usr \
  ${OPENVAS_DEB_BUILD_DIR}/openvas-6.0.1/usr/bin \
  ${OPENVAS_DEB_BUILD_DIR}/openvas-6.0.1/usr/etc/openvas \
  ${OPENVAS_DEB_BUILD_DIR}/openvas-6.0.1/usr/lib \
  ${OPENVAS_DEB_BUILD_DIR}/openvas-6.0.1/usr/sbin \
  ${OPENVAS_DEB_BUILD_DIR}/openvas-6.0.1/usr/share/doc/openvas-scanner/redis_config_examples \
  ${OPENVAS_DEB_BUILD_DIR}/openvas-6.0.1/usr/share/man \
  ${OPENVAS_DEB_BUILD_DIR}/openvas-6.0.1/usr/share/man/man1 \
  ${OPENVAS_DEB_BUILD_DIR}/openvas-6.0.1/usr/share/man/man8 \
  ${OPENVAS_DEB_BUILD_DIR}/openvas-6.0.1/usr/share/openvas \
  ${OPENVAS_DEB_BUILD_DIR}/openvas-6.0.1/usr/var/lib/openvas/gnupg \
  ${OPENVAS_DEB_BUILD_DIR}/openvas-6.0.1/usr/log/gvm && \
  # copy files
  cp /usr/bin/openvas-* ${OPENVAS_DEB_BUILD_DIR}/openvas-6.0.1/usr/bin/ && \
  cp -r /usr/etc/openvas/* ${OPENVAS_DEB_BUILD_DIR}/openvas-6.0.1/usr/etc/openvas/ && \
  cp /usr/lib/libopenvas*.so.10.0.1 ${OPENVAS_DEB_BUILD_DIR}/openvas-6.0.1/usr/lib/ && \
  cp /usr/sbin/greenbone-nvt-sync ${OPENVAS_DEB_BUILD_DIR}/openvas-6.0.1/usr/sbin/ && \
  cp /usr/sbin/openvassd ${OPENVAS_DEB_BUILD_DIR}/openvas-6.0.1/usr/sbin/ && \
  cp /usr/share/doc/openvas-scanner/redis_config_examples/redis*.conf ${OPENVAS_DEB_BUILD_DIR}/openvas-6.0.1/usr/share/doc/openvas-scanner/redis_config_examples/ && \
  cp /usr/share/man/man1/openvas-*.1 ${OPENVAS_DEB_BUILD_DIR}/openvas-6.0.1/usr/share/man/man1/ && \
  cp /usr/share/man/man8/greenbone-nvt-sync.8 ${OPENVAS_DEB_BUILD_DIR}/openvas-6.0.1/usr/share/man/man8/ && \
  cp /usr/share/man/man8/openvassd.8 ${OPENVAS_DEB_BUILD_DIR}/openvas-6.0.1/usr/share/man/man8/ && \
  # create original archive
  cd ${OPENVAS_DEB_BUILD_DIR} && \
  tar -czvf openvas_6.0.1.orig.tar.gz openvas-6.0.1
COPY Debian/openvas ${OPENVAS_DEB_BUILD_DIR}/openvas-6.0.1
RUN set -x && \
  cd ${OPENVAS_DEB_BUILD_DIR}/openvas-6.0.1 && \
  debuild -us -uc
COPY Debian/openvas-scanner ${OPENVAS_SCANNER_DEB_BUILD_DIR}/openvas-scanner
RUN set -x && \
  cd ${OPENVAS_SCANNER_DEB_BUILD_DIR}/openvas-scanner && \
  debuild -us -uc