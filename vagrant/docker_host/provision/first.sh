
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

# workspace
mkdir -p ~/workspace
cd ~/workspace
mkdir -p test
mkdir -p memo
