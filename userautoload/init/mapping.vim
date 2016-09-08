
nnoremap <Leader>x dlp
nnoremap x "_x


nnoremap <Space>v gv
nnoremap <Space>io gi


nnoremap <Space>Gd :<C-u>vimgrep //j *<Left><Left><Left><Left>
nnoremap <Space>Gr :<C-u>grep! "" *<Left><Left><Left>
nnoremap <Space>Gt :<C-u>cexpr ""<CR>:tabdo vimgrepadd //j %<Left><Left><Left><Left>
nnoremap <Space>Gb :<C-u>cexpr ""<CR>:bufdo vimgrepadd //j %<Left><Left><Left><Left>
" nnoremap <Space>G :<C-u>grep  **/*.<Left><Left><Left><Left><Left><Left>


inoremap <silent> jj <ESC>
inoremap <silent> っｊ <ESC>
inoremap <silent> ｊｊ <ESC>
cnoremap <silent> jj <C-u><ESC>
onoremap jj <ESC>
vnoremap v <ESC>
snoremap jj <ESC>


nnoremap [indent] <Nop>
nmap <Space>i [indent]
vnoremap [indent] <Nop>
vmap <Space>i [indent]

nnoremap [indent]i >>
nnoremap [indent]d <<
nnoremap [indent]t V:retab<CR>

vnoremap [indent]i >
vnoremap [indent]d <
vnoremap [indent]t :retab<CR>


nnoremap <CR> o<ESC>
nnoremap <silent> <Space>n :<C-u>nohlsearch<CR>
nnoremap <Space>w :<C-u>w<CR>
nnoremap <Space>q :<C-u>call <SID>close_window()<CR>

function! s:close_window() abort
    if tabpagenr("$") > 1
        q
        return
    endif
    if winnr("$") > 1 && bufwinnr("$") == -1
        let yes_or_no = input("Close Vim?[y/n] : ")
        if yes_or_no == "y"
            q
            return
        endif
        return
    endif
    q
endfunction

" nnoremap <Space>Q :<C-u>q!<CR>
nnoremap <Space>rn :<C-u>file<Space>
nnoremap <C-S-F9> :<C-u>qa<CR>

nnoremap k   gk
nnoremap j   gj
vnoremap k   gk
vnoremap j   gj

nnoremap ;  :
nnoremap :  ;
vnoremap ;  :
vnoremap :  ;

" 前のバッファへ移動
nnoremap <Space>b <C-^>

noremap ge $
noremap ga ^
noremap gh 0

nnoremap go <C-o>
nnoremap gi <C-i>

nnoremap gO g;
nnoremap gI g,
nnoremap <C-i> <C-i>
nnoremap <C-o> <C-o>

nnoremap <silent> oo  :for i in range(v:count1) \| call append(line('.'), '') \| endfor<CR>

nnoremap <silent> of  :for i in range(v:count1) \| call append(line('.'), '') \| endfor<CR>:<C-u>execute "normal j"<CR>

nnoremap <silent> oh  :<C-u>for i in range(v:count1) \| call append(line('.')-1, '') \| endfor<CR>
nnoremap <silent> oa  :<C-u>for i in range(v:count1) \| call append(line('.')-1, '') \| endfor<CR>
nnoremap oj o
nnoremap ok O
nnoremap os o
nnoremap od O
nnoremap <Space>. @:
vnoremap <Space>. @:


nnoremap <C-a> ^
nnoremap <C-e> $
nnoremap <S-y> y$
vnoremap <C-e> $
vnoremap <C-a> ^
vnoremap <S-j> }
vnoremap <S-k> {
nnoremap <Space>z <C-x>
nnoremap <Space>a <C-a>
" vnoremap <S-h> 0
" nnoremap <S-h> 0
nnoremap <silent> <S-l> :<C-u>keepjumps normal %<CR>
nnoremap <silent> <S-j> :<C-u>keepjumps normal }<CR>
nnoremap <silent> <S-k> :<C-u>keepjumps normal {<CR>

nnoremap <silent> <F5> <Esc>:<C-u>source $MYVIMRC<CR>:<C-u>source $MYGVIMRC<CR>:<C-u>nohlsearch<CR>

nnoremap <Leader>cd :<C-u>CdCurrent<CR>
nnoremap <Leader>pw :<C-u>pwd<CR>
nnoremap <Leader>cl :<C-u>echo col(".")<CR>

nnoremap <M-C-S-q> :<C-u>qa<CR>
nnoremap <Space>l <S-v>
nnoremap <Space>h <C-v>
noremap gz G
" nnoremap <Space>j gu
" nnoremap <Space>k gU
" nnoremap <Space>z gUl
vnoremap <Space>j gu
vnoremap <Space>k gU
vnoremap <Space>is =

nnoremap <C-k> <C-b>
nnoremap <C-j> <C-f>

nnoremap <F8> :%s/ *$//<CR>


nnoremap [encode] <Nop>
nmap <Space>f [encode]

nnoremap [encode]i :<C-u>set fileencoding=
nnoremap [encode]u :<C-u>set fileencoding=utf8<CR>
nnoremap [encode]e :<C-u>set fileencoding=euc-jp<CR>
nnoremap [encode]s :<C-u>set fileencoding=shift_jis<CR>

nnoremap [format] <Nop>
nmap [encode]o [format]

nnoremap [format]d :<C-u>set fileformat=dos<CR>
nnoremap [format]m :<C-u>set fileformat=mac<CR>
nnoremap [format]u :<C-u>set fileformat=unix<CR>


nnoremap [tag_open] <Nop>
nmap <Leader>d [tag_open]

function! s:tab_tag_open() abort
    try
        execute "tag ".expand("<cword>")
        execute "tab sp"
        execute "tabprevious"
        execute "normal \<C-o>"
        execute "tabnext"
    catch
        echo "Not found tag"
    endtry
endfunction
nnoremap [tag_open]t :<C-u>call <SID>tab_tag_open()<CR>

function! s:vertical_tag_open() abort
    try
        execute "tag ".expand("<cword>")
        execute "vsplit"
        execute "normal \<C-o>"
    catch
        echo "Not found tag"
    endtry
endfunction
nnoremap [tag_open]v :<C-u>call <SID>vertical_tag_open()<CR>
nnoremap [tag_open]o <C-]>
nnoremap [tag_open]h <C-w>]


nnoremap <Leader>di :<C-u>MyDiff<Space>
nnoremap <Leader>dg :<C-u>DiffOrig<CR>

nnoremap <F1> <Nop>
vnoremap q <Nop>

nnoremap <Ins> <Nop>
inoremap <Ins> <Nop>

map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>
map <2-MiddleMouse> <Nop>
imap <2-MiddleMouse> <Nop>
map <3-MiddleMouse> <Nop>
imap <3-MiddleMouse> <Nop>
map <4-MiddleMouse> <Nop>
imap <4-MiddleMouse> <Nop>




function! GitCtags() abort
    let l:git_root=system("git rev-parse --show-toplevel | tr -d '\\n'")
    let l:git_folder=l:git_root."/.git"
    let l:current_folder=getcwd()
    if l:git_folder[-4:]==?".git"
        execute "cd ".l:git_root
        let l:tags_path=l:git_folder.'/tags'
        execute "set tags+=".l:tags_path.";"
        execute "!start ctags --sort=yes --append=no -f ".l:tags_path." -R ".l:git_root
        execute "cd ".l:current_folder
    else
        echomsg "None .git error"
    endif
endfunction
command! GitaCtagsCommand call GitCtags()
nnoremap <C-F3> :<C-u>GitaCtagsCommand<CR>


function! OpenWorkText() abort
	let l:work_text_folder_path = "~/worktexts/"
	let l:work_text_file_path = l:work_text_folder_path.strftime("%Y_%m_%d.txt")
	execute "tab drop ".l:work_text_file_path
	execute "set filetype=worktext"
endfunction
command! OpenWorkTextCommand call OpenWorkText()
nnoremap <Space>ew :<C-u>OpenWorkTextCommand<CR>

function! s:DictionaryTranslate(...)
    let l:word = a:0 == 0 ? expand('<cword>') : a:1
    call histadd('cmd', 'DictionaryTranslate '  . l:word)
    if l:word ==# '' | return | endif
    let l:gene_path = expand('~/.vim/dict/gene.txt')
    let l:jpn_to_eng = l:word !~? '^[a-z_]\+$'
    let l:output_option = l:jpn_to_eng ? '-B 1' : '-A 1' " 和英 or 英和

    silent pedit Translate\ Result | wincmd P | %delete " 前の結果が残っていることがあるため
    setlocal buftype=nofile noswapfile modifiable
    silent execute 'read !grep -ihw' l:output_option l:word l:gene_path
    silent 0delete
    let l:esc = @z
    let @z = ''
    while search("^" . l:word . "$", "Wc") > 0 " 完全一致したものを上部に移動
        silent execute line('.') - l:jpn_to_eng . "delete Z 2"
    endwhile
    silent 0put z
    let @z = l:esc
    silent call append(line('.'), '==')
    silent 1delete
    silent wincmd p
endfunction
command! -nargs=? -complete=command DictionaryTranslate call <SID>DictionaryTranslate(<f-args>)

nnoremap <Space>en :<C-u>DictionaryTranslate<CR>
nnoremap <Space>ei :<C-u>DictionaryTranslate<Space>

nnoremap <Space>em i<C-@>
nnoremap <Space>ec :<C-u>!start ConEmu64.exe<CR>

nnoremap <Space>eo :<C-u>e<Space>
nnoremap <Space>ej :<C-u>execute "normal".line(".")."gg"<CR>


nnoremap [substitute] <Nop>
nmap <Space>p [substitute]
vnoremap [substitute] <Nop>
vmap <Space>p [substitute]

nnoremap [substitute]e V:<C-u>'<,'>s/\([^[:blank:]+*><=%/!]\+\)\([+*><=%/!]=\{,2}\)\([^[:blank:]+*><=%/!]\+\)/\1 \2 \3/g<CR>
vnoremap [substitute]e :<C-u>'<,'>s/\([^[:blank:]+*><=%/!]\+\)\([+*><=%/!]=\{,2}\)\([^[:blank:]+*><=%/!]\+\)/\1 \2 \3/g<CR>

nnoremap [substitute]c V:<C-u>'<,'>s/\(\S\+\),\(\S\+\)/\1, \2/g<CR>
vnoremap [substitute]c :<C-u>'<,'>s/\(\S\+\),\(\S\+\)/\1, \2/g<CR>

nnoremap [substitute]n V:<C-u>'<,'>s/^\n//g<CR>
vnoremap [substitute]n :<C-u>'<,'>s/^\n//g<CR>

nnoremap [substitute]f  :<C-u>%s///g<Left><Left><Left>
vnoremap [substitute]f  :s///g<Left><Left><Left>

nnoremap [substitute]w :<C-u>%s///g<Left><Left><Left><C-r><C-w><Right><C-r><C-w>
nnoremap [substitute]v <Right>byegv:<C-u>'<,'>s///g<Left><Left><Left><C-r>"<Right>


nnoremap [yank] <Nop>
nmap <Space>y [yank]

function! s:yank_now(delimiter) abort
    execute "normal <C-u>"
    if a:delimiter==""
        let a:delimiter="_"
    endif
    let now = strftime(join(split("%Y_%m_%d","_"),a:delimiter))
    let @+ = now
    echomsg "yank ".now
endfunction
function! s:yank_now_with_slash() abort
    call s:yank_now("\/")
endfunction
nnoremap [yank]n :<C-u>call <SID>yank_now_with_slash()<CR>

function! s:yank_file_name() abort
    let file_name = expand("%")
    let @+ = file_name
    echomsg "yank ".file_name
endfunction
nnoremap [yank]f :<C-u>call <SID>yank_file_name()<CR>

function! s:yank_file_path() abort
    let file_name = expand("%:p")
    let @+ = file_name
    echomsg "yank ".file_name
endfunction
nnoremap [yank]p :<C-u>call <SID>yank_file_path()<CR>

function! s:yank_last_command() abort
    let last_command = @:
    let @+ = last_command
    echomsg "yank ". last_command
endfunction
nnoremap [yank]; :<C-u>call <SID>yank_last_command()<CR>

function! s:yank_last_search() abort
    let last_search = @/
    let @+ = last_search
    echomsg "yank ". last_search
endfunction
nnoremap [yank]/ :<C-u>call <SID>yank_last_search()<CR>


vmap ip i)
vmap il i]
vmap iw i"
vmap iq i'
vmap id i}
vmap ib i`

vmap ap a)
vmap al a]
vmap aw a"
vmap aq a'
vmap ad a}
vmap ab a`

omap ip i)
omap il i]
omap iw i"
omap iq i'
omap id i}
omap ib i`

omap ap a)
omap al a]
omap aw a"
omap aq a'
omap ad a}
omap ab a`


nnoremap <Leader>cm :<C-u>Capture messages<CR>

nnoremap q <C-r>
nnoremap R r
vnoremap R r


function! s:cinoremap(lhs, rhs) abort
    silent execute join(["inoremap", a:lhs, a:rhs])
    silent execute join(["cnoremap", a:lhs, a:rhs])
endfunction

" 移動
call s:cinoremap("<C-h>", "<Left>")
call s:cinoremap("<C-j>", "<Down>")
call s:cinoremap("<C-k>", "<Up>")
call s:cinoremap("<C-l>", "<Right>")
call s:cinoremap("<M-b>", "<C-Left>")
call s:cinoremap("<M-f>", "<C-Right>")
call s:cinoremap("<C-e>", "<End>")
inoremap <C-a> <C-r>=MyExecExCommand('normal ^')<CR>
inoremap <C-a> <Home>

" 編集
call s:cinoremap("<C-b>", "<BS>")
call s:cinoremap("<C-d>", "<Del>")
call s:cinoremap("<C-v>", "<C-r>\"")
inoremap <C-o> <C-g>u<C-r>=MyExecExCommand('normal o')<CR>
inoremap <M-j> <C-g>u<C-r>=MyExecExCommand('normal! J')<CR>
inoremap <M-d> <C-g>u<C-r>=MyExecExCommand('normal! D','onemore')<CR>

" undo redo
inoremap <M-u> <C-g>u<C-r>=MyExecExCommand('undo', 'onemore')<CR>
inoremap <M-r> <C-r>=MyExecExCommand('redo', 'onemore')<CR>

" インデント
inoremap <TAB> <C-t>
inoremap <S-TAB> <C-d>

" 電卓
inoremap j<Space><CR> <C-r>=

" 日本語入力固定切り替え
inoremap <F10> <C-^><C-r>=IMState('FixMode')<CR>

" 大文字入力切り替え
imap j<Space>j <Plug>CapsLockToggle

" カーソル位置の単語を大文字に変換(不完全)
inoremap j<Space><Space> <ESC><Right>gUbea

" 前に入力した文字を入力
inoremap j<Space>z <C-a>


""""""""""""""""""""""""""""""
"IMEの状態とカーソル位置保存のため<C-r>を使用してコマンドを実行。
""""""""""""""""""""""""""""""
function! MyExecExCommand(cmd, ...)
  let saved_ve = &virtualedit
  let index = 1
  while index <= a:0
    if a:{index} == 'onemore'
      silent setlocal virtualedit+=onemore
    endif
    let index = index + 1
  endwhile

  silent exec a:cmd
  if a:0 > 0
    silent exec 'setlocal virtualedit='.saved_ve
  endif
  return ''
endfunction


" " Arpeggio cnoremap and inoremap
function! s:arpeggio_cinoremap(lhs, rhs) abort
    call arpeggio#map('i', '', 0, a:lhs, a:rhs)
    call arpeggio#map('c', '', 0, a:lhs, a:rhs)
endfunction

call arpeggio#load()
call s:arpeggio_cinoremap("dsa", "<Home>")
call s:arpeggio_cinoremap("kl;", "<End>")


function! s:cinoremap_with_prefix(lhs_prefix_key, lhs_suffix_key, rhs) abort
    call s:cinoremap(a:lhs_prefix_key . a:lhs_suffix_key, a:rhs)
endfunction
let s:MAIN_INPUT_PREFIX_KEY = "j<Space>"
let s:SUB_INPUT_PREFIX_KEY = "jk"

call s:cinoremap_with_prefix(s:MAIN_INPUT_PREFIX_KEY, "a" ,"-")
call s:cinoremap_with_prefix(s:MAIN_INPUT_PREFIX_KEY, "e" ,"=")
call s:cinoremap_with_prefix(s:MAIN_INPUT_PREFIX_KEY, "s" ,"_")
call s:cinoremap_with_prefix(s:MAIN_INPUT_PREFIX_KEY, "w" ,"\"\"<Left>")
call s:cinoremap_with_prefix(s:MAIN_INPUT_PREFIX_KEY, "b" ,"``<Left>")
call s:cinoremap_with_prefix(s:MAIN_INPUT_PREFIX_KEY, "l" ,"[]<Left>")
call s:cinoremap_with_prefix(s:MAIN_INPUT_PREFIX_KEY, "t" ,"<><Left>")
call s:cinoremap_with_prefix(s:MAIN_INPUT_PREFIX_KEY, "p" ,"()<Left>")
call s:cinoremap_with_prefix(s:MAIN_INPUT_PREFIX_KEY, "d" ,"{}<Left>")
call s:cinoremap_with_prefix(s:MAIN_INPUT_PREFIX_KEY, "q" ,"''<Left>")
call s:cinoremap_with_prefix(s:MAIN_INPUT_PREFIX_KEY, "h" ,"<C-r>\"")
call s:cinoremap_with_prefix(s:MAIN_INPUT_PREFIX_KEY, "k" ,"<End><C-u>")
call s:cinoremap_with_prefix(s:MAIN_INPUT_PREFIX_KEY, "u" ,"<C-u>")
call s:cinoremap_with_prefix(s:MAIN_INPUT_PREFIX_KEY, "c" ,"<End><C-u><C-u>")

call s:cinoremap_with_prefix(s:SUB_INPUT_PREFIX_KEY, "a", "&")
call s:cinoremap_with_prefix(s:SUB_INPUT_PREFIX_KEY, "h", "^")
call s:cinoremap_with_prefix(s:SUB_INPUT_PREFIX_KEY, "p", "+")
call s:cinoremap_with_prefix(s:SUB_INPUT_PREFIX_KEY, "s", "#")
call s:cinoremap_with_prefix(s:SUB_INPUT_PREFIX_KEY, "r", "%")
call s:cinoremap_with_prefix(s:SUB_INPUT_PREFIX_KEY, "m", "@")
call s:cinoremap_with_prefix(s:SUB_INPUT_PREFIX_KEY, "t", "~")
call s:cinoremap_with_prefix(s:SUB_INPUT_PREFIX_KEY, "d", "$")
call s:cinoremap_with_prefix(s:SUB_INPUT_PREFIX_KEY, "e", "!")
call s:cinoremap_with_prefix(s:SUB_INPUT_PREFIX_KEY, "b", "`")
call s:cinoremap_with_prefix(s:SUB_INPUT_PREFIX_KEY, "c", ":")
call s:cinoremap_with_prefix(s:SUB_INPUT_PREFIX_KEY, "x", "*")
call s:cinoremap_with_prefix(s:SUB_INPUT_PREFIX_KEY, "q", "?")
call s:cinoremap_with_prefix(s:SUB_INPUT_PREFIX_KEY, ";", "\"")
call s:cinoremap_with_prefix(s:SUB_INPUT_PREFIX_KEY, ",", "'")
call s:cinoremap_with_prefix(s:SUB_INPUT_PREFIX_KEY, "y", "\\")
call s:cinoremap_with_prefix(s:SUB_INPUT_PREFIX_KEY, "w", "\"\"")
call s:cinoremap_with_prefix(s:SUB_INPUT_PREFIX_KEY, "o", "<Bar>")
call s:cinoremap_with_prefix(s:SUB_INPUT_PREFIX_KEY, "g", "=>")
call s:cinoremap_with_prefix(s:SUB_INPUT_PREFIX_KEY, "f", "->")

