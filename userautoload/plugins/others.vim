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
let g:submode_timeout = 0

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
" noremap <Plug>(operator-no_yank_delete) "_d
" noremap <expr> r operator#sequence#map("\<Plug>(operator-no_yank_delete)", ["\<Plug>(yankround-P)"])
map r <Plug>(operator-replace)


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


" vim-operator-stay-cursor
" map y <Plug>(operator-stay-cursor-yank)


omap aj <Plug>(textobj-multiblock-a)
omap ij <Plug>(textobj-multiblock-i)
vmap aj <Plug>(textobj-multiblock-a)
vmap ij <Plug>(textobj-multiblock-i)

" highlight mapping"{{{
nnoremap [highlight] <Nop>
nmap <Leader>h [highlight]
xnoremap [highlight] <Nop>
xmap <Leader>h [highlight]
nmap [highlight]t <Plug>(quickhl-manual-this)
xmap [highlight]t <Plug>(quickhl-manual-this)
nmap [highlight]r <Plug>(quickhl-manual-reset)
xmap [highlight]r <Plug>(quickhl-manual-reset)
nmap [highlight]a <Plug>(quickhl-manual-toggle)
"}}}

omap <expr> pd textobj#from_regexp#mapexpr('\$[a-zA-Z0-9_]\+')
xmap <expr> pd textobj#from_regexp#mapexpr('\$[a-zA-Z0-9_]\+')

omap <expr> py textobj#from_regexp#mapexpr('\$[a-zA-Z0-9_]\+->')
xmap <expr> py textobj#from_regexp#mapexpr('\$[a-zA-Z0-9_]\+->')

omap <expr> i<Space> textobj#from_regexp#mapexpr(' \zs.\{-}\ze ')
xmap <expr> i<Space> textobj#from_regexp#mapexpr(' \zs.\{-}\ze ')

omap <expr> a<Space> textobj#from_regexp#mapexpr(' .\{-1,}\( \)\@=')
xmap <expr> a<Space> textobj#from_regexp#mapexpr(' .\{-1,}\( \)\@=')

" let g:textobj_blockwise_enable_default_key_mapping = 0

function! s:get_region(expr1, expr2, visual_commnad)
  let [lnum1, col1] = getpos(a:expr1)[1:2]
  let [lnum2, col2] = getpos(a:expr2)[1:2]
  let region = getline(lnum1, lnum2)

  if a:visual_commnad ==# "v"  " char
    if lnum1 == lnum2  " single line
      let region[0] = s:strpart(region[-1], col1 - 1, col2 - (col1 - 1))
    else  " multi line
      let region[0] = s:strpart(region[0], col1 - 1)
      let region[-1] = s:strpart(region[-1], 0, col2)
    endif
  elseif a:visual_commnad ==# "V"  " line
    let region += ['']
  else  " block
    call map(region, 's:strpart(v:val, col1 - 1, col2 - (col1 - 1))')
  endif

  return region
endfunction

function! s:strpart(src, start, ...)
  let str = strpart(a:src, a:start)
  if a:0 > 0
    let i = byteidx(strpart(str, a:1 - 1), 1) - 1
    return i == -1 ? str : strpart(str, 0, a:1 + i)
  else
    return str
  endif
endfunction

function! OperatorSearch(motion_wiseness)
    let visual_commnad = operator#user#visual_command_from_wise_name(a:motion_wiseness)
    let region = join(map(s:get_region("'[", "']", visual_commnad),'escape(v:val, "\\/")'),'\n')
    let region_replaced_space = substitute(region, ' ', '\\s', 'g')
    call incsearch#call({'pattern' : region_replaced_space, 'is_expr' : 0})
endfunction

call operator#user#define('search-forward', 'OperatorSearch')
" nmap ss <Plug>(operator-search-forward)

let g:loaded_matchparen = 1



" nnoremap <silent> <Space>pf :OverCommandLine<CR>%s///g<Left><Left><Left>
" nnoremap <Space>pw :OverCommandLine<CR>%s/<C-r><C-w>//g<Left><Left>
" nnoremap <Space>py :OverCommandLine<CR>%s!<C-r>=substitute(@0, '!', '\\!', 'g')<CR>!!gI<Left><Left><Left>

" OverCommandLineNoremap <C-b> <BS>
" OverCommandLineNoremap <C-d> <Del>
