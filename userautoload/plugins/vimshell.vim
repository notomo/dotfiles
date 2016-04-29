
let g:vimshell_prompt_expr = 'getcwd()." > "'
let g:vimshell_prompt_pattern = '^\f\+ > '
let g:vimshell_user_prompt = 'getcwd()'

nnoremap [shell] <Nop>
vnoremap [shell] <Nop>
nmap <Leader>s [shell]
vmap <Leader>s [shell]

"シェルを起動
" nnoremap <silent> [shell]r :<C-u>CdCurrent<CR>:VimShell<CR>
nnoremap <silent> [shell]r :<C-u>VimShellBufferDir<CR>
"シェルを終了
nmap <silent> [shell]x <Plug>(vimshell_exit)
"シェルを新しく起動
nnoremap <silent> [shell]c :<C-u>CdCurrent<CR>:VimShellCreate<CR>
"シェルを新しいタブで起動
nnoremap <silent> [shell]t :<C-u>CdCurrent<CR>:VimShellTab<CR>
"左右に分割してシェルを起動
nnoremap <silent> [shell]v :<C-u>vsplit<CR>:<C-w><C-W>:VimShell<CR>
"上下に分割してシェルを起動
nnoremap <silent> [shell]h :<C-u>split<CR>:<C-w><C-w>:VimShell<CR>
"pythonを非同期で起動
nnoremap <silent> [shell]p :VimShellInteractive python<CR>
"非同期で開いたインタプリタに現在の行を評価させる
nnoremap <silent> [shell]s :VimShellSendString<CR>
"非同期で開いたインタプリタに選択行を評価させる
vnoremap <silent> [shell]s :VimShellSendString<CR>

"shellを開いている間のキーマッピング
autocmd FileType vimshell call s:shell_my_settings()
function! s:shell_my_settings()"{{{
    nnoremap <buffer> <Space>uh G:<C-u>Unite vimshell/history<CR>
    nmap <buffer> <C-S-l> Gddih<Plug>(vimshell_enter)
    imap <buffer> <C-S-l> <ESC>Gddih<Plug>(vimshell_enter)
    inoremap <buffer> <C-w> <ESC>:<C-u>q<CR>
endfunction"}}}

