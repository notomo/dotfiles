" Prefix: s
nnoremap [ctrlp] <Nop>
nmap <Leader>f [ctrlp]

nnoremap [ctrlp]a :<C-u>CtrlP<Space>
nnoremap [ctrlp]b :<C-u>CtrlPBuffer<CR>
nnoremap [ctrlp]d :<C-u>CtrlPDir<CR>
nnoremap [ctrlp]f :<C-u>CtrlP<CR>
nnoremap [ctrlp]l :<C-u>CtrlPLine<CR>
nnoremap [ctrlp]m :<C-u>CtrlPMRUFiles<CR>
nnoremap [ctrlp]q :<C-u>CtrlPQuickfix<CR>
nnoremap [ctrlp]s :<C-u>CtrlPMixed<CR>
nnoremap [ctrlp]t :<C-u>CtrlPTag<CR>

let g:ctrlp_map = '<Nop>'
" Guess vcs root dir
let g:ctrlp_working_path_mode = 'ra'
" Open new file in current window
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_extensions = ['tag', 'quickfix', 'dir', 'line', 'mixed']
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:18'
