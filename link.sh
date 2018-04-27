
install_root=~
if [ "$1" != "" ]
then
    install_root=$1
fi

# vim
if [ ! -e "${install_root}"/.vimrc ]; then
    ln -s "${install_root}"/dotfiles/vim/rc/.vimrc "${install_root}"/.vimrc
fi

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
mkdir -p "${install_root}"/.vim/tmp/undo
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

# lint
if [ ! -e "${install_root}"/.vintrc.yaml ]; then
    ln -s "${install_root}"/dotfiles/lint/vim/.vintrc.yaml "${install_root}"/.vintrc.yaml
fi
if [ ! -e "${install_root}"/setup.cfg ]; then
    ln -s "${install_root}"/dotfiles/lint/python/setup.cfg "${install_root}"/setup.cfg
fi

# git
if [ ! -e "${install_root}"/.gitignore_global ]; then
    ln -s "${install_root}"/dotfiles/git/.gitignore_global "${install_root}"/.gitignore_global
fi
if [ ! -e "${install_root}"/.gitconfig ]; then
    cp "${install_root}"/dotfiles/git/.gitconfig "${install_root}"/.gitconfig
fi

mkdir -p "${install_root}"/app
cp -f "${install_root}"/dotfiles/tool/refresh_dotfiles_git.sh "${install_root}"/app/refresh_dotfiles_git.sh

if [ "$1" == "" ]
then
    read
fi

