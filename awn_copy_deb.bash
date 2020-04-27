#!/bin/bash

OPENVAS_DEB_BUILD_DIR=/tmp/openvas
OPENVAS_SCANNER_DEB_BUILD_DIR=/tmp/openvas-scanner
IMAGE="$1"
docker run -it ${IMAGE} /bin/true
LATEST=$(docker ps -l -f ancestor=${IMAGE} --format "{{.ID}}")
docker cp ${LATEST}:${OPENVAS_DEB_BUILD_DIR}/openvas_6.0.1_amd64.deb ./
docker cp ${LATEST}:${OPENVAS_SCANNER_DEB_BUILD_DIR}/openvas-scanner_8.0.1_amd64.deb ./
for dock in $(docker ps -f ancestor=${IMAGE} -a -q) ; do
	docker rm $dock
done