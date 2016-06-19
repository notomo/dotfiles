let s:bundle=neobundle#get('incsearch.vim')
function! s:bundle.hooks.on_source(bundle)
    let g:incsearch#auto_nohlsearch = 1
endfunction
unlet s:bundle

map / <Plug>(incsearch-easymotion-/)
nmap <Leader>/ <Plug>(incsearch-easymotion-/)<C-r>"
map <Space>k <Plug>(incsearch-easymotion-?)
nmap <Leader><Space>k <Plug>(incsearch-easymotion-?)<C-r>"
map <Space>j <Plug>(incsearch-easymotion-stay)
nmap <Leader><Space>j <Plug>(incsearch-easymotion-stay)<C-r>"
nmap <Space>/ <Plug>(incsearch-easymotion-/)<C-r><C-w>
map   n <Plug>(incsearch-nohl-n)
map   N <Plug>(incsearch-nohl-N)
nmap  n <Plug>(incsearch-nohl)<Plug>(anzu-n-with-echo)
nmap  N <Plug>(incsearch-nohl)<Plug>(anzu-N-with-echo)

IncSearchNoreMap <Tab> <Over>(incsearch-next)
IncSearchNoreMap <S-Tab>  <Over>(incsearch-prev)
IncSearchNoreMap <C-j> <Down>
IncSearchNoreMap <C-k> <Up>
IncSearchNoreMap <Space> <CR>
IncSearchNoreMap <S-Space> <Space>
IncSearchNoreMap <C-n>  <Over>(incsearch-scroll-f)
IncSearchNoreMap <C-p>    <Over>(incsearch-scroll-b)

function! s:word_easymotion(...) abort
  return extend(copy({
  \   'modules': [incsearch#config#easymotion#module()],
  \   'keymap': {"\<Space>": '<Over>(easymotion)'},
  \   'pattern': "\'.*\'\\|\".*\"",
  \   'is_expr': 0,
  \   'is_stay': 0
  \ }), get(a:, 1, {}))
endfunction

function! s:tag_easymotion(...) abort
  return extend(copy({
  \   'modules': [incsearch#config#easymotion#module()],
  \   'keymap': {"\<Space>": '<Over>(easymotion)'},
  \   'pattern': ">.*<",
  \   'is_expr': 0,
  \   'is_stay': 0
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> gq incsearch#go(<SID>word_easymotion())
noremap <silent><expr> g, incsearch#go(<SID>tag_easymotion())
