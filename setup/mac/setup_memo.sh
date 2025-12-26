# connect power supply
xcode-select --install
# if error occurs, download Command Line Tools from https://developer.apple.com/download/more/?=command%20line%20tools
# click install

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# input password

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "${HOME}/.config/karabiner"
cp "${SCRIPT_DIR}/karabiner.json" "${HOME}/.config/karabiner/karabiner.json"
