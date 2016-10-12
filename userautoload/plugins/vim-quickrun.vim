nnoremap <Leader>ri :<C-u>QuickRun <<Space>
nmap <Leader><S-R> <Plug>(quickrun)
vnoremap <silent> <Leader><S-R> :QuickRun -mode v<CR>

let g:quickrun_config = {'*':{
\   'runmode': 'async:remote:vimproc',
\   "hook/output_encode/enable" : 1,
\   "hook/output_encode/encoding" : "cp932",
\}}

let g:quickrun_config['cs'] = {
\   "hook/output_encode/encoding" : "sjis",
\}
let g:quickrun_config['vim'] = {
\   "hook/output_encode/encoding" : "utf-8",
\}
