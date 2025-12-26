#!/bin/bash

set -eu

WSLU_DIR="${HOME}/.local/app/wslu"
INSTALL_PREFIX="${HOME}/.local/wslu"

if [ ! -d "${WSLU_DIR}" ]; then
  git clone https://github.com/wslutilities/wslu.git "${WSLU_DIR}"
fi

cd "${WSLU_DIR}"
make all PREFIX=""
make install PREFIX="" DESTDIR="${INSTALL_PREFIX}"

if ! grep -q "WSLVIEW_DEFAULT_ENGINE" "${HOME}/.bash_profile" 2>/dev/null; then
  cat >> "${HOME}/.bash_profile" << 'EOF'

# BEGIN wslu
export WSLVIEW_DEFAULT_ENGINE=powershell
export PATH=$HOME/.local/wslu/bin:$PATH
# END wslu
EOF
fi
