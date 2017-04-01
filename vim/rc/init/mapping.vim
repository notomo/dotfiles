scriptencoding utf-8

" basic"{{{

" delete a character using delete register
nnoremap x "_x
vnoremap x "_x

" change using delete register
nnoremap c "_c

" repeat an ex command
nnoremap <Space>. @:
vnoremap <Space>. @:

" redo
nnoremap <Leader>r <C-r>

noremap <Leader>t t

" open commandline window
nnoremap Q q:

"}}}

" edit"{{{
nnoremap <silent> <Leader>x :<C-u>call tmno3#vimrc#exchange()<CR>
nnoremap [edit]r r
vnoremap [edit]r r
nnoremap [edit]h gU
nnoremap [edit]l gu
vnoremap [edit]h gU
vnoremap [edit]l gu
nnoremap [edit]m i<C-@>
nnoremap [edit]j :<C-u>join<CR>
nnoremap [edit]J :<C-u>join!<CR>
vnoremap [edit]j :join<CR>
vnoremap [edit]J :join!<CR>

nnoremap [edit]d *``"_cgn
nnoremap [edit]a *``cgn<C-r>"
vnoremap <expr> [edit]d "y/\\V\<C-r>=substitute(escape(@\", '/\'), '\\n', '\\\\n', 'g')\<CR>\<CR>" . '``cgn'
"}}}

" kana"{{{
nnoremap い i
nnoremap あ a
nnoremap <silent> ｊ :<C-u>set iminsert=0<CR>
"}}}

" file"{{{
nnoremap [file]w :<C-u>write<CR>
nnoremap [file]o :<C-u>edit<Space>
nnoremap [file]rn :<C-u>file<Space>
nnoremap [file]rl :<C-u>e!<CR>
nnoremap [file]v :<C-u>edit $MYVIMRC<CR>
"}}}

" buffer"{{{
nnoremap [buf] <Nop>
nmap <Space>b [buf]
nnoremap [buf]a <C-^>
nnoremap <silent> [buf]n :<C-u>enew \| setlocal buftype=nofile noswapfile fileformat=unix<CR>
nnoremap [buf]Q :<C-u>qa<CR>
nnoremap [buf]O :<C-u>call <SID>open_not_saved_bufs()<CR>

function! s:open_not_saved_buf() abort
    let curbuf_num = bufnr('%')
    if getbufvar(curbuf_num, '&modified')
        tabe expand('%')
    endif
endfunction
function! s:open_not_saved_bufs() abort
    tabe | setlocal buftype=nofile noswapfile | tabonly
    bufdo call s:open_not_saved_buf()
    if tabpagenr('$') > 1
        tabclose | tabl
    endif
endfunction
"}}}

" swap :;"{{{
nnoremap ;  :
nnoremap :  ;
vnoremap ;  :
vnoremap :  ;
"}}}

" visual mode"{{{
nnoremap <Space>h <C-v>
nnoremap <Space>l <S-v>
nnoremap <Space>v gv
nnoremap <Space>p :<C-u>call <SID>select_paste_region()<CR>
vnoremap <Space>h <C-v>
vnoremap <Space>l <S-v>
vnoremap <Space>v v
vnoremap v <ESC>

" depends yankround
function! s:select_paste_region() abort
    call setpos("'<", [0, line("'["), col("'[")])
    call setpos("'>", [0, line("']"), col("']")])
    normal! gv
endfunction
"}}}

" select mode"{{{
snoremap <CR> <DEL>
"}}}

" grep"{{{
nnoremap <Space>Gd :<C-u>vimgrep //j *<Left><Left><Left><Left>
nnoremap <Space>Gr :<C-u>grep! '' *<Left><Left><Left>
nnoremap <Space>Gt :<C-u>cexpr ''<CR>:tabdo vimgrepadd //j %<Left><Left><Left><Left>
nnoremap <Space>Gb :<C-u>cexpr ''<CR>:bufdo vimgrepadd //j %<Left><Left><Left><Left>
"}}}

" ESC"{{{
inoremap <silent> jj <ESC>
inoremap <silent> っｊ <ESC>
inoremap <silent> ｊｊ <ESC>
cnoremap <silent> jj <C-c>
onoremap jj <ESC>
snoremap jj <ESC>
"}}}

" indent"{{{
nnoremap [indent] <Nop>
nmap z [indent]
vnoremap [indent] <Nop>
vmap z [indent]

function! s:convert_indent_style(to_hard, is_visual) abort
    let tmp_expandtab = &expandtab
    let expandtab_cmd = a:to_hard == 1 ? 'noexpandtab' : 'expandtab'
    execute 'setlocal ' . expandtab_cmd
    let range_str = a:is_visual == 1 ? "'<,'>" : '.'
    execute range_str . 'retab!'
    let &expandtab = tmp_expandtab
endfunction

nnoremap [indent]l >>
nnoremap [indent]h <<
nnoremap [indent]t :<C-u>call <SID>convert_indent_style(1, 0)<CR>
nnoremap [indent]<Space> :<C-u>call <SID>convert_indent_style(0, 0)<CR>
nnoremap [indent]o ==
nnoremap [indent]a :<C-u>left<CR>

vnoremap [indent]l >gv
vnoremap [indent]h <gv
vnoremap [indent]t :<C-u>call <SID>convert_indent_style(1, 1)<CR>
vnoremap [indent]<Space> :<C-u>call <SID>convert_indent_style(0, 1)<CR>
vnoremap [indent]o =
vnoremap [indent]a :left<CR>gv
"}}}

" move"{{{
nnoremap k   gk
nnoremap j   gj
vnoremap k   gk
vnoremap j   gj

noremap ge $
noremap ga ^
noremap gh 0
noremap gz G

nnoremap go <C-o>
nnoremap gi <C-i>

nnoremap gO g;
nnoremap gI g,

vnoremap <S-j> }
vnoremap <S-k> {
" remap for matchit
vmap <S-l> %
nnoremap <silent> <S-l> :<C-u>keepjumps normal %<CR>

nnoremap <silent> <S-j> :<C-u>keepjumps normal! }<CR>
nnoremap <silent> <S-k> :<C-u>keepjumps normal! {<CR>

nnoremap <C-k> <C-b>
nnoremap <C-j> <C-f>

nnoremap <C-e> gi
"}}}

" newline"{{{
nnoremap [newline] <Nop>
nmap o [newline]
nnoremap <silent> [newline]o :<C-u>for i in range(v:count1) \| call append(line('.'), '') \| endfor<CR>
nnoremap <silent> [newline]j :<C-u>for i in range(v:count1) \| call append(line('.'), '') \| execute 'normal! j' \| endfor<CR>
nnoremap <silent> [newline]k :<C-u>for i in range(v:count1) \| call append(line('.') - 1, '') \| endfor<CR>
nnoremap [newline]d o
nnoremap [newline]u O
"}}}

" option"{{{
nnoremap [option] <Nop>
nmap <Space>o [option]

nnoremap [option]u :<C-u>set fileencoding=utf8<CR>
nnoremap [option]e :<C-u>set fileencoding=euc-jp<CR>
nnoremap [option]s :<C-u>set fileencoding=shift_jis<CR>
nnoremap [option]fd :<C-u>set fileformat=dos<CR>
nnoremap [option]fm :<C-u>set fileformat=mac<CR>
nnoremap [option]fu :<C-u>set fileformat=unix<CR>

function! s:toggle_filetype() abort
    if execute('filetype') =~# 'OFF'
        silent! filetype plugin indent on
        syntax enable
    else
        filetype plugin indent off
        syntax off
        filetype off
    endif
endfunction
nnoremap [option]F :<C-u>call <SID>toggle_filetype()<CR>

"}}}

" keyword"{{{
function! s:tab_tag_open() abort
    try
        call bettertagjump#php#Jump()
        noautocmd tab split
        noautocmd tabprevious
        noautocmd execute "normal! \<C-o>"
        noautocmd tabnext
    catch
        echo 'Not found tag'
    endtry
endfunction
nnoremap [keyword]t :<C-u>call <SID>tab_tag_open()<CR>

function! s:vertical_tag_open() abort
    try
        let curbuf_num = bufnr('%')
        call bettertagjump#php#Jump()
        let tagbuf_num = bufnr('%')
        noautocmd execute 'buffer ' . curbuf_num
        vsplit
        noautocmd execute 'buffer ' . tagbuf_num
    catch
        echo 'Not found tag'
    endtry
endfunction
function! s:horizontal_tag_open() abort
    try
        let curbuf_num = bufnr('%')
        call bettertagjump#php#Jump()
        let tagbuf_num = bufnr('%')
        noautocmd execute 'buffer ' . curbuf_num
        split
        noautocmd execute 'buffer ' . tagbuf_num
    catch
        echo 'Not found tag'
    endtry
endfunction
function! s:tag_open() abort
    try
        call bettertagjump#php#Jump()
    catch
        echo 'Not found tag'
    endtry
endfunction
nnoremap [keyword]v :<C-u>call <SID>vertical_tag_open()<CR>
nnoremap [keyword]o :<C-u>call <SID>tag_open()<CR>
nnoremap [keyword]h :<C-u>call <SID>horizontal_tag_open()<CR>
"}}}

" Nop"{{{
nnoremap <F1> <Nop>
vnoremap q <Nop>
vnoremap ZQ <Nop>
vnoremap ZZ <Nop>

nnoremap <Ins> <Nop>
inoremap <Ins> <Nop>

nnoremap <RightMouse> p
vnoremap <RightMouse> <ESC>p
inoremap <RightMouse> <C-r>"

inoremap <BS> <Nop>

noremap <MiddleMouse> <Nop>
inoremap <MiddleMouse> <Nop>
noremap <2-MiddleMouse> <Nop>
inoremap <2-MiddleMouse> <Nop>
noremap <3-MiddleMouse> <Nop>
inoremap <3-MiddleMouse> <Nop>
noremap <4-MiddleMouse> <Nop>
inoremap <4-MiddleMouse> <Nop>
"}}}

" others"{{{
function! s:open_work_text() abort
    let l:work_text_file_path =  '~/worktexts/' . strftime('%Y_%m_%d.txt')
    execute 'tab drop ' . l:work_text_file_path
    execute 'set filetype=worktext'
endfunction
nnoremap <Space>ew :<C-u>call <SID>open_work_text()<CR>
"}}}

" substitute"{{{
nnoremap [substitute] <Nop>
nmap <Space>s [substitute]
vnoremap [substitute] <Nop>
vmap <Space>s [substitute]

nnoremap [substitute]f  :<C-u>%s/\v//g<Left><Left><Left>
vnoremap [substitute]f  :s/\v%V%V//g<Left><Left><Left><Left><Left>
nnoremap [substitute]iw :<C-u>%s/\v//g<Left><Left><Left><C-r><C-w><Right>
nnoremap [substitute]w :<C-u>%s/\v//g<Left><Left><Left><C-r><C-w><Right><C-r><C-w>
nnoremap [substitute]iv <Right>byegv:<C-u>'<,'>s/\v%V%V//g<Left><Left><Left><Left><Left><C-r>"<Right><Right><Right>
nnoremap [substitute]v <Right>byegv:<C-u>'<,'>s/\v%V%V//g<Left><Left><Left><Left><Left><C-r>"<Right><Right><Right><C-r>"
nnoremap [substitute]iy  :<C-u>%s/\v//g<Left><Left><Left><C-r>"<Right>
nnoremap [substitute]y  :<C-u>%s/\v//g<Left><Left><Left><C-r>"<Right><C-r>"
vnoremap [substitute]iy  :<C-u>'<,'>s/\v//g<Left><Left><Left><C-r>"<Right>
vnoremap [substitute]y  :<C-u>'<,'>s/\v//g<Left><Left><Left><C-r>"<Right><C-r>"<Right>
nnoremap [substitute]c  :<C-u>%s/\C\v//g<Left><Left><Left>
vnoremap [substitute]c  :<C-u>'<,'>s/\C\v//g<Left><Left><Left>
nnoremap [substitute]d  :<C-u>%s/\v$//g<Left><Left>
vnoremap [substitute]d  :<C-u>'<,'>s/\v$//g<Left><Left>

nnoremap [substitute]e :<C-u>v//d<Left><Left>
vnoremap [substitute]e :v//d<Left><Left>
nnoremap [substitute]i :<C-u>g//d<Left><Left>
vnoremap [substitute]i :g//d<Left><Left>
"}}}

" replace"{{{
nnoremap [replace] <Nop>
nmap <Space>r [replace]
vnoremap [replace] <Nop>
vmap <Space>r [replace]

function! s:nvnoremap_replace(lhs, pattern, str) abort
    let pattern = substitute(a:pattern, '\', '\\\\', 'g')
    let str = substitute(a:str, '\', '\\\\', 'g')
    let substitute_str = 's/\\v' . pattern . '/' . str . '/ge\\|noh'
    let v_substitute_str = "'<,'>" . 's/\\v%V' . pattern . '%V/' . str . '/g'
    silent execute join(['nnoremap', '<silent>', '[replace]' . a:lhs, 'q::s@^@' . substitute_str . '@g<CR><CR>'])
    silent execute join(['vnoremap', '<silent>', '[replace]' . a:lhs, 'q::s@^.*$@' . v_substitute_str . '@g<CR><CR>'])
endfunction

let s:LHS_KEY = 'l'
let s:PATTERN_KEY = 'p'
let s:STR_KEY = 's'
let s:replace_map_info = [
\   {s:LHS_KEY : 'co', s:PATTERN_KEY : '\S{-1,}\zs,\ze\S{-1,}', s:STR_KEY : ', '},
\   {s:LHS_KEY : 'e', s:PATTERN_KEY : '\S{-1,}\zs(\=\| \=\|\= )\ze\S{-1,}', s:STR_KEY : ' = '},
\   {s:LHS_KEY : 'd', s:PATTERN_KEY : '\S{-1,}\zs(\.\| \.\|\. )\ze\S{-1,}', s:STR_KEY : ' . '},
\   {s:LHS_KEY : 'l', s:PATTERN_KEY : '\S{-1,}\zs(:\| :\|: )\ze\S{-1,}', s:STR_KEY : ' : '},
\   {s:LHS_KEY : 'n', s:PATTERN_KEY : '^\n', s:STR_KEY : ''},
\   {s:LHS_KEY : 'y', s:PATTERN_KEY : '\\', s:STR_KEY : '\/'},
\   {s:LHS_KEY : 'Y', s:PATTERN_KEY : '\/', s:STR_KEY : '\\'},
\   {s:LHS_KEY : '<Space>e', s:PATTERN_KEY : ' +$', s:STR_KEY : ''},
\   {s:LHS_KEY : 'mc', s:PATTERN_KEY : '\_.*\ze\n', s:STR_KEY : "\\=join(split(submatch(0), \"\\n\"), \",\")"},
\   {s:LHS_KEY : 'mt', s:PATTERN_KEY : '\_.*\ze\n', s:STR_KEY : "\\=join(split(submatch(0), \"\\n\"), \"\\t\")"},
\   {s:LHS_KEY : '<Space>b', s:PATTERN_KEY : '\S{-1,}\zs {2,}\ze\S{-1,}', s:STR_KEY : ' '},
\   {s:LHS_KEY : 'cm', s:PATTERN_KEY : ',', s:STR_KEY : '\r'},
\   {s:LHS_KEY : 'tm', s:PATTERN_KEY : '\t', s:STR_KEY : '\r'},
\   {s:LHS_KEY : '<Space>m', s:PATTERN_KEY : '\s+', s:STR_KEY : '\r'},
\   {s:LHS_KEY : 'qw', s:PATTERN_KEY : "'", s:STR_KEY : '"'},
\   {s:LHS_KEY : 'wq', s:PATTERN_KEY : '"', s:STR_KEY : "'"},
\   {s:LHS_KEY : 'cc', s:PATTERN_KEY : '_(.)', s:STR_KEY : '\u\1'},
\   {s:LHS_KEY : 'ch', s:PATTERN_KEY : '([A-Z])', s:STR_KEY : '_\l\1'},
\   {s:LHS_KEY : 'ct', s:PATTERN_KEY : ',', s:STR_KEY : '\t'},
\   {s:LHS_KEY : 'tc', s:PATTERN_KEY : '\t', s:STR_KEY : ','},
\   {s:LHS_KEY : '<Space>a', s:PATTERN_KEY : '^\s+', s:STR_KEY : ''},
\   {s:LHS_KEY : 'x', s:PATTERN_KEY : '%#(\_.)(\_.)', s:STR_KEY : '\2\1'},
\   {s:LHS_KEY : 'p', s:PATTERN_KEY : '(.*)\zs', s:STR_KEY : '\r\1'},
\]

if exists('g:replace_map_info')
    let s:replace_map_info += g:replace_map_info
    unlet g:replace_map_info
endif

for s:info in s:replace_map_info
    call s:nvnoremap_replace(s:info[s:LHS_KEY], s:info[s:PATTERN_KEY], s:info[s:STR_KEY])
endfor
"}}}

" yank"{{{
nnoremap [yank] <Nop>
nmap <Space>y [yank]

function! s:yank_date(delimiter) abort
    let delimiter = a:delimiter ==? '' ? '_' : a:delimiter
    call s:yank_value(strftime(join(split('%Y_%m_%d','_'),a:delimiter)))
endfunction
nnoremap <silent> [yank]d :<C-u>call <SID>yank_date('/')<CR>
nnoremap <silent> [yank]n :<C-u>call <SID>yank_value(expand('%'))<CR>
nnoremap <silent> [yank]p :<C-u>call <SID>yank_value(substitute(substitute(expand('%:p'), substitute(expand('$HOME'), '\\', '\\\\', 'g'), '~', ''), '\', '/', 'g'))<CR>
nnoremap <silent> [yank]P :<C-u>call <SID>yank_value(substitute(expand('%:p'), '\', '/', 'g'))<CR>
nnoremap <silent> [yank]; :<C-u>call <SID>yank_value(@:)<CR>
nnoremap <silent> [yank]/ :<C-u>call <SID>yank_value(@/)<CR>
nnoremap <silent> [yank]i :<C-u>call <SID>yank_value(@.)<CR>
nnoremap <silent> [yank]f :<C-u>call <SID>yank_value(cfi#format('%s', ''))<CR>
function! s:yank_value(value) abort
    let [@", @+, @0, @*] = [a:value, a:value, a:value, a:value]
    echomsg 'yank '. a:value
endfunction
"}}}

" inner and around vomapping"{{{
function! s:ia_vonoremap(lhs, rhs) abort
    let inner_lhs = 'i' . a:lhs
    let inner_rhs = 'i' . a:rhs
    let around_lhs = 'a' . a:lhs
    let around_rhs = 'a' . a:rhs
    silent execute join(['vnoremap', inner_lhs, inner_rhs])
    silent execute join(['onoremap', inner_lhs, inner_rhs])
    silent execute join(['vnoremap', around_lhs, around_rhs])
    silent execute join(['onoremap', around_lhs, around_rhs])
endfunction
call s:ia_vonoremap(';', 'B')
call s:ia_vonoremap('o', 'p')
call s:ia_vonoremap('<CR>', 'w')
call s:ia_vonoremap('<Space>', 'W')
call s:ia_vonoremap('t', '>')
call s:ia_vonoremap('T', 't')
call s:ia_vonoremap('p', ')')
call s:ia_vonoremap('l', ']')
call s:ia_vonoremap('w', '"')
call s:ia_vonoremap('q', "'")
call s:ia_vonoremap('d', '}')
call s:ia_vonoremap('b', '`')
"}}}

" fold"{{{
noremap [fold] <Nop>
map <Leader>z [fold]
noremap [fold]j zj
noremap [fold]k zk
noremap [fold]n ]z
noremap [fold]p [z
noremap [fold]h zc
noremap [fold]l zo
noremap [fold]a za
noremap [fold]m zM
noremap [fold]i zMzv
noremap [fold]r zR
noremap [fold]f zf
noremap [fold]d zd
noremap zD <Nop>
"}}}

" command and insert"{{{

" 移動
noremap! <C-h> <Left>
noremap! <C-j> <Down>
noremap! <C-k> <Up>
noremap! <C-l> <Right>
noremap! <C-e> <End>
inoremap <C-a> <C-o>^
cnoremap <C-a> <Home>

" 編集
noremap! <C-b> <BS>
noremap! <C-d> <Del>
inoremap <C-o> <C-o>o

" インデント
inoremap <S-TAB> <C-d>

" 電卓
inoremap j<Space><CR> <C-r>=

" カーソル位置の単語を大文字に変換
inoremap j<Space><Space> <ESC>gUiwea

" 前に入力した文字を入力
inoremap j<Space>z <C-a>

function! s:cinoremap_with_prefix(lhs_pfx, lhs_sfx, rhs) abort
    silent execute join(['inoremap', a:lhs_pfx . a:lhs_sfx, substitute(a:rhs, '\ze<Left>$', '<C-g>U', '')])
    silent execute join(['cnoremap', a:lhs_pfx . a:lhs_sfx, a:rhs])
endfunction
let s:MAIN_INPUT_PFX = 'j<Space>'
let s:SUB_INPUT_PFX = 'jk'

let s:LHS_PFX_KEY = 'l'
let s:RHS_KEY = 'r'
let s:main_cinoremap_info = [
            \ {s:LHS_PFX_KEY : 'a', s:RHS_KEY : '-'},
            \ {s:LHS_PFX_KEY : 'e', s:RHS_KEY : '='},
            \ {s:LHS_PFX_KEY : 's', s:RHS_KEY : '_'},
            \ {s:LHS_PFX_KEY : 'r', s:RHS_KEY : '<Bar>'},
            \ {s:LHS_PFX_KEY : 'g', s:RHS_KEY : '\'},
            \ {s:LHS_PFX_KEY : 'w', s:RHS_KEY : '""<Left>'},
            \ {s:LHS_PFX_KEY : 'b', s:RHS_KEY : '``<Left>'},
            \ {s:LHS_PFX_KEY : 'l', s:RHS_KEY : '[]<Left>'},
            \ {s:LHS_PFX_KEY : 't', s:RHS_KEY : '<><Left>'},
            \ {s:LHS_PFX_KEY : 'p', s:RHS_KEY : '()<Left>'},
            \ {s:LHS_PFX_KEY : 'd', s:RHS_KEY : '{}<Left>'},
            \ {s:LHS_PFX_KEY : 'q', s:RHS_KEY : "''<Left>"},
            \ {s:LHS_PFX_KEY : 'h', s:RHS_KEY : '<C-r>"'},
            \ {s:LHS_PFX_KEY : 'v', s:RHS_KEY : '<C-q>'},
            \ {s:LHS_PFX_KEY : 'T', s:RHS_KEY : '<C-x><C-]>'},
            \ {s:LHS_PFX_KEY : 'o', s:RHS_KEY : '<C-y>'},
            \ {s:LHS_PFX_KEY : 'j', s:RHS_KEY : '<C-e><CR>'},
            \]
for s:info in s:main_cinoremap_info
    call s:cinoremap_with_prefix(s:MAIN_INPUT_PFX, s:info[s:LHS_PFX_KEY], s:info[s:RHS_KEY])
endfor

let s:sub_cinoremap_info = [
            \ {s:LHS_PFX_KEY : 'a', s:RHS_KEY : '&'},
            \ {s:LHS_PFX_KEY : 'h', s:RHS_KEY : '^'},
            \ {s:LHS_PFX_KEY : 'p', s:RHS_KEY : '+'},
            \ {s:LHS_PFX_KEY : 's', s:RHS_KEY : '#'},
            \ {s:LHS_PFX_KEY : 'r', s:RHS_KEY : '%'},
            \ {s:LHS_PFX_KEY : 'm', s:RHS_KEY : '@'},
            \ {s:LHS_PFX_KEY : 't', s:RHS_KEY : '~'},
            \ {s:LHS_PFX_KEY : 'd', s:RHS_KEY : '$'},
            \ {s:LHS_PFX_KEY : 'e', s:RHS_KEY : '!'},
            \ {s:LHS_PFX_KEY : 'b', s:RHS_KEY : '`'},
            \ {s:LHS_PFX_KEY : 'c', s:RHS_KEY : ':'},
            \ {s:LHS_PFX_KEY : 'x', s:RHS_KEY : '*'},
            \ {s:LHS_PFX_KEY : 'q', s:RHS_KEY : '?'},
            \ {s:LHS_PFX_KEY : ';', s:RHS_KEY : '"'},
            \ {s:LHS_PFX_KEY : ',', s:RHS_KEY : "'"},
            \ {s:LHS_PFX_KEY : 'g', s:RHS_KEY : '=>'},
            \ {s:LHS_PFX_KEY : 'f', s:RHS_KEY : '->'},
            \]
for s:info in s:sub_cinoremap_info
    call s:cinoremap_with_prefix(s:SUB_INPUT_PFX, s:info[s:LHS_PFX_KEY], s:info[s:RHS_KEY])
endfor

let s:pairs = [
\ ['(', ')'],
\ ['{', '}'],
\ ['[', ']'],
\ ['<', '>'],
\]

function! s:complete_pair() abort
    let chars = strcharpart(getline('.'), col('.') - 2, 2)
    for [l, r] in s:pairs
        if chars ==? l
            return r . "\<C-g>U\<Left>"
        endif
    endfor
    return ''
endfunction
inoremap <expr> j<Space>k <SID>complete_pair()

"}}}

" macro"{{{
nnoremap [macro] <Nop>
nmap q [macro]
nnoremap [macro]r qa
nnoremap [macro]q q
nnoremap [macro]s @a
nnoremap [macro]d qaq
"}}}

" diff"{{{
function! s:diff_tab_open(...)
    if a:0 == 1
        tabedit %:p
        execute 'rightbelow vertical diffsplit ' . a:1
    else
        execute 'tabedit ' . a:1
        for l:file in a:000[1:]
            execute 'rightbelow vertical diffsplit ' . l:file
        endfor
    endif
endfunction
command! -nargs=+ -complete=file MyDiff call <SID>diff_tab_open(<f-args>)
nnoremap [diff]i :<C-u>MyDiff<Space>
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
nnoremap [diff]o :<C-u>DiffOrig<CR>

nnoremap [diff]j ]c
nnoremap [diff]k [c
nnoremap [diff]g :<C-u>diffget<CR>
nnoremap [diff]p :<C-u>diffput<CR>
nnoremap [diff]q :<C-u>diffoff!<CR>
vnoremap [diff]j ]c
vnoremap [diff]k [c
vnoremap [diff]g :diffget<CR>
vnoremap [diff]p :diffput<CR>
"}}}

" mark"{{{
nnoremap [mark] <Nop>
vnoremap [mark] <Nop>
nmap <Leader>m [mark]
vmap <Leader>m [mark]

nnoremap [mark]s :<C-u>call tmno3#mark#set()<CR>

nnoremap <expr> <silent> [mark]x tmno3#mark#to_next()
vnoremap <expr> <silent> [mark]x tmno3#mark#to_next()

nnoremap <expr> <silent> [mark]r tmno3#mark#to_previous()
vnoremap <expr> <silent> [mark]r tmno3#mark#to_previous()

nnoremap <silent> [mark]d :<C-u>call tmno3#mark#delete_all()<CR>

" go to specific mark
nnoremap [mark]g '
vnoremap [mark]g '
"}}}

" arithmatic"{{{
nnoremap [arith] <Nop>
vnoremap [arith] <Nop>
nmap <Space>a [arith]
vmap <Space>a [arith]

nnoremap [arith]j <C-x>
nnoremap [arith]k <C-a>
vnoremap [arith]j <C-x>gv
vnoremap [arith]k <C-a>gv
vnoremap [arith]d g<C-x>gv
vnoremap [arith]u g<C-a>gv
"}}}

" exec"{{{
nnoremap <silent> [exec]n :<C-u>nohlsearch<CR>
nnoremap <silent> [exec]u :<C-u>sort nu<CR>
nnoremap <silent> [exec]U :<C-u>sort! nu<CR>
nnoremap [exec]s :<C-u>if &filetype ==? 'vim' \| source % \| endif<CR>
nnoremap <expr> [exec]l ':' . getline('.') . '<CR>'
nnoremap <silent> [exec]r :<C-u>source $MYVIMRC<CR>:source $MYGVIMRC<CR>:nohlsearch<CR>
nnoremap [exec]e :<C-u>smile<CR>
"}}}

function! s:goto_func() abort
    let func_name = cfi#format('%s', '')
    if func_name ==? ''
        echomsg 'No function'
        return
    endif
    execute "normal! m'"
    call search('\v^\s*(\S{-1,}\s+)*function\s+' . func_name . '\(.*\)', 'b')
endfunction
nnoremap <silent> <Leader>sk :<C-u>call <SID>goto_func()<CR>

nnoremap [operator]x "_d
vnoremap [operator]x "_d

" quickfix and locationlist"{{{
nnoremap [qf] <Nop>
nmap <Space>q [qf]

nnoremap [qf]o :<C-u>call tmno3#qf#open()<CR>
nnoremap [qf]c :<C-u>call tmno3#qf#close()<CR>
nnoremap [qf]f :<C-u>call tmno3#qf#first()<CR>
nnoremap [qf]l :<C-u>call tmno3#qf#last()<CR>
nnoremap [qf]n :<C-u>call tmno3#qf#next()<CR>
nnoremap [qf]p :<C-u>call tmno3#qf#previous()<CR>
nnoremap [qf]d :<C-u>call tmno3#qf#delete()<CR>
nnoremap [qf]u :<C-u>call tmno3#qf#undo()<CR>
nnoremap [qf]<CR> :<C-u>call tmno3#qf#current_open()<CR>
nnoremap [qf]<Space> :<C-u>call tmno3#qf#preview()<CR>
"}}}

