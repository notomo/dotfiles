nvim \
    -c "runtime! plugin/rplugin.vim" \
    -u ~/dotfiles/vim/rc/minpac/minpac.vim \
    -i NONE \
    -c "call append(0, execute('call minpac#update()'))" \
    -c "%print" \
    -n --headless -c q!
