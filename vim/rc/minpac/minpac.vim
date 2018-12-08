
let s:minpac_dir = expand('~/.vim/pack/minpac/opt/minpac')
let s:initialized = v:false
if has('vim_starting') && !isdirectory(s:minpac_dir)
    execute '!git clone --depth 1 https://github.com/k-takata/minpac ' . s:minpac_dir
    let s:initialized = v:true
endif

packadd minpac
call minpac#init()

call minpac#add('k-takata/minpac', {'type': 'opt'})

source ~/.vim/rc/minpac/eager.vim
if has('nvim')
    source ~/.vim/rc/minpac/neovim_eager.vim
endif
source ~/.vim/rc/minpac/lazy.vim

if s:initialized
    call minpac#update()
    UpdateRemotePlugins
endif

packloadall

source ~/.vim/rc/plugins/unite.vim
source ~/.vim/rc/plugins/vimfiler.vim
source ~/.vim/rc/plugins/denite.vim
source ~/.vim/rc/plugins/gina.vim
source ~/.vim/rc/plugins/lightline.vim


" NOTICE: for test
syntax enable
filetype plugin indent on
colorscheme spring-night
