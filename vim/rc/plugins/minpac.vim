
let s:pack_dir = expand('~/.vim/minpac')
let s:minpac_dir = s:pack_dir . '/pack/minpac/opt/minpac'
execute 'set packpath^=' . s:pack_dir
let s:initializing = has('vim_starting') && !isdirectory(s:minpac_dir)
if s:initializing
    execute '!git clone --depth 1 https://github.com/k-takata/minpac ' . s:minpac_dir
endif

packadd minpac
call minpac#init()

source ~/.vim/rc/plugins/_list.vim

if s:initializing
    call minpac#update()
endif

packloadall

" post source eager load plugins
packadd gina.vim
source ~/.vim/rc/plugins/gina.vim
packadd lightline.vim
source ~/.vim/rc/plugins/lightline.vim
lua << EOF
vim.schedule(function()
  vim.cmd([[
runtime! after/plugin/cmp_*.lua
lua dofile(vim.fn.expand("~/.vim/lua/notomo/cmp.lua")).setup()
]])
end)
EOF

" NOTE: to load before default lua syntax.
let s:lua_syntax = s:pack_dir .. '/pack/minpac/start/vim-lua'
execute 'set runtimepath-=' .. s:lua_syntax
execute 'set runtimepath^=' .. s:lua_syntax

lua require('notomo.lsp')
lua require('notomo.lreload')
