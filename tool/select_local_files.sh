mkdir -p ~/local_files

mkdir -p ~/local_files/.local
cp -f ~/.local/.bash_profile ~/local_files/.local/.bash_profile
cp -f ~/.local/.bashrc ~/local_files/.local/.bashrc

cp -f ~/.denite_todo ~/local_files/.denite_todo
cp -f ~/.denite_url_bookmark ~/local_files/.denite_url_bookmark
cp -f ~/.denite_url_substitute_pattern ~/local_files/.denite_url_substitute_pattern

mkdir -p ~/local_files/dotfiles/vim/rc/local/after
cp -f ~/dotfiles/vim/rc/local/local.vim ~/local_files/dotfiles/vim/rc/local/local.vim
cp -fr ~/dotfiles/vim/rc/local/after ~/local_files/dotfiles/vim/rc/local

mkdir -p ~/local_files/workspace/memo
cp -f ~/workspace/memo/note.md ~/local_files/workspace/memo/note.md

mkdir -p ~/local_files/.ssh
cp -fr ~/.ssh/* ~/local_files/.ssh
if [ -f ~/local_files/.ssh/authorized_keys ]; then
    rm ~/local_files/.ssh/authorized_keys
fi
if [ -f ~/local_files/.ssh/vagrant_key.pub ]; then
    rm ~/local_files/.ssh/vagrant_key.pub
fi
