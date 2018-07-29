
# bash
source ~/.bash_profile
source ~/.bashrc

# dotfiles
if [ -d ~/dotfiles ]; then
    cd ~/dotfiles
    git fetch origin
    git reset --hard origin/master
else
    git clone https://github.com/notomo/dotfiles.git
fi
sh ~/dotfiles/link.sh
cd ~

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

# neovim-remote
pip3.5 install --user neovim-remote
git config --global core.editor 'nvr --remote-wait-silent'

# nvim spell
mkdir -p ~/.local/share/nvim/site/spell
cd ~/.local/share/nvim/site/spell
wget -nv http://ftp.vim.org/pub/vim/runtime/spell/en.utf-8.spl

# lemonade
go get -d github.com/pocke/lemonade
cd "$GOPATH"/src/github.com/pocke/lemonade/
make install

# bell off
echo "set bell-style none" >> ~/.inputrc

# workspace
mkdir -p ~/workspace
cd ~/workspace
mkdir -p test
mkdir -p memo
mkdir -p readonly

chmod 705 ~
