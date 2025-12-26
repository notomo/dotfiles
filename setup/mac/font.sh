#!/usr/bin/env bash

set -eu

font_name="SourceHanCodeJP"
font_version="2.011R"
app_dir="$HOME/app"
fonts_dir="$app_dir/fonts/$font_name"
font_file="$HOME/Library/Fonts/$font_name.ttc"

# Check if font is already installed
if [ -f "$font_file" ]; then
  echo "Font $font_name is already installed"
  exit 0
fi

# Make fonts download directory
mkdir -p "$fonts_dir"

# Download font
echo "Downloading $font_name..."
curl -L "https://github.com/adobe-fonts/source-han-code-jp/archive/$font_version.tar.gz" \
  -o "$app_dir/fonts/$font_name.tar.gz"

# Extract font
echo "Extracting $font_name..."
tar -xzf "$app_dir/fonts/$font_name.tar.gz" \
  -C "$fonts_dir" \
  --strip-components=1

# Install font
echo "Installing $font_name..."
cp "$fonts_dir/OTC/$font_name.ttc" "$font_file"

echo "Font $font_name installed successfully"
