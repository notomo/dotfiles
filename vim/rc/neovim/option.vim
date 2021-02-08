
set clipboard+=unnamedplus
if has('win32')
    let g:clipboard = {
        \ 'name': 'win32yank',
        \ 'copy': {'+': 'win32yank -i --crlf', '*': 'win32yank -i --crlf'},
        \ 'paste': {'+': 'win32yank -o --lf', '*': 'win32yank -o --lf'},
        \ 'cache_enabled': 0,
    \ }
endif

set inccommand=nosplit
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175
set wildoptions+=pum
set pumblend=15
set shada^='1000

if executable('nvr')
    let $VISUAL = 'nvr -cc split --remote-wait'
endif

" for embed lua
let g:vimsyn_embed = 'lPr'

autocmd MyAuGroup TextYankPost * silent! lua vim.highlight.on_yank({higroup = "Flashy", timeout = 200, on_macro = true, on_visual = true})
