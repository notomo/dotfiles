
install_root=~
if [ "$1" != "" ]
then
    install_root=$1
fi

# vim
if [ ! -e "${install_root}"/.vimrc ]; then
    ln -s "${install_root}"/dotfiles/vim/rc/.vimrc "${install_root}"/.vimrc
fi
# if [ ! -e "${install_root}"/.gvimrc ]; then
#     ln -s "${install_root}"/dotfiles/vim/rc/.gvimrc "${install_root}"/.gvimrc
# fi
# if [ ! -e "${install_root}"/.vimrc_first ]; then
#     ln -s "${install_root}"/dotfiles/vim/rc/.vimrc_first "${install_root}"/.vimrc_first
# fi
# if [ ! -e "${install_root}"/.gvimrc_first ]; then
#     ln -s "${install_root}"/dotfiles/vim/rc/.gvimrc_first "${install_root}"/.gvimrc_first
# fi

mkdir -p "${install_root}"/.vim
# vim
if [ ! -e "${install_root}"/.vim/rc ]; then
    ln -s "${install_root}"/dotfiles/vim/rc "${install_root}"/.vim/rc
fi
if [ ! -e "${install_root}"/.vim/dict ]; then
    ln -s "${install_root}"/dotfiles/vim/dict "${install_root}"/.vim/dict
fi
if [ ! -e "${install_root}"/.vim/autoload ]; then
    ln -s "${install_root}"/dotfiles/vim/autoload "${install_root}"/.vim/autoload
fi
if [ ! -e "${install_root}"/.vim/snippets ]; then
    ln -s "${install_root}"/dotfiles/vim/snippets "${install_root}"/.vim/snippets
fi
if [ ! -e "${install_root}"/.vim/after ]; then
    ln -s "${install_root}"/dotfiles/vim/after "${install_root}"/.vim/after
fi
if [ ! -e "${install_root}"/.vim/ftplugin ]; then
    ln -s "${install_root}"/dotfiles/vim/ftplugin "${install_root}"/.vim/ftplugin
fi
if [ ! -e "${install_root}"/.vim/syntax ]; then
    ln -s "${install_root}"/dotfiles/vim/syntax "${install_root}"/.vim/syntax
fi
if [ ! -e "${install_root}"/.vim/indent ]; then
    ln -s "${install_root}"/dotfiles/vim/indent "${install_root}"/.vim/indent
fi
if [ ! -e "${install_root}"/.vim/rplugin ]; then
    ln -s "${install_root}"/dotfiles/vim/rplugin "${install_root}"/.vim/rplugin
fi
if [ ! -e "${install_root}"/.vim/plugin ]; then
    ln -s "${install_root}"/dotfiles/vim/plugin "${install_root}"/.vim/plugin
fi

mkdir -p "${install_root}"/.vim/tmp/backup
mkdir -p "${install_root}"/.vim/tmp/und
mkdir -p "${install_root}"/.vim/tmp/view
mkdir -p "${install_root}"/.vim/tmp/swap
mkdir -p "${install_root}"/.vim/reference

# neovim
mkdir -p "${install_root}"/.config
if [ ! -e "${install_root}"/.config/nvim ]; then
    ln -s "${install_root}"/.vim "${install_root}"/.config/nvim
fi
if [ ! -e "${install_root}"/.config/nvim/init.vim ]; then
    ln -s "${install_root}"/dotfiles/vim/rc/init.vim "${install_root}"/.config/nvim/init.vim
fi
# if [ ! -e "${install_root}"/.config/nvim/ginit.vim ]; then
#     ln -s "${install_root}"/dotfiles/vim/rc/ginit.vim "${install_root}"/.config/nvim/ginit.vim
# fi

# ideaVim
# if [ ! -e "${install_root}"/.ideavimrc ]; then
#     ln -s "${install_root}"/dotfiles/lint/vim/.ideavimrc "${install_root}"/.ideavimrc
# fi

# lint
if [ ! -e "${install_root}"/.vintrc.yaml ]; then
    ln -s "${install_root}"/dotfiles/lint/vim/.vintrc.yaml "${install_root}"/.vintrc.yaml
fi
if [ ! -e "${install_root}"/setup.cfg ]; then
    ln -s "${install_root}"/dotfiles/lint/vim/setup.cfg "${install_root}"/setup.cfg
fi

# git
if [ ! -e "${install_root}"/.gitignore_global ]; then
    ln -s "${install_root}"/dotfiles/lint/vim/.gitignore_global "${install_root}"/.gitignore_global
fi
cp "${install_root}"/dotfiles/git/.gitconfig "${install_root}"/.gitconfig

if [ ! -e "${install_root}"/.ctags ]; then
    ln -s "${install_root}"/dotfiles/lint/vim/.ctags "${install_root}"/.ctags
fi

if [ "$1" == "" ]
then
    read
fi
