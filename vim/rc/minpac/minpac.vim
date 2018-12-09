
let s:minpac_dir = expand('~/.vim/pack/minpac/opt/minpac')
let s:initialized = v:false
if has('vim_starting') && !isdirectory(s:minpac_dir)
    execute '!git clone --depth 1 https://github.com/k-takata/minpac ' . s:minpac_dir
    let s:initialized = v:true
endif

packadd minpac
call minpac#init()

source ~/.vim/rc/minpac/eager.vim
source ~/.vim/rc/minpac/filetype.vim
if has('nvim')
    source ~/.vim/rc/minpac/neovim_eager.vim
endif
source ~/.vim/rc/minpac/lazy.vim

if s:initialized
    call minpac#update()
    UpdateRemotePlugins
endif

packloadall

" source post
source ~/.vim/rc/plugins/unite.vim
source ~/.vim/rc/plugins/vimfiler.vim
source ~/.vim/rc/plugins/denite.vim
source ~/.vim/rc/plugins/gina.vim
source ~/.vim/rc/plugins/lightline.vim
source ~/.vim/rc/plugins/deoplete.vim
source ~/.vim/rc/plugins/curstr.vim
source ~/.vim/rc/plugins/gesture.vim
IncSearchNoreMap <Tab> <Over>(incsearch-next)
IncSearchNoreMap <S-Tab> <Over>(incsearch-prev)
IncSearchNoreMap <C-Space> <Tab>
IncSearchNoreMap <C-j> <Down>
IncSearchNoreMap <C-k> <Up>
IncSearchNoreMap <C-l> <Right>
IncSearchNoreMap <Space> <CR>
IncSearchNoreMap <S-Space> <Space>
IncSearchNoreMap <C-n> <Over>(incsearch-scroll-f)
IncSearchNoreMap <C-p> <Over>(incsearch-scroll-b)
