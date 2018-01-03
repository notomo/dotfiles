scriptencoding utf-8

let s:LHS_KEY = notomo#mapping#get_lhs_key()
let s:RHS_KEY = notomo#mapping#get_rhs_key()

" basic"{{{

" delete a character using delete register
nnoremap x "_x
vnoremap x "_x

" change using delete register
nnoremap c "_c
vnoremap c "_c

" repeat an ex command
nnoremap <Space>. @:
vnoremap <Space>. @:

" redo
nnoremap <Leader>r <C-r>

" open commandline window
nnoremap Q q:

"}}}

" edit"{{{
nnoremap <silent> <Leader>x :<C-u>call notomo#vimrc#exchange()<CR>
nnoremap [edit]r r
vnoremap [edit]r r
nnoremap [edit]h gU
nnoremap [edit]l gu
vnoremap [edit]h gU
vnoremap [edit]l gu
nnoremap [edit]m i<C-@>

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
nnoremap [file]W :<C-u>write !sudo tee %<CR>
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
nnoremap [buf]O :<C-u>call <SID>open_not_saved_bufs()<CR>
nnoremap [buf]o :<C-u>call <SID>delete_other_bufs()<CR>

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

function! s:delete_buf(curbufs) abort
    let curbuf_num = bufnr('%')
    if index(a:curbufs, curbuf_num) >= 0 || getbufvar(curbuf_num, '&modified')
        return
    endif
    bwipeout!
endfunction

function! s:delete_other_bufs() abort
    tabonly
    let curbufs = tabpagebuflist()
    bufdo call s:delete_buf(curbufs)
endfunction

let s:scroll_enter = '[buf]s'
silent execute join(['nnoremap', s:scroll_enter, ":<C-u>call notomo#scroll#setup_submode('" . s:scroll_enter . "')<CR>"])

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
nmap <Space>i [indent]
vnoremap [indent] <Nop>
vmap <Space>i [indent]

for s:info in notomo#mapping#indent_normal_mode()
    silent execute join(['nnoremap', '[indent]' . s:info[s:LHS_KEY], ":<C-u>call notomo#indent#setup_submode('" . s:info[s:LHS_KEY] . "', 0)<CR>"])
endfor
for s:info in notomo#mapping#indent_visual_mode()
    silent execute join(['vnoremap', '[indent]' . s:info[s:LHS_KEY], ":<C-u>call notomo#indent#setup_submode('" . s:info[s:LHS_KEY] . "', 1)<CR>"])
endfor

"}}}

" move"{{{
nnoremap k gk
nnoremap j gj
vnoremap k gk
vnoremap j gj

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

function! s:toggle_verbose() abort
    if &verbose == 0
        set verbose=12
        set verbosefile=~/.vim/tmp/verbosefile
    else
        set verbose=0
        set verbosefile=
    endif
endfunction
nnoremap [option]V :<C-u>call <SID>toggle_verbose()<CR>

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

function! s:split_tag_open(split_cmd) abort
    try
        let curbuf_num = bufnr('%')
        call bettertagjump#php#Jump()
        if curbuf_num != bufnr('%')
            noautocmd execute 'buffer ' . curbuf_num
        endif
        execute a:split_cmd
        noautocmd execute "normal! \<C-o>"
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

nnoremap [keyword]v :<C-u>call <SID>split_tag_open('vsplit')<CR>
nnoremap [keyword]o :<C-u>call <SID>tag_open()<CR>
nnoremap [keyword]h :<C-u>call <SID>split_tag_open('split')<CR>
"}}}

" Nop"{{{
nnoremap <F1> <Nop>
vnoremap q <Nop>
vnoremap ZQ <Nop>
vnoremap ZZ <Nop>

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

noremap! <BS> <Left>

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
function! s:open_diary() abort
    let diary_folder_path = expand('~/workspace/diary')
    if !isdirectory(diary_folder_path)
        call mkdir(diary_folder_path, 'p')
    endif
    let diary_path =  diary_folder_path . '/' . strftime('%Y%m%d.txt')
    execute 'tab drop ' . diary_path
    execute 'set filetype=mydiary'
endfunction
nnoremap <Space>ew :<C-u>call <SID>open_diary()<CR>
"}}}

" substitute"{{{
nnoremap [substitute] <Nop>
nmap <Space>s [substitute]
vnoremap [substitute] <Nop>
vmap <Space>s [substitute]

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
vnoremap <expr> [substitute]f <SID>generate_cmd(':s/\v%V{cursor}%V//g', 1)

nnoremap <expr> [substitute]wi <SID>generate_cmd(':%s/\v{word}/{cursor}/g', 0)
nnoremap <expr> [substitute]ww <SID>generate_cmd(':%s/\v{word}/{word}{cursor}/g', 0)
nnoremap <expr> [substitute]iw <SID>generate_cmd(':%s/\v{cursor}/{word}/g', 0)

nnoremap <expr> [substitute]vv <SID>generate_cmd('gv:s/\v%V{word}%V/{word}{cursor}/g', 1)
nnoremap <expr> [substitute]vi <SID>generate_cmd('gv:s/\v%V{word}%V/{cursor}/g', 1)
nnoremap <expr> [substitute]iv <SID>generate_cmd('gv:s/\v%V{cursor}%V/{word}/g', 1)
nnoremap <expr> [substitute]yv <SID>generate_cmd('gv:s/\v%V{register}%V/{word}{cursor}/g', 1)
nnoremap <expr> [substitute]vy <SID>generate_cmd('gv:s/\v%V{word}%V/{register}{cursor}/g', 1)

nnoremap <expr> [substitute]yi <SID>generate_cmd(':%s/\v{register}/{cursor}/g', 0)
vnoremap <expr> [substitute]yi <SID>generate_cmd(':s/\v{register}/{cursor}/g', 1)
nnoremap <expr> [substitute]yy <SID>generate_cmd(':%s/\v{register}/{register}{cursor}/g', 0)
vnoremap <expr> [substitute]yy <SID>generate_cmd(':s/\v{register}/{register}{cursor}/g', 1)
nnoremap <expr> [substitute]iy <SID>generate_cmd(':%s/\v{cursor}/{register}/g', 0)
vnoremap <expr> [substitute]iy <SID>generate_cmd(':s/\v{cursor}/{register}/g', 1)

nnoremap <expr> [substitute]yw <SID>generate_cmd(':%s/\v{register}/{word}{cursor}/g', 0)
nnoremap <expr> [substitute]wy <SID>generate_cmd(':%s/\v{word}/{register}{cursor}/g', 0)

nnoremap <expr> [substitute]c <SID>generate_cmd(':%s/\C\v{cursor}//g', 0)
vnoremap <expr> [substitute]c <SID>generate_cmd(':s/\C\v{cursor}//g', 1)

nnoremap <expr> [substitute]e <SID>generate_cmd(':%s/\v$/{cursor}/g', 0)
vnoremap <expr> [substitute]e <SID>generate_cmd(':s/\v$/{cursor}/g', 1)

nnoremap <expr> [substitute]de <SID>generate_cmd(':v/{cursor}/d', 0)
vnoremap <expr> [substitute]de <SID>generate_cmd(':v/{cursor}/d', 0)

nnoremap <expr> [substitute]di <SID>generate_cmd(':g/{cursor}/d', 0)
vnoremap <expr> [substitute]di <SID>generate_cmd(':g/{cursor}/d', 0)
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
\   {s:LHS_KEY : 'j', s:PATTERN_KEY : '^\s*([^=]*).*$\zs\ze', s:STR_KEY : '\rvar_dump(\1);'},
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
nnoremap <silent> [yank]n :<C-u>call <SID>yank_value(fnamemodify(expand('%'), ':r'))<CR>
nnoremap <silent> [yank]N :<C-u>call <SID>yank_value(expand('%'))<CR>
nnoremap <silent> [yank]p :<C-u>call <SID>yank_value(substitute(substitute(expand('%:p'), substitute(expand('$HOME'), '\\', '\\\\', 'g'), '~', ''), '\', '/', 'g'))<CR>
nnoremap <silent> [yank]P :<C-u>call <SID>yank_value(substitute(expand('%:p'), '\', '/', 'g'))<CR>
nnoremap <silent> [yank]; :<C-u>call <SID>yank_value(@:)<CR>
nnoremap <silent> [yank]/ :<C-u>call <SID>yank_value(@/)<CR>
nnoremap <silent> [yank]i :<C-u>call <SID>yank_value(@.)<CR>
nnoremap <silent> [yank]f :<C-u>call <SID>yank_value(cfi#format('%s', ''))<CR>
nnoremap <silent> [yank]b :<C-u>call <SID>yank_value(gina#component#repo#branch())<CR>
nnoremap <silent> [yank]ud :<C-u>call <SID>yank_value(notomo#vimrc#url_decode())<CR>
nnoremap <silent> [yank]ue :<C-u>call <SID>yank_value(notomo#vimrc#url_encode())<CR>
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
inoremap <C-h> <Left>
noremap! <C-j> <Down>
noremap! <C-k> <Up>
inoremap <C-l> <Right>
noremap! <C-e> <End>
inoremap <C-a> <C-o>^
cnoremap <C-a> <Home>

" 編集
noremap! <C-b> <BS>
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
cnoremap j<Space>o <C-z>
cnoremap <Tab> <C-n>
cnoremap <S-Tab> <C-p>
cnoremap <C-h> <Space><BS><Left>
cnoremap <C-l> <Space><BS><Right>

if v:version >= 800
    let s:JOIN_UNDO = "\<C-g>U"
else
    let s:JOIN_UNDO = ''
endif
function! s:cinoremap_with_prefix(lhs, rhs) abort
    silent execute join(['inoremap', a:lhs, substitute(a:rhs, '\ze<Left>$', s:JOIN_UNDO, '')])
    silent execute join(['cnoremap', a:lhs, a:rhs])
endfunction

for s:info in notomo#mapping#main_input()
    call s:cinoremap_with_prefix(s:info[s:LHS_KEY], s:info[s:RHS_KEY])
endfor

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
    return ''
endfunction
inoremap <expr> j<Space>k <SID>complete_pair()

function! s:complete() abort
    if neosnippet#expandable()
        return "\<Plug>(neosnippet_expand)"
    endif
    if exists('v:completed_item') && !empty(v:completed_item)
        return "\<C-y>"
    endif
    return "\<C-n>\<C-y>"
endfunction
imap <expr> j<Space>o <SID>complete()

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

nnoremap [mark]s :<C-u>call notomo#mark#set()<CR>

nnoremap <expr> <silent> [mark]x notomo#mark#to_next()
vnoremap <expr> <silent> [mark]x notomo#mark#to_next()

nnoremap <expr> <silent> [mark]r notomo#mark#to_previous()
vnoremap <expr> <silent> [mark]r notomo#mark#to_previous()

nnoremap <silent> [mark]d :<C-u>call notomo#mark#delete_all()<CR>

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
nnoremap [arith]J v<C-x><ESC>
nnoremap [arith]K v<C-a><ESC>
vnoremap [arith]j <C-x>gv
vnoremap [arith]k <C-a>gv
vnoremap [arith]d g<C-x>gv
vnoremap [arith]u g<C-a>gv
"}}}

" exec"{{{
nnoremap <silent> [exec]n :<C-u>nohlsearch<CR>
nnoremap <silent> [exec]u :<C-u>sort nu<CR>
nnoremap <silent> [exec]U :<C-u>sort! nu<CR>
" execute current line
nnoremap <expr> [exec]l ':' . getline('.') . '<CR>'
" source current buffer
nnoremap [exec]s :<C-u>if &filetype ==? 'vim' \| source % \| endif<CR>
" relode vimrc
nnoremap <silent> [exec]r :<C-u>if !empty(expand($MYVIMRC)) \| source $MYVIMRC \| endif \| if !empty(expand($MYGVIMRC)) \| source $MYGVIMRC \| endif \| nohlsearch<CR>
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

onoremap g/ gn

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
nnoremap [winmv]j <C-w>j
nnoremap [winmv]x <C-w>j
" up
nnoremap [winmv]k <C-w>k
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
vnoremap [tab] <Nop>
vmap t [tab]

" close others
nnoremap <silent> [tab]o :<C-u>tabonly<CR>
vnoremap <silent> [tab]o :<C-u>tabonly<CR>

" close all
nnoremap <silent> [tab]<Space>q :<C-u>qall<CR>

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

