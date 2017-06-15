
# bash
source ~/.bash_profile
source ~/.bashrc

# dotfiles
git clone https://github.com/tmn-o3/dotfiles.git
sh ~/dotfiles/link.sh

# composer
composer global require squizlabs/php_codesniffer=*
composer global require phpmd/phpmd=*

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
touch .gitkeep
