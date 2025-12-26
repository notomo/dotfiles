#!/bin/bash
set -eu

APP_DIR="$HOME/app"
GCLOUD_DIR="$APP_DIR/gcloud"
GCLOUD_TARBALL="$APP_DIR/gcloud.tar.gz"

OS=$(uname -s | tr '[:upper:]' '[:lower:]')
case "$OS" in
  linux)
    GCLOUD_URL="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz"
    ;;
  darwin)
    GCLOUD_URL="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-darwin-x86_64.tar.gz"
    ;;
  *)
    echo "Unsupported OS: $OS"
    exit 1
    ;;
esac

mkdir -p "$GCLOUD_DIR"
if [ ! -f "$GCLOUD_TARBALL" ]; then
  curl -L -o "$GCLOUD_TARBALL" "$GCLOUD_URL"
fi
tar -xzf "$GCLOUD_TARBALL" -C "$GCLOUD_DIR"

ZSHRC="$HOME/.zshrc"
MARKER_START="# BEGIN MANAGED BLOCK gcloud"
MARKER_END="# END MANAGED BLOCK gcloud"
GCLOUD_PATH_SCRIPT="$HOME/app/gcloud/google-cloud-sdk/path.zsh.inc"
if ! grep -q "$MARKER_START" "$ZSHRC" 2>/dev/null; then
  echo "Adding gcloud configuration to .zshrc..."
  cat >> "$ZSHRC" << EOF
$MARKER_START
if [ -f '$GCLOUD_PATH_SCRIPT' ]; then . '$GCLOUD_PATH_SCRIPT'; fi
$MARKER_END
EOF
fi

cd ~/app/gcloud/google-cloud-sdk
./install.sh
