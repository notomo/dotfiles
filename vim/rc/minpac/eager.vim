
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

if has('nvim')
    autocmd MyAuGroup FileType python call notomo#python#semshi_highlight()
    autocmd MyAuGroup FileType php execute 'TemplateLoad /filetype/' . &l:filetype
endif

autocmd MyAuGroup OptionSet diff setlocal nocursorline
autocmd MyAuGroup WinEnter,InsertLeave * if &diff == 1 | setlocal nocursorline | endif


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
