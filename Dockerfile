FROM debian:latest
ENV LIB_INSTALL_PREFIX ${LIB_INSTALL_PREFIX:-/usr}
ENV DEB_BUILD_DIR ${DEB_BUILD_DIR:-/tmp/openvas}
RUN apt-get update && apt-get install -q -y --fix-missing \
  tar \
  devscripts \
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
  mkdir -p ${DEB_BUILD_DIR}/openvas-6.0.1/usr \
  ${DEB_BUILD_DIR}/openvas-6.0.1/usr/bin \
  ${DEB_BUILD_DIR}/openvas-6.0.1/usr/etc/openvas \
  ${DEB_BUILD_DIR}/openvas-6.0.1/usr/lib \
  ${DEB_BUILD_DIR}/openvas-6.0.1/usr/sbin \
  ${DEB_BUILD_DIR}/openvas-6.0.1/usr/share/doc/openvas-scanner/redis_config_examples \
  ${DEB_BUILD_DIR}/openvas-6.0.1/usr/share/man \
  ${DEB_BUILD_DIR}/openvas-6.0.1/usr/share/man/man1 \
  ${DEB_BUILD_DIR}/openvas-6.0.1/usr/share/man/man8 \
  ${DEB_BUILD_DIR}/openvas-6.0.1/usr/share/openvas \
  ${DEB_BUILD_DIR}/openvas-6.0.1/usr/var/lib/openvas/gnupg \
  ${DEB_BUILD_DIR}/openvas-6.0.1/usr/log/gvm && \
  # copy files
  cp /usr/bin/openvas-* ${DEB_BUILD_DIR}/openvas-6.0.1/usr/bin/ && \
  cp -r /usr/etc/openvas/* ${DEB_BUILD_DIR}/openvas-6.0.1/usr/etc/openvas/ && \
  cp /usr/lib/libopenvas*.so.10.0.1 ${DEB_BUILD_DIR}/openvas-6.0.1/usr/lib/ && \
  cp /usr/sbin/greenbone-nvt-sync ${DEB_BUILD_DIR}/openvas-6.0.1/usr/sbin/ && \
  cp /usr/sbin/openvassd ${DEB_BUILD_DIR}/openvas-6.0.1/usr/sbin/ && \
  cp /usr/share/doc/openvas-scanner/redis_config_examples/redis*.conf ${DEB_BUILD_DIR}/openvas-6.0.1/usr/share/doc/openvas-scanner/redis_config_examples/ && \
  cp /usr/share/man/man1/openvas-*.1 ${DEB_BUILD_DIR}/openvas-6.0.1/usr/share/man/man1/ && \
  cp /usr/share/man/man8/greenbone-nvt-sync.8 ${DEB_BUILD_DIR}/openvas-6.0.1/usr/share/man/man8/ && \
  cp /usr/share/man/man8/openvassd.8 ${DEB_BUILD_DIR}/openvas-6.0.1/usr/share/man/man8/ && \
  # create original archive
  cd ${DEB_BUILD_DIR} && \
  tar -czvf openvas_6.0.1.orig.tar.gz openvas-6.0.1
COPY Debian ${DEB_BUILD_DIR}/openvas-6.0.1
RUN set -x && \
  cd ${DEB_BUILD_DIR}/openvas-6.0.1 && \
  debuild -us -uc