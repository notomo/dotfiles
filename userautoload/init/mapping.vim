
nnoremap <Space><Leader>q :<C-u>tabclose<CR>

nnoremap x "_x

nnoremap <F1> <Nop>

" nnoremap <S-C-F7> :<C-u>%s/、/,/g<CR>
" nnoremap <S-C-F8> :<C-u>%s/。/\./g<CR>
" nnoremap <Space>b g;
" nnoremap <Space>f g,
nnoremap <Space>v gv
nnoremap <Space>io gi

nnoremap <Space>Gd :<C-u>vimgrep //j *<Left><Left><Left><Left>
nnoremap <Space>Gr :<C-u>grep! "" *<Left><Left><Left>
nnoremap <Space>Gt :<C-u>cexpr ""<CR>:tabdo vimgrepadd //j %<Left><Left><Left><Left>
nnoremap <Space>Gb :<C-u>cexpr ""<CR>:bufdo vimgrepadd //j %<Left><Left><Left><Left>

" nnoremap <Space>G :<C-u>grep  **/*.<Left><Left><Left><Left><Left><Left>


inoremap <silent> jj <ESC>
" 日本語入力で”っj”と入力してもEnterキーで確定させればインサートモードを抜ける
inoremap <silent> っｊ <ESC>
inoremap <silent> ｊｊ <ESC>
cnoremap <silent> jj <C-u><ESC>
onoremap jj <ESC>
vnoremap v <ESC>
nnoremap い i
nnoremap あ a
snoremap jj <ESC>


" nnoremap <TAB> >>
" nnoremap <S-TAB> <<
nnoremap <Space>ii >>
vnoremap <Space>ii >
nnoremap <Space>id <<
vnoremap <Space>id <

nnoremap <CR> o<ESC>
nnoremap <silent> <Space>n :<C-u>nohlsearch<CR>
nnoremap <Space>eo :<C-u>e<Space>
nnoremap <Space>w :<C-u>w<CR>
" nnoremap <Space>q :<C-u>q<CR>
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
" nnoremap gk  k
" nnoremap gj  j
" vnoremap gk  k
" vnoremap gj  j

" nnoremap <BS> i<BS><Right><ESC>

nnoremap ;  :
nnoremap :  ;
vnoremap ;  :
vnoremap :  ;

" 前のバッファへ移動
nnoremap <Space>b <C-^>

" noremap gh H8k
" noremap gl L8j
" noremap gm M
noremap ge $
noremap ga ^
noremap gh 0
noremap g; ;
noremap g, ,
nnoremap go <C-o>
nnoremap gi <C-i>
nnoremap gO g;
nnoremap gI g,
nnoremap <C-i> <C-i>
nnoremap <C-o> <C-o>
nnoremap <Space>ej :<C-u>execute "normal".line(".")."gg"<CR>

nnoremap <silent> oo  :for i in range(v:count1) \| call append(line('.'), '') \| endfor<CR>

nnoremap <silent> of  :for i in range(v:count1) \| call append(line('.'), '') \| endfor<CR>:<C-u>execute "normal j"<CR>

nnoremap <silent> oh  :<C-u>for i in range(v:count1) \| call append(line('.')-1, '') \| endfor<CR>
nnoremap <silent> oa  :<C-u>for i in range(v:count1) \| call append(line('.')-1, '') \| endfor<CR>
nnoremap oj o
nnoremap ok O
nnoremap os o
nnoremap od O
nnoremap <Space>pf  :<C-u>%s///g<Left><Left><Left>
vnoremap <Space>pf  :s///g<Left><Left><Left>
nnoremap <Space>. @:
vnoremap <Space>. @:

nnoremap <Space>pw :<C-u>%s///g<Left><Left><Left><C-r><C-w><Right>
nnoremap <Space>pv <Right>byegv:<C-u>'<,'>s///g<Left><Left><Left><C-r>"<Right>

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

nnoremap [file_encode] <Nop>
nmap <Space>f [file_encode]

nnoremap [file_encode]i :<C-u>set fileencoding=
nnoremap [file_encode]u :<C-u>set fileencoding=utf8<CR>
nnoremap [file_encode]e :<C-u>set fileencoding=euc-jp<CR>
nnoremap [file_encode]s :<C-u>set fileencoding=shift_jis<CR>
nnoremap [file_encode]od :<C-u>set fileformat=dos<CR>
nnoremap [file_encode]om :<C-u>set fileformat=mac<CR>
nnoremap [file_encode]ou :<C-u>set fileformat=unix<CR>

" nnoremap <Leader>do :<C-u>UniteWithCursorWord -immediately tag<CR>
" nnoremap <Leader>dv :<C-u>vsplit<CR><C-w>l:UniteWithCursorWord -immediately tag<CR>
" nnoremap <Leader>dh :<C-u>hsplit<CR><C-w>j:UniteWithCursorWord -immediately tag<CR>

function! TabTagOpen() abort
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
command! TabTagOpenCommand call TabTagOpen()

function! VerticalTagOpen() abort
    try
        execute "tag ".expand("<cword>")
        execute "vsplit"
        execute "normal \<C-o>"
    catch
        echo "Not found tag"
    endtry
endfunction
command! VerticalTagOpenCommand call VerticalTagOpen()

nnoremap <Leader>do <C-]>
nnoremap <Leader>dv :<C-u>VerticalTagOpenCommand<CR>
nnoremap <Leader>dt :<C-u>TabTagOpenCommand<CR>
nnoremap <Leader>dh <C-w>]

nnoremap <Leader>di :<C-u>MyDiff<Space>
nnoremap <Leader>dg :<C-u>DiffOrig<CR>

nnoremap <Leader>x dlp

nnoremap q <Nop>
vnoremap q <Nop>

function! s:yank_now() abort
    let delimiter = input("delimiter:")
    execute "normal <C-u>"
    if delimiter==""
        let delimiter="_"
    endif
	let now = strftime(join(split("%Y_%m_%d","_"),delimiter))
	let @+ = now
	echomsg "yank ".now
endfunction
nnoremap <Space>yn :<C-u>call <SID>yank_now()<CR>

function! s:yank_file_name() abort
    let file_name = expand("%")
    let @+ = file_name
    echomsg "yank ".file_name
endfunction
nnoremap <Space>yf :<C-u>call <SID>yank_file_name()<CR>

function! s:yank_file_path() abort
    let file_name = expand("%:p")
    let @+ = file_name
    echomsg "yank ".file_name
endfunction
nnoremap <Space>yp :<C-u>call <SID>yank_file_path()<CR>

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

vnoremap <Space>it :retab<CR>
nnoremap <Space>it V:retab<CR>


nnoremap <Space>pe V:<C-u>'<,'>s/\([^[:blank:]+*><=%/!]\+\)\([+*><=%/!]=\{,2}\)\([^[:blank:]+*><=%/!]\+\)/\1 \2 \3/g<CR>
vnoremap <Space>pe :<C-u>'<,'>s/\([^[:blank:]+*><=%/!]\+\)\([+*><=%/!]=\{,2}\)\([^[:blank:]+*><=%/!]\+\)/\1 \2 \3/g<CR>

nnoremap <Space>pc V:<C-u>'<,'>s/\(\S\+\),\(\S\+\)/\1, \2/g<CR>
vnoremap <Space>pc :<C-u>'<,'>s/\(\S\+\),\(\S\+\)/\1, \2/g<CR>

nnoremap <Space>pn V:<C-u>'<,'>s/^\n//g<CR>
vnoremap <Space>pn :<C-u>'<,'>s/^\n//g<CR>

nnoremap <Space>ec :<C-u>!start ConEmu64.exe<CR>

nnoremap <Ins> <Nop>
inoremap <Ins> <Nop>

function! s:yank_last_command() abort
    let last_command = @:
	let @+ = last_command
    echomsg "yank ". last_command
endfunction
nnoremap <Space>y; :<C-u>call <SID>yank_last_command()<CR>

function! s:yank_last_search() abort
    let last_search = @/
	let @+ = last_search
    echomsg "yank ". last_search
endfunction
nnoremap <Space>y/ :<C-u>call <SID>yank_last_search()<CR>

vmap ip i)
vmap il i]
vmap iw i"
vmap iq i'
vmap id i}

vmap ap a)
vmap al a]
vmap aw a"
vmap aq a'
vmap ad a}

omap ip i)
omap il i]
omap iw i"
omap iq i'
omap id i}

omap ap a)
omap al a]
omap aw a"
omap aq a'
omap ad a}
