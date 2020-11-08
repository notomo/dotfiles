# on wsl
set -exu

host_home=`wslpath "$(wslvar USERPROFILE)"`

cd ~/app
rm nvim-win64.zip
wget https://github.com/neovim/neovim/releases/download/nightly/nvim-win64.zip
unzip -o nvim-win64.zip
cp -Rf Neovim ${host_home}/app/
