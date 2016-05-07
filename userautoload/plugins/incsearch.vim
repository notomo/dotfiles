" map /  <Plug>(incsearch-migemo-/)
let g:incsearch#auto_nohlsearch = 1
" map /  <Plug>(incsearch-forward)
map / <Plug>(incsearch-easymotion-/)
" nmap <Space>/ <Plug>(incsearch-forward)<C-r><C-w>
nmap <Space>/ <Plug>(incsearch-easymotion-/)<C-r><C-w>
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
    IncSearchNoreMap <C-j> <Down>
    " IncSearchNoreMap <C-j> <Over>(buffer-complete)
    IncSearchNoreMap <C-k> <Up>
    IncSearchNoreMap <Space> <CR>
    IncSearchNoreMap <S-Space> <Space>
    " IncSearchNoreMap <C-k> <Over>(buffer-complete-prev)
    IncSearchNoreMap <C-n>  <Over>(incsearch-scroll-f)
    IncSearchNoreMap <C-p>    <Over>(incsearch-scroll-b)
endfunction

function! s:config_easymotion(...) abort
  return extend(copy({
  \   'modules': [incsearch#config#easymotion#module()],
  \   'keymap': {"\<Space>": '<Over>(easymotion)'},
  \   'pattern': "\'.*\'\\|\".*\"",
  \   'is_expr': 0,
  \   'is_stay': 0
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> gq incsearch#go(<SID>config_easymotion())
