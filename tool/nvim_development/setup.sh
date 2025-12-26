#!/usr/bin/env bash

set -eu

sudo apt update
sudo apt install -y \
  ninja-build \
  gettext \
  cmake \
  g++ \
  pkg-config \
  unzip \
  curl \
  systemd-coredump \
;

NEOVIM_SOURCE_DIR="${HOME}/workspace/neovim"
if [[ ! -d "$NEOVIM_SOURCE_DIR" ]]; then
  git clone https://github.com/neovim/neovim.git "$NEOVIM_SOURCE_DIR"
fi

brew install \
  llvm \
  gdb \
  uncrustify \
  doxygen \
  ccache \
;
