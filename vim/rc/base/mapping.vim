scriptencoding utf-8

let s:LHS_KEY = notomo#mapping#get_lhs_key()
let s:RHS_KEY = notomo#mapping#get_rhs_key()

" basic"{{{

" delete a character using delete register
nnoremap x "_x
xnoremap x "_x

nnoremap [operator]x "_d
xnoremap [operator]x "_d

" change using delete register
nnoremap c "_c
xnoremap c "_c

" repeat an ex command
nnoremap <Space>. @:
xnoremap <Space>. @:

" redo
nnoremap <Leader>r <C-r>

" open commandline window
nnoremap Q q:

"}}}

" edit"{{{
nnoremap <silent> <Leader>x :<C-u>call notomo#vimrc#exchange()<CR>
nnoremap [edit]r r
xnoremap [edit]r r
nnoremap [edit]h gU
nnoremap [edit]l gu
xnoremap [edit]h gU
xnoremap [edit]l gu
nnoremap [edit]t viwo<ESC>g~l
nnoremap [edit]m i<C-@>
nnoremap [edit]j :<C-u>join<CR>
xnoremap [edit]j :join<CR>

nnoremap [edit]d *``"_cgn
nnoremap [edit]a *``cgn<C-r>"
xnoremap <expr> [edit]d "y/\\V\<C-r>=notomo#vimrc#escape_search_pattern(@\")\<CR>\<CR>" . '``cgn'
nnoremap [edit]T :<C-u>call notomo#vimrc#add_closed_tag()<CR>
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
nnoremap [file]rl :<C-u>edit!<CR>
nnoremap [file]v :<C-u>edit $MYVIMRC<CR>
nnoremap [file]Eu :<C-u>edit! ++enc=utf-8<CR>
nnoremap [file]Ee :<C-u>edit! ++enc=euc-jp<CR>
"}}}

" buffer"{{{
nnoremap [buf] <Nop>
nmap <Space>b [buf]
nnoremap [buf]a <C-^>
nnoremap <silent> [buf]n :<C-u>enew \| setlocal buftype=nofile noswapfile fileformat=unix<CR>
nnoremap [buf]Q :<C-u>qa<CR>
"}}}

" swap :;"{{{
nnoremap ;  :
nnoremap :  ;
xnoremap ;  :
xnoremap :  ;
"}}}

" visual mode"{{{
nnoremap <Space>h <C-v>
nnoremap <Space>l <S-v>
nnoremap <Space>v gv
nnoremap <Space>p :<C-u>call <SID>select_paste_region()<CR>
xnoremap <Space>h <C-v>
xnoremap <Space>l <S-v>
xnoremap <Space>v v
xnoremap v <ESC>
nmap <Space>L V%

" depends yankround
function! s:select_paste_region() abort
    call setpos("'<", [0, line("'["), col("'[")])
    call setpos("'>", [0, line("']"), col("']")])
    normal! gv
endfunction
"}}}

" select mode"{{{
snoremap <CR> <ESC>gv"_c
snoremap j<Space>h <ESC>gv"_c<C-r>+
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
nmap <Space>i [indent]
xnoremap [indent] <Nop>
xmap <Space>i [indent]

for s:info in notomo#mapping#indent_normal_mode()
    silent execute join(['nnoremap', '[indent]' . s:info[s:LHS_KEY], ":<C-u>call notomo#indent#setup_submode('" . s:info[s:LHS_KEY] . "', 0)<CR>"])
endfor
for s:info in notomo#mapping#indent_visual_mode()
    silent execute join(['xnoremap', '[indent]' . s:info[s:LHS_KEY], ":<C-u>call notomo#indent#setup_submode('" . s:info[s:LHS_KEY] . "', 1)<CR>"])
endfor

"}}}

" move"{{{
nnoremap k gk
nnoremap j gj
xnoremap k gk
xnoremap j gj

nnoremap ge $
xnoremap ge $
onoremap ge $
nnoremap ga ^
xnoremap ga ^
onoremap ga ^
nnoremap gh 0
xnoremap gh 0
onoremap gh 0
nnoremap gz G
xnoremap gz G
onoremap gz G

nnoremap go <C-o>
nnoremap gi <C-i>

nnoremap gO g;
nnoremap gI g,

xnoremap <S-j> }
xnoremap <S-k> {
" remap for matchit
xmap <S-l> %
nnoremap <silent> <S-l> :<C-u>keepjumps normal %<CR>

nnoremap <silent> <S-j> :<C-u>keepjumps normal! }<CR>
nnoremap <silent> <S-k> :<C-u>keepjumps normal! {<CR>

nnoremap <C-k> <C-b>
nnoremap <C-j> <C-f>

nnoremap <C-e> gi

nnoremap sgj j]m^
nnoremap sgk [m^
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
nnoremap [option]s :<C-u>setlocal spell!<CR>
nnoremap [option]w :<C-u>setlocal wrap!<CR>
"}}}

" keyword"{{{
nnoremap [keyword]v :<C-u>vertical stjump <C-r>=expand('<cword>')<CR><CR>
nnoremap [keyword]t :<C-u>tab stjump <C-r>=expand('<cword>')<CR><CR>
nnoremap [keyword]o <C-]>
nnoremap [keyword]h :<C-u>stjump <C-r>=expand('<cword>')<CR><CR>
"}}}

" Nop"{{{
nnoremap <F1> <Nop>
xnoremap q <Nop>
xnoremap ZQ <Nop>
xnoremap ZZ <Nop>

nnoremap <Ins> <Nop>
inoremap <Ins> <Nop>

nnoremap <RightMouse> p
vnoremap <RightMouse> p
inoremap <RightMouse> <C-r>"

nnoremap <S-LeftMouse> p
vnoremap <S-LeftMouse> p
inoremap <S-LeftMouse> <C-r>"

vnoremap <3-LeftMouse> y
vnoremap <C-LeftMouse> y

noremap <MiddleMouse> <Nop>
inoremap <MiddleMouse> <Nop>
noremap <2-MiddleMouse> <Nop>
inoremap <2-MiddleMouse> <Nop>
noremap <3-MiddleMouse> <Nop>
inoremap <3-MiddleMouse> <Nop>
noremap <4-MiddleMouse> <Nop>
inoremap <4-MiddleMouse> <Nop>
"}}}

" diary"{{{
nnoremap [edit]w :<C-u>call notomo#diary#open()<CR>
"}}}

" substitute"{{{
nnoremap [substitute] <Nop>
nmap <Space>s [substitute]
xnoremap [substitute] <Nop>
xmap <Space>s [substitute]

let s:CURSOR_KEY = '{cursor}'
let s:REGISTER_KEY = '{register}'
let s:WORD_KEY = '{word}'
function! s:generate_cmd(cmd_pattern, is_visual) abort
    let word = expand('<cword>')
    let replaced_word = substitute(a:cmd_pattern, s:WORD_KEY, word, 'g')
    let register = @"
    let alter_register = repeat('x', len(register))
    let alter_replaced_register = substitute(replaced_word, s:REGISTER_KEY, alter_register, 'g')
    let cursor_pos = matchend(alter_replaced_register, s:CURSOR_KEY)
    let deleted_cursor = substitute(replaced_word, s:CURSOR_KEY, '', '')
    let result = substitute(deleted_cursor, s:REGISTER_KEY, register, 'g') . repeat("\<Left>", len(alter_replaced_register) - cursor_pos)
    " a\<BS> is for inccommand
    let result = substitute(result, "\n", '\\n', 'g') . "a\<BS>"
    return a:is_visual ? result : substitute(result, ':\zs', "\<C-u>", '')
endfunction

nnoremap <expr> [substitute]f <SID>generate_cmd(':%s/\v{cursor}//g', 0)
xnoremap <expr> [substitute]f <SID>generate_cmd(':s/\v%V{cursor}%V//g', 1)

nnoremap <expr> [substitute]wi <SID>generate_cmd(':%s/\v{word}/{cursor}/g', 0)
nnoremap <expr> [substitute]ww <SID>generate_cmd(':%s/\v{word}/{word}{cursor}/g', 0)
nnoremap <expr> [substitute]iw <SID>generate_cmd(':%s/\v{cursor}/{word}/g', 0)

nnoremap <expr> [substitute]vv <SID>generate_cmd('gv:s/\v%V{word}%V/{word}{cursor}/g', 1)
nnoremap <expr> [substitute]vi <SID>generate_cmd('gv:s/\v%V{word}%V/{cursor}/g', 1)
nnoremap <expr> [substitute]iv <SID>generate_cmd('gv:s/\v%V{cursor}%V/{word}/g', 1)
nnoremap <expr> [substitute]yv <SID>generate_cmd('gv:s/\v%V{register}%V/{word}{cursor}/g', 1)
nnoremap <expr> [substitute]vy <SID>generate_cmd('gv:s/\v%V{word}%V/{register}{cursor}/g', 1)

nnoremap <expr> [substitute]yi <SID>generate_cmd(':%s/\v{register}/{cursor}/g', 0)
xnoremap <expr> [substitute]yi <SID>generate_cmd(':s/\v{register}/{cursor}/g', 1)
nnoremap <expr> [substitute]yy <SID>generate_cmd(':%s/\v{register}/{register}{cursor}/g', 0)
xnoremap <expr> [substitute]yy <SID>generate_cmd(':s/\v{register}/{register}{cursor}/g', 1)
nnoremap <expr> [substitute]iy <SID>generate_cmd(':%s/\v{cursor}/{register}/g', 0)
xnoremap <expr> [substitute]iy <SID>generate_cmd(':s/\v{cursor}/{register}/g', 1)

nnoremap <expr> [substitute]yw <SID>generate_cmd(':%s/\v{register}/{word}{cursor}/g', 0)
nnoremap <expr> [substitute]wy <SID>generate_cmd(':%s/\v{word}/{register}{cursor}/g', 0)

nnoremap <expr> [substitute]c <SID>generate_cmd(':%s/\C\v{cursor}//g', 0)
xnoremap <expr> [substitute]c <SID>generate_cmd(':s/\C\v{cursor}//g', 1)

nnoremap <expr> [substitute]e <SID>generate_cmd(':%s/\v$/{cursor}/g', 0)
xnoremap <expr> [substitute]e <SID>generate_cmd(':s/\v$/{cursor}/g', 1)

nnoremap <expr> [substitute]de <SID>generate_cmd(':v/{cursor}/d', 0)
xnoremap <expr> [substitute]de <SID>generate_cmd(':v/{cursor}/d', 0)

nnoremap <expr> [substitute]di <SID>generate_cmd(':g/{cursor}/d', 0)
xnoremap <expr> [substitute]di <SID>generate_cmd(':g/{cursor}/d', 0)

nnoremap <expr> [substitute]aw ':%' . notomo#case#substitute_pattern(expand('<cword>'))
nnoremap <expr> [substitute]ay ':%' . notomo#case#substitute_pattern(@+)
"}}}

" replace"{{{
nnoremap [replace] <Nop>
nmap <Space>r [replace]
xnoremap [replace] <Nop>
xmap <Space>r [replace]

function! s:nxnoremap_replace(lhs, pattern, str) abort
    let pattern = substitute(a:pattern, '\', '\\\\', 'g')
    let str = substitute(a:str, '\', '\\\\', 'g')
    let substitute_str = 's/\\v' . pattern . '/' . str . '/ge\\|noh'
    let v_substitute_str = "'<,'>" . 's/\\v%V' . pattern . '%V/' . str . '/g\\|noh'
    silent execute join(['nnoremap', '<silent>', '[replace]' . a:lhs, 'q::s@^@' . substitute_str . '@g<CR><CR>'])
    silent execute join(['xnoremap', '<silent>', '[replace]' . a:lhs, '<ESC>q::s@^.*$@' . v_substitute_str . '@g<CR><CR>'])
endfunction

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
\   {s:LHS_KEY : 'mr', s:PATTERN_KEY : '\_.*\ze\n', s:STR_KEY : "\\=join(split(submatch(0), \"\\n\"), \"\\\\\\\\|\")"},
\   {s:LHS_KEY : '<Space>b', s:PATTERN_KEY : '\S{-1,}\zs(\t\| {2,})\ze\S{-1,}', s:STR_KEY : ' '},
\   {s:LHS_KEY : 'cm', s:PATTERN_KEY : ',', s:STR_KEY : '\r'},
\   {s:LHS_KEY : 'tm', s:PATTERN_KEY : '\t', s:STR_KEY : '\r'},
\   {s:LHS_KEY : '<Space>m', s:PATTERN_KEY : '\s+', s:STR_KEY : '\r'},
\   {s:LHS_KEY : 'qw', s:PATTERN_KEY : "'", s:STR_KEY : '"'},
\   {s:LHS_KEY : 'wq', s:PATTERN_KEY : '"', s:STR_KEY : "'"},
\   {s:LHS_KEY : 'ww', s:PATTERN_KEY : '^\s*\zs(.*)\ze\s*$', s:STR_KEY : '"\1"'},
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
    call s:nxnoremap_replace(s:info[s:LHS_KEY], s:info[s:PATTERN_KEY], s:info[s:STR_KEY])
endfor
"}}}

" yank"{{{
nnoremap [yank] <Nop>
nmap <Space>y [yank]
xnoremap [yank] <Nop>
xmap <Space>y [yank]

nnoremap <silent> [yank]d :<C-u>call notomo#vimrc#yank_and_echo(strftime('%Y-%m-%d'))<CR>
nnoremap <silent> [yank]D :<C-u>call notomo#vimrc#yank_and_echo(strftime('%Y-%m-%d %T'))<CR>
nnoremap <silent> [yank]n :<C-u>call notomo#vimrc#yank_and_echo(fnamemodify(expand('%'), ':r'))<CR>
nnoremap <silent> [yank]N :<C-u>call notomo#vimrc#yank_and_echo(expand('%'))<CR>
nnoremap <silent> [yank]p :<C-u>call notomo#vimrc#yank_and_echo(substitute(substitute(expand('%:p'), substitute(expand('$HOME'), '\\', '\\\\', 'g'), '~', ''), '\', '/', 'g'))<CR>
nnoremap <silent> [yank]P :<C-u>call notomo#vimrc#yank_and_echo(substitute(expand('%:p'), '\', '/', 'g'))<CR>
nnoremap <silent> [yank]; :<C-u>call notomo#vimrc#yank_and_echo(@:)<CR>
nnoremap <silent> [yank]/ :<C-u>call notomo#vimrc#yank_and_echo(@/)<CR>
nnoremap <silent> [yank]i :<C-u>call notomo#vimrc#yank_and_echo(@.)<CR>
nnoremap <silent> [yank]b :<C-u>call notomo#vimrc#yank_and_echo(gina#component#repo#branch())<CR>
nnoremap <silent> [yank]ud :<C-u>call notomo#vimrc#yank_and_echo(notomo#vimrc#url_decode())<CR>
nnoremap <silent> [yank]ue :<C-u>call notomo#vimrc#yank_and_echo(notomo#vimrc#url_encode())<CR>
nnoremap <silent> [yank]l :<C-u>call notomo#vimrc#yank_and_echo(line('.'))<CR>
nnoremap <silent> [yank]c :<C-u>call notomo#vimrc#yank_and_echo(col('.'))<CR>
"}}}

" inner and around vomapping"{{{
function! s:ia_vonoremap(lhs, rhs) abort
    let inner_lhs = 'i' . a:lhs
    let inner_rhs = 'i' . a:rhs
    let around_lhs = 'a' . a:lhs
    let around_rhs = 'a' . a:rhs
    silent execute join(['xnoremap', inner_lhs, inner_rhs])
    silent execute join(['onoremap', inner_lhs, inner_rhs])
    silent execute join(['xnoremap', around_lhs, around_rhs])
    silent execute join(['onoremap', around_lhs, around_rhs])
endfunction
call s:ia_vonoremap(';', 'B')
call s:ia_vonoremap('o', 'p')
call s:ia_vonoremap('i', 'w')
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
nnoremap [fold] <Nop>
nmap <Leader>z [fold]
nnoremap [fold]j zj
nnoremap [fold]k zk
nnoremap [fold]n ]z
nnoremap [fold]p [z
nnoremap [fold]h zc
nnoremap [fold]l zo
nnoremap [fold]a za
nnoremap [fold]m zM
nnoremap [fold]i zMzv
nnoremap [fold]r zR
nnoremap [fold]f zf
nnoremap [fold]d zd
nnoremap zD <Nop>
"}}}

" command and insert"{{{

noremap! <C-b> <Left>
noremap! <C-f> <Right>
inoremap <C-k> <C-o>C
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>
noremap! <C-e> <End>
inoremap <C-a> <C-o>^
cnoremap <C-a> <Home>
noremap! <C-h> <BS>
noremap! <C-d> <Del>
inoremap <C-o> <C-o>o

" インデント
inoremap <S-TAB> <C-d>

" calculator
silent execute join(['noremap!', notomo#mapping#get_calculator_key(), '<C-r>=notomo#number#setup_submode()<CR><C-r>='])

" 数字入力モード
silent execute join(['noremap!', notomo#mapping#get_number_mode_key(), '<C-r>=notomo#number#setup_submode()<CR>'])

" カーソル位置の単語を大文字に変換
inoremap j<Space><Space> <ESC>gUiwea

" 前に入力した文字を入力
inoremap j<Space>z <C-a>

" for wildmenu
cnoremap j<Space>o <Space><BS><C-z>
cnoremap <Tab> <C-n>
cnoremap <S-Tab> <C-p>

let s:JOIN_UNDO = "\<C-g>U"
function! s:cinoremap_with_prefix(lhs, rhs) abort
    silent execute join(['inoremap', a:lhs, substitute(a:rhs, '\ze<Left>$', s:JOIN_UNDO, '')])
    silent execute join(['cnoremap', a:lhs, a:rhs])
endfunction

for s:info in notomo#mapping#main_input()
    call s:cinoremap_with_prefix(s:info[s:LHS_KEY], s:info[s:RHS_KEY])
endfor
let s:main_input_key = notomo#mapping#get_main_input_key()
execute 'inoremap <expr> ' . s:main_input_key . '<CR> notomo#vimrc#to_multiline()'

for s:info in notomo#mapping#sub_input()
    call s:cinoremap_with_prefix(s:info[s:LHS_KEY], s:info[s:RHS_KEY])
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
            return r . s:JOIN_UNDO . "\<Left>"
        endif
    endfor
    return "\<Right>"
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
xnoremap [diff]j ]c
xnoremap [diff]k [c
xnoremap [diff]g :diffget<CR>
xnoremap [diff]p :diffput<CR>
"}}}

" arithmatic"{{{
nnoremap [arith] <Nop>
xnoremap [arith] <Nop>
nmap <Space>a [arith]
xmap <Space>a [arith]

nnoremap <expr> [arith]j notomo#arithmatic#inc_dec('dec')
nnoremap <expr> [arith]k notomo#arithmatic#inc_dec('inc')
nnoremap [arith]J v<C-x><ESC>
nnoremap [arith]K v<C-a><ESC>
xnoremap [arith]j <C-x>gv
xnoremap [arith]k <C-a>gv
xnoremap [arith]d g<C-x>gv
xnoremap [arith]u g<C-a>gv
"}}}

" exec"{{{
nnoremap <silent> [exec]n :<C-u>nohlsearch<CR>
" execute current line
nnoremap <expr> [exec]l ':' . getline('.') . '<CR>'
" relode vimrc
nnoremap <silent> [exec]r :<C-u>if !empty(expand($MYVIMRC)) \| source $MYVIMRC \| endif \| if !empty(expand($MYGVIMRC)) \| source $MYGVIMRC \| endif \| nohlsearch<CR>
nnoremap [exec]e :<C-u>smile<CR>
nnoremap [exec]cC :<C-u>messages clear<CR>
nnoremap [exec]t :<C-u>tabe ~/workspace/notomo-life/todo/README.md<CR>
nnoremap [exec]do :<C-u>tab drop ~/.local/.mytodo<CR>
"}}}

" quickfix and locationlist"{{{
nnoremap [qf] <Nop>
nmap <Space>q [qf]

nnoremap [qf]o :<C-u>call notomo#qf#open()<CR>
nnoremap [qf]c :<C-u>call notomo#qf#close()<CR>
nnoremap [qf]f :<C-u>call notomo#qf#first()<CR>
nnoremap [qf]l :<C-u>call notomo#qf#last()<CR>
nnoremap [qf]n :<C-u>call notomo#qf#next()<CR>
nnoremap [qf]p :<C-u>call notomo#qf#previous()<CR>
nnoremap [qf]d :<C-u>call notomo#qf#delete()<CR>
nnoremap [qf]u :<C-u>call notomo#qf#undo()<CR>
nnoremap [qf]<CR> :<C-u>call notomo#qf#current_open()<CR>
nnoremap [qf]<Space> :<C-u>call notomo#qf#preview()<CR>
"}}}

" window"{{{
" move"{{{
nnoremap [winmv] <Nop>
nmap m [winmv]

" left
nnoremap [winmv]a <C-w>h
" down
nnoremap [winmv]x <C-w>j
" up
nnoremap [winmv]w <C-w>k
" right
nnoremap [winmv]l <C-w>l
" swap
nnoremap [winmv]s <C-w>r
"}}}

" split"{{{

nnoremap [win] <Nop>
nmap <Space>w [win]

" split horizontally
nnoremap [win]h :<C-u>split<CR>
" split vertically
nnoremap [win]v :<C-u>vsplit<CR>
" close others
nnoremap [win]o :<C-u>only<CR>
" close others vertically
nnoremap [win]j :<C-u>call notomo#window#vonly()<CR>
" close right vertically
nnoremap [win]; :<C-u>call notomo#window#ronly()<CR>
" close left windows
nnoremap [win]a :<C-u>call notomo#window#lonly()<CR>
" close preview
nnoremap [win]p <C-w>z
" close
nnoremap [win]q :<C-u>q<CR>
" open left tab's buffers vertically
nnoremap [win]H :<C-u>call notomo#window#vs_from_left()<CR>
" open right tab's buffers vertically
nnoremap [win]L :<C-u>call notomo#window#vs_from_right()<CR>
" reopen windows vertically
nnoremap [win]V :<C-u>call notomo#window#h_to_vsplit()<CR>
" close window and open tab
nnoremap [win]l :<C-u>call notomo#window#extract_tabopen()<CR>
" open the alternative buffer with vertical splitting
nnoremap [win]b :<C-u>call notomo#window#vsplit_altopen()<CR>
" duplicate window
nnoremap [win]w :<C-u>call notomo#window#duplicate()<CR>
"}}}

" winsize"{{{
let s:winsize_enter = 'i'
silent execute join(['nnoremap', '[win]' . s:winsize_enter, ":<C-u>call notomo#window#setup_submode('" . s:winsize_enter . "')<CR>"])

" equalize
nnoremap [win]e <C-w>=
" maximize
nnoremap [win]m :<C-u>SM 4<CR>
"}}}
"}}}


" tab"{{{

nnoremap [tab] <Nop>
nmap t [tab]
xnoremap [tab] <Nop>
xmap t [tab]

" close others
nnoremap <silent> [tab]o :<C-u>tabonly<CR>
xnoremap <silent> [tab]o :<C-u>tabonly<CR>

" close all
nnoremap <silent> [tab]O :<C-u>qall<CR>

" close tab"{{{
function! s:tabclose_c() abort
    if tabpagenr('$') == 1
        qa
    endif
    if tabpagenr() <= 1
        tabclose
    else
        " close current tab and open left tab
        tabprevious
        +tabclose
    endif
endfunction
nnoremap <silent> <Plug>(tabclose_c) :<C-u>call <SID>tabclose_c()<CR>
"}}}

" open new tab"{{{
function! s:new_tab() abort
    tabe | setlocal buftype=nofile noswapfile fileformat=unix
endfunction
nnoremap <silent> <Plug>(new_tab) :<C-u>call <SID>new_tab()<CR>
nnoremap [tab]t :<C-u>call <SID>new_tab()<CR>
"}}}

" for mouse"{{{
nnoremap <C-Tab> gt
nnoremap <C-S-Tab> gT
inoremap <C-Tab> <Esc>gt
inoremap <C-S-Tab> <Esc>gT
vnoremap <C-Tab> <Esc>gt
vnoremap <C-S-Tab> <Esc>gT
nnoremap <silent> <C-w> :<C-u>call <SID>tabclose_c()<CR>
inoremap <silent> <C-w> <ESC>:<C-u>call <SID>tabclose_c()<CR>
vnoremap <silent> <C-w> <ESC>:<C-u>call <SID>tabclose_c()<CR>
nmap <silent> <C-t> <Plug>(new_tab)
"}}}

for s:info in notomo#mapping#tab()
    silent execute join(['nnoremap', '[tab]' . s:info[s:LHS_KEY], ":<C-u>call notomo#tab#setup_submode('" . s:info[s:LHS_KEY] . "')<CR>"])
endfor

"}}}

