
nnoremap [exec] <Nop>
nmap <Space>x [exec]
xnoremap [exec] <Nop>
xmap <Space>x [exec]
nnoremap [keyword] <Nop>
nmap <Space>k [keyword]
nnoremap [diff] <Nop>
nmap <Leader>d [diff]
xnoremap [diff] <Nop>
xmap <Leader>d [diff]
nnoremap [edit] <Nop>
nmap <Space>e [edit]
xnoremap [edit] <Nop>
xmap <Space>e [edit]
nnoremap [file] <Nop>
nmap <Space>f [file]
nnoremap [operator] <Nop>
nmap <Space><Leader> [operator]
xnoremap [operator] <Nop>
xmap <Space><Leader> [operator]
nnoremap [git] <Nop>
nmap <Leader>g [git]
xnoremap [git] <Nop>
xmap <Leader>g [git]
nnoremap [test] <Nop>
nmap <Leader>t [test]

let g:plugin_dicwin_disable    = 1
let g:loaded_gzip              = 1
let g:loaded_tar               = 1
let g:loaded_tarPlugin         = 1
let g:loaded_zip               = 1
let g:loaded_zipPlugin         = 1
let g:loaded_rrhelper          = 1
let g:loaded_2html_plugin      = 1
let g:loaded_vimball           = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_getscript         = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_spellfile_plugin  = 1
let g:loaded_logiPat           = 1

augroup MyAuGroup
    autocmd!
augroup END

autocmd MyAuGroup BufNewFile,BufRead * set iminsert=0

if has('gui') && has('win32') && !has('nvim')
    autocmd MyAuGroup GUIEnter * simalt ~x
endif

autocmd MyAuGroup BufEnter * call s:auto_cd()
function! s:auto_cd() abort
    try
        execute ':lcd ' . substitute(expand('%:p:h'),' ','\\\\ ','g')
    catch
    endtry
endfunction

autocmd MyAuGroup VimEnter * if @% == '' && s:get_buf_byte() == 0 | setlocal buftype=nofile noswapfile fileformat=unix | endif
function! s:get_buf_byte()
    let byte = line2byte(line('$') + 1)
    return byte == -1 ? 0 : byte - 1
endfunction

function! s:define_highlight() abort
    highlight Search cterm=NONE guifg=#333333 guibg=#a9dd9d
    highlight incSearchOnCursor cterm=NONE guifg=#fffeeb guibg=#fb8965
    highlight Flashy term=bold ctermbg=0 guifg=#333333 guibg=#a8d2eb
    highlight ParenMatch term=underline cterm=underline guibg=#5f8770
    highlight TabLine guifg=#fff5ee guibg=#536273 gui=none
    highlight YankRoundRegion guifg=#333333 guibg=#fedf81
    highlight def link sqlStatement sqlKeyword
    highlight ZenSpace term=underline ctermbg=DarkGreen guibg=#ab6560
    highlight def link uniteExrenameModified Error

    highlight clear SpellCap
    highlight def link SpellCap NONE
    highlight clear SpellBad
    highlight SpellBad guifg=#ff5555
    highlight clear SpellRare
    highlight SpellRare guifg=#ff5555
    highlight clear SpellLocal
    highlight SpellLocal guifg=#ff5555

    highlight myDeniteMatchText cterm=NONE guifg=#f6a3a3 guibg=NONE
    highlight myDeniteInsert cterm=NONE guifg=NONE guibg=#3d5066
    highlight myDeniteNormal cterm=NONE guifg=White guibg=#7b6980

    if has('mac')
        highlight Cursor guibg=#bbbbba
    endif
endfunction

autocmd MyAuGroup ColorScheme * :call s:define_highlight()

autocmd MyAuGroup InsertEnter * :setlocal nocursorline
autocmd MyAuGroup InsertLeave * :setlocal cursorline
autocmd MyAuGroup WinEnter * :setlocal cursorline
autocmd MyAuGroup WinLeave * :setlocal nocursorline

autocmd MyAuGroup BufRead,BufNewFile */roles/*.yml set filetype=yaml.ansible
autocmd MyAuGroup BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible

set guioptions+=M
set guioptions+=c

if has('win32')
    let g:python3_host_prog = 'C:/Python35/python.exe'
elseif has('mac')
    let g:python3_host_prog = '/usr/local/bin/python3'
else
    let g:python3_host_prog = '/usr/bin/python3'
endif

let g:python_highlight_all = 1
let g:markdown_fenced_languages = ['vim']
let g:ft_ignroe_pat = '\.\(Z\|gz\|bz2\|zip\|tgz\|log\)$'

if has('nvim')
    autocmd MyAuGroup FileType python call notomo#python#semshi_highlight()
    autocmd MyAuGroup FileType php execute 'TemplateLoad /filetype/' . &l:filetype
endif

autocmd MyAuGroup OptionSet diff setlocal nocursorline
autocmd MyAuGroup WinEnter,InsertLeave * if &diff == 1 | setlocal nocursorline | endif

call minpac#add('k-takata/minpac', {'type': 'opt'})
nnoremap [exec]U :<C-u>call minpac#update()<CR>

call minpac#add('kana/vim-textobj-user')
call minpac#add('kana/vim-operator-user')

call minpac#add('itchyny/vim-parenmatch')
let g:loaded_matchparen = 1

call minpac#add('itchyny/vim-cursorword')

call minpac#add('kana/vim-submode')
let g:submode_keep_leaving_key = 1
let g:submode_timeout = 0

call minpac#add('thinca/vim-zenspace')
let g:zenspace#default_mode = 'on'

call minpac#add('LeafCage/yankround.vim')
let g:yankround_use_region_hl = 1
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)

call minpac#add('Shougo/neco-vim')
if !exists('g:necovim#complete_functions')
    let g:necovim#complete_functions = {}
endif
let g:necovim#complete_functions.Ref = 'ref#complete'

call minpac#add('Shougo/neosnippet.vim')
xmap <Space>S <Plug>(neosnippet_expand_target)
nnoremap [file]s :<C-u>:NeoSnippetEdit<CR>
imap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)" : "\<TAB>"
let g:neosnippet#snippets_directory = '~/.vim/snippets/'
let g:neosnippet#disable_runtime_snippets = {'_' : 1}

call minpac#add('tpope/vim-repeat')
call minpac#add('osyo-manga/shabadou.vim')
call minpac#add('vim-jp/vital.vim')

call minpac#add('kana/vim-smartword')
nmap w <Plug>(smartword-w)
xmap w <Plug>(smartword-w)
omap w <Plug>(smartword-w)
nmap b <Plug>(smartword-b)
xmap b <Plug>(smartword-b)
omap b <Plug>(smartword-b)
nmap e <Plug>(smartword-e)
xmap e <Plug>(smartword-e)
omap e <Plug>(smartword-e)

call minpac#add('rhysd/vim-color-spring-night')
let g:spring_night_kill_italic = 1
let g:spring_night_high_contrast = 0

call minpac#add('Shougo/vimproc.vim', {'do' : executable('make') ? 'silent! !make' : '' })
let g:vimproc#download_windows_dll = 0

call minpac#add('Shougo/unite.vim')
call minpac#add('Shougo/unite-outline')
nnoremap <silent> [unite]o :<C-u>Unite outline<CR>

call minpac#add('kmnk/vim-unite-giti')
nnoremap <silent> [unite]bb :<C-u>Unite giti/branch<CR>
nnoremap <silent> [unite]ba :<C-u>Unite giti/branch_all<CR>

call minpac#add('Shougo/vimfiler.vim')

call minpac#add('Shougo/neomru.vim')
let g:neomru#file_mru_limit = 1000
if !exists('g:neomru#file_mru_ignore_pattern')
    let g:neomru#file_mru_ignore_pattern = '\%(^\%(gina\)://\)'
endif

call minpac#add('thinca/vim-qfreplace')
nnoremap [exec]Q :<C-u>Qfreplace<CR>

call minpac#add('lambdalisue/gina.vim')

call minpac#add('Shougo/denite.nvim')

call minpac#add('notomo/denite-autocmd')
nnoremap <silent> [denite]a :<C-u>Denite autocmd<CR>

call minpac#add('notomo/denite-runtimepath')
nnoremap <silent> [denite]R :<C-u>Denite runtimepath<CR>

call minpac#add('pocari/vim-denite-emoji')
nnoremap <silent> [denite]e :<C-u>Denite emoji<CR>

call minpac#add('junegunn/vim-emoji')
call minpac#add('itchyny/lightline.vim')

call minpac#add('easymotion/vim-easymotion')
source ~/.vim/rc/plugins/easymotion.vim
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_move_highlight = 1
let g:EasyMotion_landing_highlight = 0
let g:EasyMotion_inc_highlight = 1
let g:EasyMotion_keys = 'asdghklqwertyuopzxcvbnmf;,./0'

call minpac#add('kana/vim-textobj-entire')
omap ae <Plug>(textobj-entire-a)
omap ie <Plug>(textobj-entire-i)
xmap ae <Plug>(textobj-entire-a)
xmap ie <Plug>(textobj-entire-i)

call minpac#add('osyo-manga/vim-textobj-multiblock')
omap aj <Plug>(textobj-multiblock-a)
omap ij <Plug>(textobj-multiblock-i)
xmap aj <Plug>(textobj-multiblock-a)
xmap ij <Plug>(textobj-multiblock-i)
let g:textobj_multiblock_blocks = [
    \ [ '(', ')' ],
    \ [ '[', ']' ],
    \ [ '{', '}' ],
    \ [ '<', '>' ],
    \ [ '"', '"'],
    \ [ "'", "'"],
    \ [ '`', '`', 1],
\ ]

call minpac#add('osyo-manga/vim-operator-blockwise')
nmap [operator]c <Plug>(operator-blockwise-change)
nmap [operator]d <Plug>(operator-blockwise-delete)
nmap [operator]y <Plug>(operator-blockwise-yank)

call minpac#add('osyo-manga/vim-textobj-blockwise')

call minpac#add('kana/vim-textobj-line')
xmap ag <Plug>(textobj-line-a)
xmap ig <Plug>(textobj-line-i)
omap ag <Plug>(textobj-line-a)
omap ig <Plug>(textobj-line-i)

call minpac#add('haya14busa/incsearch.vim')
nmap / <Plug>(incsearch-easymotion-/)\v
xmap / <Plug>(incsearch-easymotion-/)\v
omap / <Plug>(incsearch-easymotion-/)\v
nmap <Space>/k <Plug>(incsearch-easymotion-?)
xmap <Space>/k <Plug>(incsearch-easymotion-?)
omap <Space>/k <Plug>(incsearch-easymotion-?)
nmap <Space>/j <Plug>(incsearch-easymotion-stay)
xmap <Space>/j <Plug>(incsearch-easymotion-stay)
omap <Space>/j <Plug>(incsearch-easymotion-stay)

nmap s/ <Plug>(incsearch-easymotion-/)<C-r><C-w>
nmap sk <Plug>(incsearch-easymotion-?)<C-r><C-w>
nmap sj <Plug>(incsearch-easymotion-stay)<C-r><C-w>
nnoremap <expr> s. incsearch#go({'pattern': histget('/', -1)})
xnoremap <expr> s. incsearch#go({'pattern': histget('/', -1)})
onoremap <expr> s. incsearch#go({'pattern': histget('/', -1)})

nmap s<Space>/ <Plug>(incsearch-easymotion-/)<C-r>"
nmap s<Space>k <Plug>(incsearch-easymotion-?)<C-r>"
nmap s<Space>j <Plug>(incsearch-easymotion-stay)<C-r>"

nmap n <Plug>(incsearch-nohl-n)
xmap n <Plug>(incsearch-nohl-n)
omap n <Plug>(incsearch-nohl-n)
nmap N <Plug>(incsearch-nohl-N)
xmap N <Plug>(incsearch-nohl-N)
omap N <Plug>(incsearch-nohl-N)
nmap n <Plug>(incsearch-nohl)<Plug>(anzu-n-with-echo)
nmap N <Plug>(incsearch-nohl)<Plug>(anzu-N-with-echo)

omap <silent> ra <Plug>(incsearch-forward)\v[[({<"']\zs[^[({<"']{-}%#<CR>
omap <silent> rA <Plug>(incsearch-forward)\v[[({<"']\zs.{-}%#<CR>
let g:incsearch#auto_nohlsearch = 1

call minpac#add('osyo-manga/vim-anzu')

if has('python3')
    call minpac#add('sgur/vim-py3diff')
    set diffexpr=py3diff#diffexpr()
endif

call minpac#add('haya14busa/incsearch-easymotion.vim')

call minpac#add('bkad/CamelCaseMotion')
nmap <Leader>w <Plug>CamelCaseMotion_w
xmap <Leader>w <Plug>CamelCaseMotion_w
omap <Leader>w <Plug>CamelCaseMotion_w
nmap <Leader>b <Plug>CamelCaseMotion_b
xmap <Leader>b <Plug>CamelCaseMotion_b
omap <Leader>b <Plug>CamelCaseMotion_b
nmap <Leader>e <Plug>CamelCaseMotion_e
xmap <Leader>e <Plug>CamelCaseMotion_e
omap <Leader>e <Plug>CamelCaseMotion_e

call minpac#add('kana/vim-operator-replace')
nmap r <Plug>(operator-replace)
xmap r <Plug>(operator-replace)
omap r <Plug>(operator-replace)
onoremap <Plug>(builtin-gn) gn
nnoremap <Plug>(builtin-/) /
nmap [edit]n *``<Plug>(operator-replace)<Plug>(builtin-gn)
xmap <expr> [edit]n "\"ry<Plug>(builtin-/)\\V\<C-r>=notomo#vimrc#escape_search_pattern(@r)\<CR>\<CR>" . "``\"+<Plug>(operator-replace)<Plug>(builtin-gn)"

call minpac#add('osyo-manga/vim-textobj-from_regexp')
omap <expr> pd textobj#from_regexp#mapexpr('\$[a-zA-Z0-9_]\+')
xmap <expr> pd textobj#from_regexp#mapexpr('\$[a-zA-Z0-9_]\+')
omap <expr> py textobj#from_regexp#mapexpr('\$[a-zA-Z0-9_]\+->')
xmap <expr> py textobj#from_regexp#mapexpr('\$[a-zA-Z0-9_]\+->')

omap <expr> iz textobj#from_regexp#mapexpr('\d\{4}-\d\{2}-\d\{2} \d\{2}:\d\{2}:\d\{2}')
xmap <expr> iz textobj#from_regexp#mapexpr('\d\{4}-\d\{2}-\d\{2} \d\{2}:\d\{2}:\d\{2}')

omap <expr> is textobj#from_regexp#mapexpr('_\zs.\{-}\ze_')
xmap <expr> is textobj#from_regexp#mapexpr('_\zs.\{-}\ze_')
omap <expr> as textobj#from_regexp#mapexpr('_.\{-1,}\(_\)\@=')
xmap <expr> as textobj#from_regexp#mapexpr('_.\{-1,}\(_\)\@=')

omap <expr> i, textobj#from_regexp#mapexpr(',\zs.\{-}\ze,')
xmap <expr> i, textobj#from_regexp#mapexpr(',\zs.\{-}\ze,')
omap <expr> a, textobj#from_regexp#mapexpr(',.\{-1,}\(,\)\@=')
xmap <expr> a, textobj#from_regexp#mapexpr(',.\{-1,}\(,\)\@=')

omap <expr> i. textobj#from_regexp#mapexpr('\.\zs.\{-}\ze\.')
xmap <expr> i. textobj#from_regexp#mapexpr('\.\zs.\{-}\ze\.')
omap <expr> a. textobj#from_regexp#mapexpr('\..\{-1,}\(\.\)\@=')
xmap <expr> a. textobj#from_regexp#mapexpr('\..\{-1,}\(\.\)\@=')

omap <expr> ix textobj#from_regexp#mapexpr('\v\*\zs[^*]+\ze\*')
xmap <expr> ix textobj#from_regexp#mapexpr('\v\*\zs[^*]+\ze\*')
omap <expr> ax textobj#from_regexp#mapexpr('\*.\{-1,}\(*\)\@=')
xmap <expr> ax textobj#from_regexp#mapexpr('\*.\{-1,}\(*\)\@=')

omap <expr> i/ textobj#from_regexp#mapexpr('/\zs.\{-}\ze/')
xmap <expr> i/ textobj#from_regexp#mapexpr('/\zs.\{-}\ze/')
omap <expr> a/ textobj#from_regexp#mapexpr('/.\{-1,}\(/\)\@=')
xmap <expr> a/ textobj#from_regexp#mapexpr('/.\{-1,}\(/\)\@=')

omap <expr> pl textobj#from_regexp#mapexpr('\v%#[^])}>"'']*')
omap <expr> pL textobj#from_regexp#mapexpr('\v%#.*\ze[])}>"'']')

call minpac#add('tyru/current-func-info.vim')
call minpac#add('rhysd/vim-operator-surround')
nnoremap [surround] <Nop>
nmap s [surround]
xnoremap [surround] <Nop>
xmap s [surround]
nmap <silent>[surround]a <Plug>(operator-surround-append)
xmap <silent>[surround]a <Plug>(operator-surround-append)
nmap <silent>[surround]d v<Plug>(textobj-multiblock-a)<Plug>(operator-surround-delete)
xmap <silent>[surround]d <Plug>(operator-surround-delete)
nmap <silent>[surround]r v<Plug>(textobj-multiblock-a)<Plug>(operator-surround-replace)
xmap <silent>[surround]r <Plug>(operator-surround-replace)
source ~/.vim/rc/plugins/operator-surround.vim

call minpac#add('thinca/vim-quickrun')
nnoremap <silent> <Leader>Q :<C-u>call notomo#quickrun#execute()<CR>
xnoremap <silent> <Leader>Q :QuickRun -mode v<CR>
source ~/.vim/rc/plugins/quickrun.vim

call minpac#add('tyru/caw.vim')
nmap <Space>c <Plug>(caw:hatpos:toggle:operator)_
xmap <Space>c <Plug>(caw:hatpos:toggle:operator)
nmap <Space><Space>c <Plug>(caw:wrap:toggle:operator)_
xmap <Space><Space>c <Plug>(caw:wrap:toggle:operator)
let g:caw_no_default_keymappings = 1

call minpac#add('thinca/vim-ref')
nmap [keyword]r <Plug>(ref-keyword)
nnoremap <expr> [keyword]R ":<C-u>Ref webdict " . expand("<cword>") . "<CR>"
nnoremap <expr> [keyword]<C-r> ":<C-u>Ref webdict english " . expand("<cword>") . "<CR>"
let g:ref_open = 'vsplit'
let g:ref_use_vimproc = 1
let g:ref_phpmanual_path = expand('~/.vim/reference/phpmanual')
let g:ref_pydoc_cmd = 'python3 -m pydoc'
let g:ref_source_webdict_sites = {
    \ 'english': {
        \ 'url': 'http://dictionary.infoseek.ne.jp/jeword/%s',
    \ },
    \ 'japanese': {
        \ 'url': 'http://dictionary.infoseek.ne.jp/ejword/%s',
    \ },
\ }
let g:ref_source_webdict_sites.default = 'japanese'

call minpac#add('Shougo/neoinclude.vim')

call minpac#add('haya14busa/vim-operator-flashy')
nmap y <Plug>(operator-flashy)
xmap y <Plug>(operator-flashy)
omap y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$
let g:operator#flashy#flash_time = 100

call minpac#add('t9md/vim-choosewin')
nmap m<Space> <Plug>(choosewin)
let g:choosewin_overlay_enable = 1
let g:choosewin_overlay_clear_multibyte = 1
let g:choosewin_tabline_replace = 0

let g:choosewin_color_overlay = {
      \ 'gui': ['DodgerBlue3', 'DodgerBlue3' ],
      \ 'cterm': [ 25, 25 ]
      \ }
let g:choosewin_color_overlay_current = {
      \ 'gui': ['firebrick1', 'firebrick1' ],
      \ 'cterm': [ 124, 124 ]
      \ }

let g:choosewin_label = 'ASKLWEZXCPIHFRTYUVNMQGODB'
let g:choosewin_blink_on_land      = 0
let g:choosewin_statusline_replace = 0

call minpac#add('kana/vim-textobj-function')
omap af <Plug>(textobj-function-a)
omap if <Plug>(textobj-function-i)
xmap af <Plug>(textobj-function-a)
xmap if <Plug>(textobj-function-i)
let g:textobj_function_no_default_key_mappings = 1

call minpac#add('notomo/vim-better-tag-jump')

call minpac#add('osyo-manga/vim-jplus')
nmap [edit]j <Plug>(jplus)
xmap [edit]j <Plug>(jplus)
nmap [edit]J <Plug>(jplus-input)
xmap [edit]J <Plug>(jplus-input)

call minpac#add('haya14busa/vim-edgemotion')
nmap gJ <Plug>(edgemotion-j)
xmap gJ <Plug>(edgemotion-j)
omap gJ <Plug>(edgemotion-j)
nmap gK <Plug>(edgemotion-k)
xmap gK <Plug>(edgemotion-k)
omap gK <Plug>(edgemotion-k)

call minpac#add('cocopon/colorswatch.vim')
nnoremap [exec]co :<C-u>ColorSwatchGenerate<CR>

call minpac#add('rhysd/clever-f.vim')
let g:clever_f_across_no_line = 1
let g:clever_f_mark_char = 0
let g:clever_f_not_overwrites_standard_mappings = 1
let g:clever_f_chars_match_any_signs = ';'
let g:clever_f_ignore_case = 1
nmap f <Plug>(clever-f-f)
xmap f <Plug>(clever-f-f)
omap f <Plug>(clever-f-f)
nmap F <Plug>(clever-f-F)
xmap F <Plug>(clever-f-F)
omap F <Plug>(clever-f-F)

if has('gui') && !has('nvim')
    call minpac#add('thinca/vim-fontzoom')
    nmap <C-Up> <Plug>(fontzoom-larger)
    nmap <C-Down> <Plug>(fontzoom-smaller)
    nnoremap <M-Up> :<C-u>Fontzoom!<CR>
    nnoremap <M-Down> :<C-u>Fontzoom!<CR>
endif

call minpac#add('tyru/open-browser.vim')
nnoremap [browser] <Nop>
nmap [exec]b [browser]
xnoremap [browser] <Nop>
xmap [exec]b [browser]

nmap [browser]s <Plug>(openbrowser-search)
xmap [browser]s <Plug>(openbrowser-search)
nnoremap [browser]o :<C-u>call _open_browser(expand('<cWORD>'))<CR>
nnoremap [browser]i :<C-u>OpenBrowserSearch<Space>

if executable('lemonade') && has('mac') && !empty($SSH_CLIENT)
    let g:openbrowser_browser_commands = [
    \ {'name': 'lemonade',
    \  'args': 'lemonade open {uri}'}
    \ ]
endif

call minpac#add('mhinz/vim-signify')
nmap [git]j <Plug>(signify-next-hunk)zz
nmap [git]k <Plug>(signify-prev-hunk)zz
nnoremap [git]t :<C-u>SignifyToggle<CR>
let g:signify_disable_by_default = 0

call minpac#add('cespare/vim-toml')

call minpac#add('lambdalisue/session.vim')
nnoremap [file]<Space> :<C-u>call notomo#vimrc#save_session()<CR>
nnoremap [file]<CR> :<C-u>SessionOpen<CR>
nnoremap [denite]S :<C-u>Denite session<CR>
