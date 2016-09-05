" yankround
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)


" gundo
nnoremap <Leader>u :<C-u>GundoToggle<CR>


" vim-submode
let g:submode_keep_leaving_key = 1


" camelcasemotion
map <Leader>w <Plug>CamelCaseMotion_w
map <Leader>b <Plug>CamelCaseMotion_b
map <Leader>e <Plug>CamelCaseMotion_e


" caw
nmap <Space>c <Plug>(caw:hatpos:toggle)
vmap <Space>c <Plug>(caw:hatpos:toggle)


" colorizer
nnoremap <C-F1> :<C-u>ColorToggle<CR>


" current-func-info
function! s:yank_current_function_name(name) abort
    if a:name != ""
        let @+ = a:name
        echomsg "yank ".a:name
    else
        echomsg "no_function"
    endif
endfunction
nnoremap <silent> <Leader>f :<C-u>call <SID>yank_current_function_name(cfi#format("%s", "no_function"))<CR>


" emmet-vim
let g:user_emmet_leader_key = '<M-e > '
let g:user_emmet_mode = 'a'


" im-control
let s:bundle=neobundle#get('im_control.vim')
function! s:bundle.hooks.on_source(bundle)
    set formatoptions-=r
    set formatoptions-=o
endfunction
unlet s:bundle


" operator-camelize
map <Leader>cc <Plug>(operator-camelize)
map <Leader>hc <Plug>(operator-decamelize)


" operator-replace
map R  <Plug>(operator-replace)


" qutefinger
nnoremap [quickfix] <Nop>
nmap <Space>x [quickfix]

nmap [quickfix]c <Plug>(qutefinger-toggle-mode)
nmap [quickfix]n <Plug>(qutefinger-next)
nmap [quickfix]p <Plug>(qutefinger-prev)
nmap [quickfix]x <Plug>(qutefinger-toggle-win)
nmap [quickfix]f <Plug>(qutefinger-first)
nmap [quickfix]l <Plug>(qutefinger-last)


" restart
" :Restart 時に変数の定義を行う
nnoremap <C-S-F4> :<C-u>Restart<CR>
let s:bundle=neobundle#get('restart.vim')
function! s:bundle.hooks.on_source(bundle)
    " 終了時に保存するセッションオプションを設定する
    let g:restart_sessionoptions = 'curdir,help,tabpages'
endfunction
unlet s:bundle


" singleton
call singleton#enable()


" textobj-python
xmap <buffer> af <Plug>(textobj-python-function-a)
omap <buffer> af <Plug>(textobj-python-function-a)
xmap <buffer> if <Plug>(textobj-python-function-i)
omap <buffer> if <Plug>(textobj-python-function-i)
xmap <buffer> ac <Plug>(textobj-python-class-a)
omap <buffer> ac <Plug>(textobj-python-class-a)
xmap <buffer> ic <Plug>(textobj-python-class-i)
omap <buffer> ic <Plug>(textobj-python-class-i)


" vim-fontzoom
nnoremap <C-Up> :<C-u>Fontzoom+1<CR>
nnoremap <C-Down> :<C-u>Fontzoom-1<CR>
nnoremap <M-Down> :<C-u>Fontzoom!<CR>
nnoremap <M-Up> :<C-u>Fontzoom!<CR>


" vim-py3diff
set diffexpr=py3diff#diffexpr()


" vim-qfreplace
nnoremap <C-F2> :<C-u>Qfreplace<CR>


" vim-ref
let g:ref_phpmanual_path = $Home . '/.vim/phpmanual'
nmap <Leader>k <Plug>(ref-keyword)
inoremap <C-k> <Up>


" vim-textobj-line
vmap ah <Plug>(textobj-line-a)
vmap ih <Plug>(textobj-line-i)
omap ah <Plug>(textobj-line-a)
omap ih <Plug>(textobj-line-i)


" vim-zenspace
let g:zenspace#default_mode = 'on'


