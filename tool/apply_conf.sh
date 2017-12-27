DOTFILES_DIR=~/dotfiles

BASHRC=$DOTFILES_DIR/vagrant/docker_host/provision/.bashrc
BASH_PROFILE=$DOTFILES_DIR/vagrant/docker_host/provision/.bash_profile

cp -f $BASHRC ~/.bashrc
cp -f $BASH_PROFILE ~/.bash_profile

source ~/.bash_profile
source ~/.bashrc
