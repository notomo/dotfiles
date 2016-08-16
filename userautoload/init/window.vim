
"ウィンドウ間を移動
nnoremap [move] <Nop>
nmap m [move]

nnoremap [move]h <C-w>h
nnoremap [move]a <C-w>h
nnoremap [move]j <C-w>j
nnoremap [move]s <C-w>j
nnoremap [move]k <C-w>k
nnoremap [move]d <C-w>k
nnoremap [move]l <C-w>l
nnoremap [move]f <C-w>l
nnoremap [move]w <C-w><C-w>
nnoremap [move]p <C-w>p

"ウィンドウ分割・解除
nnoremap [split] <Nop>
nmap <Space>s [split]
nnoremap [split]o :<C-u>only<CR>
nnoremap [split]h :<C-u>split<CR>
nnoremap [split]v :<C-u>vsplit<CR>
nnoremap [split]s :<C-u>vsplit<CR>
nnoremap [split]p <C-w>z

nnoremap [split]m :<C-u>SM 4<CR>
nnoremap [split]r :<C-u>SM 0<CR>

" Shift + 矢印でウィンドウサイズを変更
nnoremap [move]<Space>h  <C-w><<CR>
nnoremap [move]<Space>k  <C-w>-<CR>
nnoremap [move]<Space>j  <C-w>+<CR>
nnoremap [move]<Space>l  <C-w>><CR>
nnoremap [move]e  <C-w>=<CR>
