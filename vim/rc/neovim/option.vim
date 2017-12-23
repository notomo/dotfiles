
if has('unix')
    let g:python_host_prog = '/usr/bin/python'
    let g:python3_host_prog = '/usr/bin/python3.5'
elseif has('win32')
    let g:python3_host_prog = 'C:/Anaconda3/python.exe'
endif

set termguicolors
set clipboard+=unnamedplus
set inccommand=nosplit
set viminfo+=n~/.vim/tmp/nviminfo.txt
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175

if executable('nvr')
    let $VISUAL = 'nvr -cc split --remote-wait'
endif
