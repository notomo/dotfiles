
NEOVIM_DIR=~/app/neovim

if [ -d $NEOVIM_DIR ]
then
    cd $NEOVIM_DIR
    sudo rm -r build
    sudo make distclean
else
    git clone https://github.com/neovim/neovim.git $NEOVIM_DIR
    cd $NEOVIM_DIR
fi
sudo make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo chown vagrant:vagrant -R $NEOVIM_DIR
