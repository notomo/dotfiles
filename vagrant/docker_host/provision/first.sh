
# bash
source ~/.bash_profile
source ~/.bashrc

# dotfiles
if [ -d ~/dotfiles ]; then
    cd ~/dotfiles
    git fetch origin
    git reset --hard origin/master
else
    git clone git@github.com:notomo/dotfiles.git
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
wget http://jp2.php.net/get/php_manual_ja.tar.gz/from/this/mirror -O php_manual_ja.tar.gz
tar zxf php_manual_ja.tar.gz
mv php-chunked-xhtml phpmanual
rm php_manual_ja.tar.gz

# go
go get -u github.com/nsf/gocode
go get -u golang.org/x/tools/cmd/goimports
go get -u github.com/golang/lint/golint

# ruby
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
sudo yum install -y gcc-6 bzip2 openssl-devel libyaml-devel libffi-devel readline-devel zlib-devel gdbm-devel ncurses-devel
source ~/.bashrc
rbenv install 2.4.2
rbenv global 2.4.2
gem install neovim
gem install rubocop

# workspace
mkdir -p ~/workspace
cd ~/workspace
mkdir -p test
mkdir -p memo

chmod 705 ~
