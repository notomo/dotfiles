
if has('mac')
    let g:python_host_prog = '/usr/local/bin/python'
    let g:python3_host_prog = '/usr/local/bin/python3'
elseif has('unix')
    let g:python_host_prog = '/usr/bin/python'
    let g:python3_host_prog = '/usr/bin/python3.5'
elseif has('win32')
    let g:python_host_prog = 'C:/Python27/python.exe'
    let g:python3_host_prog = 'C:/Python35/python.exe'
    let g:ruby_host_prog = 'C:\tools\ruby24\bin\ruby.exe'
endif

set clipboard+=unnamedplus
set inccommand=nosplit
set viminfo+=n~/.vim/tmp/nviminfo.txt
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175

if executable('nvr')
    let $VISUAL = 'nvr -cc split --remote-wait'
endif
