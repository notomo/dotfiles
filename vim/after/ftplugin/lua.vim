setlocal nomodeline
setlocal completeopt-=preview
setlocal tabstop=2
setlocal softtabstop=2
nnoremap <buffer> [exec]s :<C-u>luafile %<CR>
nnoremap <buffer> <expr> [exec]l ':lua ' . getline('.') . '<CR>'
call notomo#lsp#mapping()
call ale#fix#registry#Add('luaformat', 'ale#fixers#luaformat#Fix', ['lua'], '')
inoreabbrev <buffer> != ~=
if expand("%")  =~? '_spec.lua$'
    nnoremap [finder]o <Cmd>Thetto lua/busted --auto=preview<CR>
endif
