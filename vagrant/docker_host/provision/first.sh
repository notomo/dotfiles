# dotfiles
git clone https://github.com/tmn-o3/dotfiles.git
sh ~/dotfiles/link.sh

source ~/.bash_profile
source ~/.bashrc

# composer
composer global require squizlabs/php_codesniffer=*
composer global require phpmd/phpmd=*

# phpctags
git clone https://github.com/vim-php/phpctags.git ~/app/phpctags
cd ~/app/phpctags
make
