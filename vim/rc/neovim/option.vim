
if has('unix')
    let g:python_host_prog = '/usr/bin/python'
    let g:python3_host_prog = '/usr/bin/python3'
elseif has('win32')
    let g:python3_host_prog = 'C:/Anaconda3/python.exe'
endif

set termguicolors
set clipboard+=unnamedplus
set inccommand=nosplit
set viminfo+=n~/.vim/tmp/nviminfo.txt
