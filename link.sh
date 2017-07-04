
install_root=~
if [ "$1" != "" ]
then
    install_root=$1
fi

# vim
ln -s ${install_root}/dotfiles/vim/rc/.vimrc ${install_root}/.vimrc
# ln -s ${install_root}/dotfiles/vim/rc/.gvimrc ${install_root}/.gvimrc
# ln -s ${install_root}/dotfiles/vim/rc/kaoriya/.vimrc_first.vim ${install_root}/.vimrc_first.vim
# ln -s ${install_root}/dotfiles/vim/rc/kaoriya/.gvimrc_first.vim ${install_root}/.gvimrc_first.vim

mkdir -p ${install_root}/.vim
ln -s ${install_root}/dotfiles/vim/rc ${install_root}/.vim/rc
ln -s ${install_root}/dotfiles/vim/autoload/ ${install_root}/.vim/autoload
ln -s ${install_root}/dotfiles/vim/dict ${install_root}/.vim/dict
ln -s ${install_root}/dotfiles/vim/snippets ${install_root}/.vim/snippets
ln -s ${install_root}/dotfiles/vim/after ${install_root}/.vim/after
ln -s ${install_root}/dotfiles/vim/ftplugin/ ${install_root}/.vim/ftplugin
ln -s ${install_root}/dotfiles/vim/syntax/ ${install_root}/.vim/syntax
ln -s ${install_root}/dotfiles/vim/indent/ ${install_root}/.vim/indent
ln -s ${install_root}/dotfiles/vim/rplugin ${install_root}/.vim/rplugin
ln -s ${install_root}/dotfiles/vim/plugins ${install_root}/.vim/plugins

mkdir -p ${install_root}/.vim/tmp/backup
mkdir -p ${install_root}/.vim/tmp/undo
mkdir -p ${install_root}/.vim/tmp/view
mkdir -p ${install_root}/.vim/tmp/swap
mkdir -p ${install_root}/.vim/reference

# neovim
mkdir -p ${install_root}/.config
ln -s ${install_root}/.vim ${install_root}/.config/nvim
ln -s ${install_root}/dotfiles/vim/rc/init.vim ${install_root}/.config/nvim/init.vim
# ln -s ${install_root}/dotfiles/vim/rc/ginit.vim ${install_root}/.config/nvim/ginit.vim

# ideaVim
# ln -s ${install_root}/dotfiles/idea/.ideavimrc ${install_root}/.ideavimrc

# lint
ln -s ${install_root}/dotfiles/lint/vim/.vintrc.yaml ${install_root}/.vintrc.yaml
ln -s ${install_root}/dotfiles/lint/python/.flake8 ${install_root}/.flake8

# git
ln -s ${install_root}/dotfiles/git/.gitignore_global ${install_root}/.gitignore_global
cp ${install_root}/dotfiles/git/.gitconfig ${install_root}/.gitconfig

if [ "$1" == "" ]
then
    read
fi
