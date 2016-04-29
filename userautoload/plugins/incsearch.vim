" map /  <Plug>(incsearch-migemo-/)
let g:incsearch#auto_nohlsearch = 1
map /  <Plug>(incsearch-forward)
nmap <Space>/ <Plug>(incsearch-forward)<C-r><C-w>
map   n <Plug>(incsearch-nohl-n)
map   N <Plug>(incsearch-nohl-N)
nmap  n <Plug>(incsearch-nohl)<Plug>(anzu-n-with-echo)
nmap  N <Plug>(incsearch-nohl)<Plug>(anzu-N-with-echo)
augroup incsearch-keymap
    autocmd!
    autocmd VimEnter * call s:incsearch_keymap()
augroup END
function! s:incsearch_keymap()
    IncSearchNoreMap <Tab> <Over>(incsearch-next)
    IncSearchNoreMap <S-Tab>  <Over>(incsearch-prev)
    " IncSearchNoreMap <Tab> <Over>(buffer-complete)
    " IncSearchNoreMap <S-Tab> <Over>(buffer-complete-prev)
    IncSearchNoreMap <C-j> <Down>
    " IncSearchNoreMap <C-j> <Over>(buffer-complete)
    IncSearchNoreMap <C-k> <Up>
    " IncSearchNoreMap <C-k> <Over>(buffer-complete-prev)
    IncSearchNoreMap <C-n>  <Over>(incsearch-scroll-f)
    IncSearchNoreMap <C-p>    <Over>(incsearch-scroll-b)
endfunction

" highlight IncSearchCursor ctermfg=0 ctermbg=9 guifg=#000000 guibg=#FF0000
" highlight IncSearchMatchReverse ctermfg=242 guifg=#000000 guifg=#777777
" highlight IncSearchMatch ctermfg=81 guifg=#000000 guifg=#66D9EF
