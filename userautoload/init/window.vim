
"ウィンドウ間を移動
nnoremap [move] <Nop>
nmap m [move]

nnoremap [move]h <C-w>h
nnoremap [move]j <C-w>j
nnoremap [move]k <C-w>k
nnoremap [move]l <C-w>l
nnoremap [move]w <C-w><C-w>
nnoremap [move]p <C-w>p

"ウィンドウ分割・解除
nnoremap [split] <Nop>
nmap <Space>s [split]
nnoremap [split]o :<C-u>only<CR>
nnoremap [split]h :<C-u>split<CR>
nnoremap [split]v :<C-u>vsplit<CR>
nnoremap [split]p <C-w>z

" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>
