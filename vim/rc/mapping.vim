scriptencoding utf-8

let g:mapleader = ','
let g:maplocalleader = '<Leader>l'

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
nnoremap [substitute] <Nop>
nmap <Space>s [substitute]
xnoremap [substitute] <Nop>
xmap <Space>s [substitute]
nnoremap [finder] <Nop>
nmap <Space>d [finder]
xnoremap [finder] <Nop>
xmap <Space>d [finder]

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

"}}}

" edit"{{{
nnoremap <silent> <Leader>x <Cmd>call notomo#vimrc#exchange()<CR>
nnoremap [edit]r r
xnoremap [edit]r r
nnoremap [edit]h gU
nnoremap [edit]l gu
xnoremap [edit]h gU
xnoremap [edit]l gu
nnoremap [edit]t viwo<ESC>g~l
nnoremap [edit]m i<C-@>
nnoremap [edit]j <Cmd>join<CR>
xnoremap [edit]j :join<CR>
nnoremap [edit]d *N"_cgn
nnoremap [edit]a *``cgn<C-r>"
nnoremap [edit]T <Cmd>call notomo#vimrc#add_closed_tag()<CR>

nnoremap [edit]p [p
nnoremap [edit]P [P
"}}}

" kana"{{{
nnoremap い i
nnoremap あ a
"}}}

" file"{{{
nnoremap [file]w <Cmd>write<CR>
nnoremap [file]rl :<C-u>edit!<CR>
nnoremap [file]R <Cmd>call notomo#vimrc#rotate_file()<CR>
"}}}

" buffer"{{{
nnoremap [buf] <Nop>
nmap <Space>b [buf]
nnoremap [buf]a <C-^>
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
nnoremap <Space>p <Cmd>call <SID>select_paste_region()<CR>
xnoremap <Space>h <C-v>
xnoremap <Space>l <S-v>
xnoremap <Space>v v
xnoremap v <ESC>

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
cnoremap <LeftMouse> <C-c>
"}}}


" indent"{{{
nnoremap [indent] <Nop>
nmap <Space>i [indent]
xnoremap [indent] <Nop>
xmap <Space>i [indent]

function! s:convert_indent_style(to_hard, is_visual) abort
    let tmp_expandtab = &expandtab
    let expandtab_cmd = a:to_hard == 1 ? 'noexpandtab' : 'expandtab'
    execute 'setlocal ' . expandtab_cmd
    let range_str = a:is_visual == 1 ? "'<,'>" : '.'
    execute range_str . 'retab!'
    let &expandtab = tmp_expandtab
endfunction

nnoremap [indent]f >>
xnoremap [indent]f >gv
nnoremap [indent]l >>
xnoremap [indent]l >gv
nnoremap [indent]a <<
xnoremap [indent]a <gv
nnoremap [indent]h <<
xnoremap [indent]h <gv
nnoremap [indent]s ==
xnoremap [indent]s =gv
nnoremap [indent]r <Cmd>left<CR>
xnoremap [indent]r :left<CR>gv
nnoremap <silent> [indent]t <Cmd>call <SID>convert_indent_style(1, 0)<CR>
xnoremap <silent> [indent]t <ESC><Cmd>call <SID>convert_indent_style(1, 1)<CR>
nnoremap <silent> [indent]<Space> <Cmd>call <SID>convert_indent_style(0, 0)<CR>
xnoremap <silent> [indent]<Space> <ESC><Cmd>call <SID>convert_indent_style(0, 1)<CR>
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

onoremap gp ])
xnoremap gp ])h
onoremap gd ]}
xnoremap gd ]}h

onoremap gl t]
onoremap gs t"
onoremap gb t`
onoremap gq t'
onoremap gx t*
onoremap gt t>
onoremap g; t;
onoremap g, t,
onoremap g. t.
onoremap gc t:
onoremap gP t(

nnoremap go <C-o>
nnoremap gi <C-i>

nnoremap gO g;
nnoremap gI g,

xnoremap <S-j> }
xnoremap <S-k> {
" remap for matchit
xmap <S-l> %
nnoremap <silent> <S-l> <Cmd>keepjumps normal %<CR>

nnoremap <silent> <S-j> <Cmd>keepjumps normal! }<CR>
nnoremap <silent> <S-k> <Cmd>keepjumps normal! {<CR>

nnoremap <C-k> <C-b>
nnoremap <C-j> <C-f>

nnoremap <C-e> gi

nnoremap sgj j]m^
nnoremap sgk [m^
"}}}

" newline"{{{
nnoremap [newline] <Nop>
nmap o [newline]
nnoremap <silent> [newline]o <Cmd>for i in range(v:count1) \| call append(line('.'), '') \| endfor<CR>
nnoremap <silent> [newline]j <Cmd>for i in range(v:count1) \| call append(line('.'), '') \| execute 'normal! j' \| endfor<CR>
"}}}

nnoremap <Space>os <Cmd>setlocal spell!<CR>

" keyword"{{{
nnoremap [keyword]v <Cmd>vertical stjump <C-r>=expand('<cword>')<CR><CR>
nnoremap [keyword]t <Cmd>tab stjump <C-r>=expand('<cword>')<CR><CR>
nnoremap [keyword]o <C-]>
nnoremap [keyword]h <Cmd>stjump <C-r>=expand('<cword>')<CR><CR>
"}}}

" Nop"{{{
nnoremap <F1> <Nop>
xnoremap q <Nop>
xnoremap ZQ <Nop>
xnoremap ZZ <Nop>

nnoremap zD <Nop>

nnoremap <Ins> <Nop>
inoremap <Ins> <Nop>

nnoremap <RightMouse> <LeftMouse>p
vnoremap <RightMouse> <LeftMouse>p
inoremap <RightMouse> <LeftMouse><C-r>"

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

nnoremap q <Nop>
"}}}

" diary"{{{
nnoremap [edit]w <Cmd>lua require("notomo.diary").open()<CR>
"}}}

" substitute"{{{
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
"}}}

" yank"{{{
nnoremap [yank] <Nop>
nmap <Space>y [yank]
xnoremap [yank] <Nop>
xmap <Space>y [yank]

nnoremap <silent> [yank]d <Cmd>call notomo#vimrc#yank_and_echo(strftime('%Y-%m-%d'))<CR>
nnoremap <silent> [yank]D <Cmd>call notomo#vimrc#yank_and_echo(strftime('%Y-%m-%d %T'))<CR>
nnoremap <silent> [yank]n <Cmd>call notomo#vimrc#yank_and_echo(fnamemodify(expand('%'), ':r'))<CR>
nnoremap <silent> [yank]N <Cmd>call notomo#vimrc#yank_and_echo(expand('%'))<CR>
nnoremap <silent> [yank]p <Cmd>call notomo#vimrc#yank_and_echo(substitute(substitute(expand('%:p'), substitute(expand('$HOME'), '\\', '\\\\', 'g'), '~', ''), '\', '/', 'g'))<CR>
nnoremap <silent> [yank]P <Cmd>call notomo#vimrc#yank_and_echo(substitute(expand('%:p'), '\', '/', 'g'))<CR>
nnoremap <silent> [yank]; <Cmd>call notomo#vimrc#yank_and_echo(@:)<CR>
nnoremap <silent> [yank]/ <Cmd>call notomo#vimrc#yank_and_echo(@/)<CR>
nnoremap <silent> [yank]i <Cmd>call notomo#vimrc#yank_and_echo(@.)<CR>
nnoremap <silent> [yank]b <Cmd>call notomo#vimrc#yank_and_echo(gina#component#repo#branch())<CR>
nnoremap <silent> [yank]l <Cmd>call notomo#vimrc#yank_and_echo(line('.'))<CR>
nnoremap <silent> [yank]c <Cmd>call notomo#vimrc#yank_and_echo(col('.'))<CR>
nnoremap <silent> [yank]w <Cmd>call notomo#vimrc#yank_and_echo(expand('%:p:h:t'))<CR>
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
call s:ia_vonoremap('o', 'p')
call s:ia_vonoremap(';', 'w')
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

onoremap ; iw

" command and insert"{{{

inoremap <C-n> <Down>
inoremap <C-p> <Up>
noremap! <C-b> <Left>
noremap! <C-f> <Right>
inoremap <C-k> <C-o>C
cnoremap <C-k> <Up>
cnoremap <Up> <C-p>
cnoremap <Down> <C-n>
cnoremap <C-j> <Down>
noremap! <C-e> <End>
inoremap <C-a> <C-o>^
cnoremap <C-a> <Home>
noremap! <C-h> <BS>
noremap! <C-d> <Del>
inoremap <C-o> <C-o>o

" インデント
inoremap <S-TAB> <C-d>

silent execute 'noremap!' notomo#mapping#get_calculator_key() '<C-r>='

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

" diff"{{{
nnoremap [diff]j ]c
nnoremap [diff]k [c
nnoremap [diff]g <Cmd>diffget<CR>
nnoremap [diff]p <Cmd>diffput<CR>
nnoremap [diff]q <Cmd>diffoff!<CR>
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

function! s:inc_or_dec(is_inc) abort
    let key = a:is_inc ? "\<C-a>" : "\<C-x>"
    let line = getline('.')
    let col = col('.')
    let pattern = '\v\d+\ze[^[:digit:]]*$'
    if matchend(line[col - 1:], pattern) == -1
        let idx = matchend(line[:col - 1], pattern)
        if idx != -1
            return printf('%dh%s', col - idx, key)
        endif
    endif
    return key
endfunction
nnoremap <expr> [arith]j <SID>inc_or_dec(v:false)
nnoremap <expr> [arith]k <SID>inc_or_dec(v:true)
xnoremap [arith]j <C-x>gv
xnoremap [arith]k <C-a>gv
xnoremap [arith]d g<C-x>gv
xnoremap [arith]u g<C-a>gv
"}}}

" exec"{{{
nnoremap <silent> [exec]n <Cmd>nohlsearch<CR>
" execute current line
nnoremap <expr> [exec]l ':' . getline('.') . '<CR>'
nnoremap [exec]do <Cmd>tab drop ~/.local/.mytodo<CR>
nnoremap [exec]q <Cmd>call notomo#vimrc#jq()<CR>
nnoremap [exec]N <Cmd>call notomo#vimrc#open_note()<CR>
"}}}

" quickfix and locationlist"{{{
nnoremap [qf] <Nop>
nmap <Space>q [qf]

nnoremap [qf]o <Cmd>call notomo#qf#open()<CR>
nnoremap [qf]c <Cmd>call notomo#qf#close()<CR>
nnoremap [qf]s <Cmd>call notomo#qf#first()<CR>
nnoremap [qf]e <Cmd>call notomo#qf#last()<CR>
nnoremap [qf]n <Cmd>call notomo#qf#next()<CR>
nnoremap [qf]p <Cmd>call notomo#qf#previous()<CR>
nnoremap [qf]d <Cmd>call notomo#qf#delete()<CR>
nnoremap [qf]u <Cmd>call notomo#qf#undo()<CR>
nnoremap [qf]<CR> <Cmd>call notomo#qf#current_open()<CR>
nnoremap [qf]<Space> <Cmd>call notomo#qf#preview()<CR>
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
" next
nnoremap [winmv]; <C-w>w
"}}}

nnoremap [win] <Nop>
nmap <Space>w [win]

" split horizontally
nnoremap [win]h <Cmd>split<CR>
" split vertically
nnoremap [win]v <Cmd>vsplit<CR>
" close others
nnoremap [win]o <Cmd>silent only<CR>
" close
nnoremap [win]q <Cmd>q<CR>
" equalize
nnoremap [win]e <C-w>=
"}}}


" tab"{{{
nnoremap [tab] <Nop>
nmap t [tab]
xnoremap [tab] <Nop>
xmap t [tab]

nnoremap <silent> [tab]o <Cmd>silent tabonly<CR>
xnoremap <silent> [tab]o <Esc><Cmd>silent tabonly<CR>
nnoremap <silent> [tab]O <Cmd>qall<CR>
nnoremap <silent> <Plug>(tabclose_c) <Cmd>tabclose<CR>
nnoremap <silent> <Plug>(new_tab) <Cmd>tabedit<CR>:setlocal buftype=nofile noswapfile<CR>
nmap [tab]t <Plug>(new_tab)

" for mouse"{{{
nnoremap <C-Tab> gt
nnoremap <C-S-Tab> gT
inoremap <C-Tab> <Esc>gt
inoremap <C-S-Tab> <Esc>gT
vnoremap <C-Tab> <Esc>gt
vnoremap <C-S-Tab> <Esc>gT
nmap <silent> <C-w> <Plug>(tabclose_c)
imap <silent> <C-w> <ESC><Plug>(tabclose_c)
vmap <silent> <C-w> <ESC><Plug>(tabclose_c)
nmap <silent> <C-t> <Plug>(new_tab)
"}}}

for s:info in notomo#mapping#tab()
    silent execute join(['nnoremap', '[tab]' . s:info[s:LHS_KEY], "<Cmd>call notomo#tab#setup_submode('" . s:info[s:LHS_KEY] . "')<CR>"])
endfor
"}}}

if has('win32')
    tnoremap <C-u> <ESC>
endif

tnoremap jj <C-\><C-n>

if has('win32')
    tnoremap <C-u> <C-Home>
endif

for s:info in notomo#mapping#main_input()
    silent execute join(['tnoremap', s:info[s:LHS_KEY], s:info[s:RHS_KEY]])
endfor

for s:info in notomo#mapping#sub_input()
    silent execute join(['tnoremap', s:info[s:LHS_KEY], s:info[s:RHS_KEY]])
endfor

tnoremap <C-p> <Up>
tnoremap <C-n> <Down>

let s:MAIN_INPUT_PFX = notomo#mapping#get_main_input_key()
execute join(['tnoremap', s:MAIN_INPUT_PFX . 'h', '<Cmd>put +<CR>'])
execute join(['tnoremap', s:MAIN_INPUT_PFX . 'o', '<Tab>'])

nnoremap [term] <Nop>
nmap <Space>t [term]

nnoremap <silent> [term]o <Cmd>terminal<CR>

function! s:open_terminal(open_cmd) abort
    execute a:open_cmd
    execute 'terminal'
endfunction
nnoremap <silent> [term]v <Cmd>call <SID>open_terminal('vsplit')<CR>
nnoremap <silent> [term]h <Cmd>call <SID>open_terminal('split')<CR>
nnoremap <silent> [term]t <Cmd>call <SID>open_terminal('tabedit')<CR>
nnoremap <silent> [term]g <Cmd>call <SID>open_terminal_on_project_root()<CR>

function! s:open_terminal_on_project_root() abort
    let path = finddir('.git', ',;')
    let project_path = '.'
    if path != ''
        let project_path = fnamemodify(path, ':p:h:h')
    endif
    tabedit
    call termopen(&shell, {'cwd': project_path})
    execute 'lcd' project_path
endfunction

function! s:set_title(prompt_pattern, max_length) abort
    let path = nvim_buf_get_name(0)
    let shell = split(fnamemodify(path, ':t'), ':')[0]
    let term_path = printf('%s/%s', fnamemodify(path, ':h'), shell)

    let prompt_line = getline(search(a:prompt_pattern, 'nbcW'))
    let prompt = matchstr(prompt_line, a:prompt_pattern)
    let cmd = prompt_line[strlen(prompt) : a:max_length]
    let cmd = substitute(cmd, '/', '\\', 'g')

    call nvim_buf_set_name(0, printf('%s:%s', term_path, cmd))
    redrawtabline
endfunction

tnoremap <CR> <Cmd>call <SID>set_title('^\$ ', 24)<CR><CR>

nnoremap <silent> [yank]ud <Cmd>call notomo#vimrc#yank_and_echo(luaeval("require 'notomo.url'.cursor_url_decode()"))<CR>
nnoremap <silent> [yank]ue <Cmd>call notomo#vimrc#yank_and_echo(luaeval("require 'notomo.url'.cursor_url_encode()"))<CR>

nnoremap <silent> [yank]M <Cmd>call notomo#vimrc#yank_and_echo(trim(system('mongo --eval "(new ObjectId()).str" --quiet')))<CR>

let g:_debug_args = []
let g:_debug_watched = []
function! s:start_termdebug() abort
    packadd termdebug

    let path = expand('~/workspace/neovim/')
    let nvim = path .. 'build/bin/nvim'
    let rc = expand('~/dotfiles/tool/nvim_development/debugrc.vim')

    let current = expand('%:p')
    let in_repo = current =~? '^' .. path
    if !in_repo
        tabedit
        execute 'tcd' path
    endif

    execute 'TermdebugCommand' nvim join(g:_debug_args, ' ') ' -u' rc
    Source
    if in_repo
        Break
    endif
    for var in g:_debug_watched
        call TermDebugSendCommand('watch ' .. var)
    endfor
    call TermDebugSendCommand('run')

    nnoremap [term]s <Cmd>Step<CR>
    nnoremap [term]b <Cmd>Break<CR>
    nnoremap [term]B <Cmd>Clear<CR>
    nnoremap [term]n <Cmd>Over<CR>
    nnoremap [term]c <Cmd>Continue<CR>
    nnoremap [term]f <Cmd>Finish<CR>
    nnoremap [keyword]e :Evaluate<CR>

    " restore K
    nnoremap <silent> <S-k> <Cmd>keepjumps normal! {<CR>
endfunction

function! s:quit_termdebug() abort
    if !exists('*TermDebugSendCommand')
        return
    endif
    try
        call TermDebugSendCommand('quit')
        call TermDebugSendCommand('y')
    catch /Can't send data to closed stream\|E900: Invalid channel id/
    endtry
endfunction

nnoremap [term]S <Cmd>call <SID>start_termdebug()<CR>
nnoremap [term]q <Cmd>call <SID>quit_termdebug()<CR>
