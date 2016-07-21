nnoremap <Leader>i :<C-u>QuickRun <<Space>
nmap <Leader><S-R> <Plug>(quickrun)
" let g:quickrun_config = {'*': {'runmode': 'async:remote:vimproc'},}

let g:quickrun_config = {'*':{
\   'runmode': 'async:remote:vimproc',
\   "hook/output_encode/enable" : 1,
\   "hook/output_encode/encoding" : "cp932",
\}}
