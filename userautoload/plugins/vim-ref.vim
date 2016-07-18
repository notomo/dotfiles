" let g:ref_refe_encoding = 'euc-jp'
" let g:ref_alc_encoding = 'Shift-JIS' " 文字化けするならここで文字コードを指定してみる
let g:ref_phpmanual_path = $Home . '/.vim/phpmanual'
nmap <Leader>k <Plug>(ref-keyword)
inoremap <C-k> <Up>
