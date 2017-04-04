# vim
ln -s ~/dotfiles/vim/rc/.vimrc ~/.vimrc
ln -s ~/dotfiles/vim/rc/.gvimrc ~/.gvimrc
ln -s ~/dotfiles/vim/rc/kaoriya/.vimrc_first.vim ~/.vimrc_first.vim
ln -s ~/dotfiles/vim/rc/kaoriya/.gvimrc_first.vim ~/.gvimrc_first.vim

mkdir -p ~/.vim
ln -s ~/dotfiles/vim/rc ~/.vim/rc
ln -s ~/dotfiles/vim/autoload/ ~/.vim/autoload
ln -s ~/dotfiles/vim/dict ~/.vim/dict
ln -s ~/dotfiles/vim/snippets ~/.vim/snippets
ln -s ~/dotfiles/vim/tmp ~/.vim/tmp
ln -s ~/dotfiles/vim/after ~/.vim/after
ln -s ~/dotfiles/vim/ftplugin/ ~/.vim/ftplugin
ln -s ~/dotfiles/vim/syntax/ ~/.vim/syntax

# neovim
mkdir -p ~/.config
ln -s ~/.vim ~/.config/nvim
ln -s ~/dotfiles/vim/rc/init.vim ~/.config/nvim/init.vim

# ideaVim
ln -s ~/dotfiles/idea/.ideavimrc ~/.ideavimrc

if [ "$1" != "-y" ]
then
    read
fi
