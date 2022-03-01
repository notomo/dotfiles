# on wsl
set -exu

host_home=`wslpath "$(wslvar USERPROFILE)"`

cd ~/app
rm -f nvim-win64.zip
wget https://github.com/neovim/neovim/releases/download/nightly/nvim-win64.zip
unzip -o nvim-win64.zip
cp -Rf nvim-win64 ${host_home}/app/
