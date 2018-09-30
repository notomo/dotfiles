# bash
source ~/.bash_profile
source ~/.bashrc

# neovim
cd ~/app
wget -nv https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
mkdir -p ~/.local/bin
cp nvim.appimage ~/.local/bin/nvim
chmod u+x ~/.local/bin/nvim

# dotfiles
cd ~
git clone https://github.com/notomo/dotfiles.git
sh ~/dotfiles/link.sh

# composer
mkdir -p ~/.config/composer
cp -f /vagrant/provision/composer.json ~/.config/composer/composer.json
cd ~/.config/composer
composer global install

# phpmanual
cd ~/.vim/reference
wget -nv http://jp2.php.net/get/php_manual_ja.tar.gz/from/this/mirror -O php_manual_ja.tar.gz
tar zxf php_manual_ja.tar.gz
mv php-chunked-xhtml phpmanual
rm php_manual_ja.tar.gz

# go
go get -u github.com/nsf/gocode
go get -u golang.org/x/tools/cmd/goimports
go get -u github.com/golang/lint/golint
go get -u golang.org/x/tools/cmd/gotype
go get -u honnef.co/go/tools/cmd/gosimple
go get -u honnef.co/go/tools/cmd/staticcheck
go get -u github.com/alecthomas/gometalinter
go get -u honnef.co/go/tools/cmd/unused
go get -u github.com/mattn/mkup
go get -u github.com/github/hub
go get -u github.com/notomo/wsxhub/...
go get -u github.com/notomo/elsied/...
go get -u github.com/jackc/sqlfmt/...
go get -u mvdan.cc/sh/cmd/shfmt
go get -u github.com/kyoshidajp/ghkw

# neovim-remote
pip3.5 install --user neovim-remote

# nvim spell
mkdir -p ~/.local/share/nvim/site/spell
cd ~/.local/share/nvim/site/spell
wget -nv http://ftp.vim.org/pub/vim/runtime/spell/en.utf-8.spl

# lemonade
go get -d github.com/pocke/lemonade
cd "$GOPATH"/src/github.com/pocke/lemonade/
make install

# xdg-open
if [ -e /usr/bin/xdg-open ]; then
    sudo mv /usr/bin/xdg-open /usr/bin/xdg-open.tmp
fi
sudo ln -s "$GOPATH"/bin/lemonade /usr/bin/xdg-open

# workspace
mkdir -p ~/workspace
cd ~/workspace
mkdir -p memo
mkdir -p lsync/chrome
mkdir -p nodejs

cd ~/workspace/lsync/chrome
git clone https://github.com/notomo/ctrlb.git
cd ctrlb
npm install

# .local/rc
touch ~/.local/.bashrc
touch ~/.local/.bash_profile

chmod 705 ~
