
let s:pack_dir = expand('~/.vim/minpac')
let s:minpac_dir = s:pack_dir . '/pack/minpac/opt/minpac'
execute 'set packpath^=' . s:pack_dir
let s:initialized = v:false
if has('vim_starting') && !isdirectory(s:minpac_dir)
    execute '!git clone --depth 1 https://github.com/k-takata/minpac ' . s:minpac_dir
    let s:initialized = v:true
endif

packadd minpac
call minpac#init()

source ~/.vim/rc/minpac/eager.vim
if has('nvim')
    source ~/.vim/rc/minpac/neovim_eager.vim
endif
source ~/.vim/rc/minpac/lazy.vim

if s:initialized
    call minpac#update()
    if has('nvim')
        UpdateRemotePlugins
    endif
endif

packloadall

" post source eager load plugins
source ~/.vim/rc/plugins/gina.vim
source ~/.vim/rc/plugins/lightline.vim

" NOTE: to load before default lua syntax.
let s:lua_syntax = s:pack_dir .. '/pack/minpac/start/vim-lua'
execute 'set runtimepath-=' .. s:lua_syntax
execute 'set runtimepath^=' .. s:lua_syntax

if has('nvim')
    lua require('notomo/lsp')
    if executable('python3')
        source ~/.vim/rc/plugins/deoplete.vim
    endif
endif
