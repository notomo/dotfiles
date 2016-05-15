
nnoremap x "_x

nnoremap <F1> <Nop>

nnoremap <S-C-F7> :<C-u>%s/、/,/g<CR>
nnoremap <S-C-F8> :<C-u>%s/。/\./g<CR>
" nnoremap <Space>b g;
" nnoremap <Space>f g,
nnoremap <Space>v gv
nnoremap <Space>Gd :<C-u>vimgrep //j *<Left><Left><Left><Left>
nnoremap <Space>Gr :<C-u>grep! "" *<Left><Left><Left>
nnoremap <Space>Gt :<C-u>cexpr ""<CR>:tabdo vimgrepadd //j %<Left><Left><Left><Left>
nnoremap <Space>Gb :<C-u>cexpr ""<CR>:bufdo vimgrepadd //j %<Left><Left><Left><Left>

let g:mapleader=","

inoremap <silent> jj <ESC>
" 日本語入力で”っj”と入力してもEnterキーで確定させればインサートモードを抜ける
inoremap <silent> っｊ <ESC>
inoremap <silent> ｊｊ <ESC>
cnoremap <silent> jj <C-u><ESC>
onoremap jj <ESC>
vnoremap v <ESC>
nnoremap い i
snoremap jj <ESC>


" nnoremap <TAB> >>
" nnoremap <S-TAB> <<
nnoremap <Space>ii >>
vnoremap <Space>ii >
nnoremap <Space>id <<
vnoremap <Space>id <

nnoremap <CR> o<ESC>
nnoremap <silent> <Space>n :<C-u>nohlsearch<CR>
nnoremap <Space>e :<C-u>e<Space>
nnoremap <Space>w :<C-u>w<CR>
nnoremap <Space>q :<C-u>q<CR>
nnoremap <Space>Q :<C-u>q!<CR>
nnoremap <Space>r :<C-u>file<Space>
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
nnoremap ej zzM

nnoremap <silent> <Space>o  :<C-u>for i in range(v:count1) \| call append(line('.'), '') \| endfor<CR>
nnoremap <silent> <Space>O  :<C-u>for i in range(v:count1) \| call append(line('.')-1, '') \| endfor<CR>
nnoremap <Space>pf  :<C-u>%s///g<Left><Left><Left>
vnoremap <Space>p  :s///g<Left><Left><Left>
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
nnoremap <Space>d <C-x>
nnoremap <Space>a <C-a>
" vnoremap <S-h> 0
" nnoremap <S-h> 0
nnoremap <silent> <S-l> :<C-u>keepjumps normal %<CR>
nnoremap <silent> <S-j> :<C-u>keepjumps normal }<CR>
nnoremap <silent> <S-k> :<C-u>keepjumps normal {<CR>

nnoremap <silent> <F5> <Esc>:<C-u>source $MYVIMRC<CR>:<C-u>source $MYGVIMRC<CR>:<C-u>nohlsearch<CR>

nnoremap <Leader>cd :<C-u>CdCurrent<CR>

nnoremap <Leader>fm :<C-u>SM 4<CR>
nnoremap <Leader>fr :<C-u>SM 0<CR>


nnoremap <M-C-S-q> :<C-u>qa<CR>
nnoremap <Space>l <S-v>
nnoremap <Space>h <C-v>
nnoremap gz G
nnoremap <Space>j gu
nnoremap <Space>k gU
vnoremap <Space>j gu
vnoremap <Space>k gU

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

nnoremap <Leader>do :<C-u>UniteWithCursorWord -immediately tag<CR>
nnoremap <Leader>dv :<C-u>vsplit<CR><C-w>l:UniteWithCursorWord -immediately tag<CR>
nnoremap <Leader>dh :<C-u>hsplit<CR><C-w>j:UniteWithCursorWord -immediately tag<CR>

nnoremap <Leader>di :<C-u>Diff<Space>

nnoremap <Leader>x dlp

nnoremap q <Nop>
vnoremap q <Nop>
