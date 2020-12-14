
set runtimepath+=~/dotfiles/vim/rc/rplugins

set clipboard+=unnamedplus
set inccommand=nosplit
set viminfo+=n~/.vim/tmp/nviminfo.txt
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175
set wildoptions+=pum
set pumblend=15
set shada^='1000

if executable('nvr')
    let $VISUAL = 'nvr -cc split --remote-wait'
endif

if len($VAGRANT_PRIVATE_NETWORK_IP) > 0
    let local#var#host = $VAGRANT_PRIVATE_NETWORK_IP
endif

" for embed lua
let g:vimsyn_embed = 'lPr'

augroup mydev
    autocmd!
    execute 'autocmd BufWritePost' expand('<sfile>:p:h:h:h') .. '/lua/*' 'luafile' expand('~/dotfiles/vim/lua/notomo/cleanup.lua')
augroup END
