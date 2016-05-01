
nnoremap x "_x

nnoremap <F1> <Nop>

nnoremap <S-C-F7> :<C-u>%s/、/,/g<CR>
nnoremap <S-C-F8> :<C-u>%s/。/\./g<CR>
" nnoremap <Space>b g;
" nnoremap <Space>f g,
nnoremap <Space>v gv
nnoremap <Space>gd :<C-u>vimgrep //j *<Left><Left><Left><Left>
nnoremap <Space>gr :<C-u>grep! "" *<Left><Left><Left>
nnoremap <Space>gt :<C-u>cexpr ""<CR>:tabdo vimgrepadd //j %<Left><Left><Left><Left>
nnoremap <Space>gb :<C-u>cexpr ""<CR>:bufdo vimgrepadd //j %<Left><Left><Left><Left>

let g:mapleader=","

inoremap <silent> jj <ESC>
" 日本語入力で”っj”と入力してもEnterキーで確定させればインサートモードを抜ける
inoremap <silent> っｊ <ESC>
inoremap <silent> ｊｊ <ESC>
cnoremap <silent> jj <C-u><ESC>
onoremap jj <ESC>
vnoremap v <ESC>
nnoremap い i
nnoremap <Space>i I
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
nnoremap gs  :<C-u>%s///g<Left><Left><Left>
vnoremap gs  :s///g<Left><Left><Left>
nnoremap <Space>. @:
vnoremap <Space>. @:

nnoremap <Space>gs :<C-u>%s///g<Left><Left><Left><C-r><C-w><Right>
nnoremap <Space>gv <Right>byegv:<C-u>'<,'>s///g<Left><Left><Left><C-r>"<Right>

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

nnoremap <Space>fm :<C-u>SM 4<CR>
nnoremap <Space>fr :<C-u>SM 0<CR>

nnoremap ef :<C-u>set fenc=utf8<CR>
nnoremap es :<C-u>:NeoSnippetEdit<CR>

nnoremap <C-S-q> :<C-u>q!<CR>
nnoremap <Space>l <S-v>
nnoremap <Space>h <C-v>
nnoremap gz G
nnoremap <Space>j gu
nnoremap <Space>k gU
vnoremap <Space>j gu
vnoremap <Space>k gU

nnoremap <F7> :%s/ *$//<CR>
