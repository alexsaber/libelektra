#!/bin/sh

IDENTIFIER="0.8.19" # tag or hash of commit
PKGNAME="elektra"
PKGVERSION="${IDENTIFIER}"
RELEASE="1"
SOURCE="https://codeload.github.com/ElektraInitiative/libelektra/tar.gz/${IDENTIFIER}"
ELEKTRADIR="libelektra-${IDENTIFIER}"

# install elektra and create deb package
cd /vagrant
if [ ! -d "${ELEKTRADIR}" ]; then
    curl -sS ${SOURCE} | tar xz --transform "s/libelektra-${IDENTIFIER}/${ELEKTRADIR}/"
fi
if [ ! -d "{ELEKTRADIR}/build" ]; then
  mkdir "${ELEKTRADIR}/build"
fi
cd "${ELEKTRADIR}/build"
cmake -DCMAKE_INSTALL_PREFIX=/usr .. && make
checkinstall -D -y --pkgname ${PKGNAME} --pkgversion ${PKGVERSION} --pkgrelease ${RELEASE} --pkgsource ${SOURCE} --pakdir /vagrant

