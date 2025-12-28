#!/bin/bash

set -eu

WSLU_DIR="${HOME}/app/wslu"
INSTALL_PREFIX="${HOME}/.local/wslu"

if [ ! -d "${WSLU_DIR}" ]; then
  git clone https://github.com/wslutilities/wslu.git "${WSLU_DIR}"
fi

pushd "${WSLU_DIR}"
make all PREFIX=""
make install PREFIX="" DESTDIR="${INSTALL_PREFIX}"
popd
