setlocal nomodeline
setlocal completeopt-=preview
setlocal tabstop=2
setlocal softtabstop=2
nnoremap <buffer> [exec]s <Cmd>luafile %<CR>
nnoremap <buffer> <expr> [exec]l ':lua ' . getline('.') . '<CR>'
call notomo#mapping#lsp()
call ale#fix#registry#Add('luaformat', 'ale#fixers#luaformat#Fix', ['lua'], '')
inoreabbrev <buffer> != ~=
if expand("%")  =~? '_spec.lua$'
    nnoremap <buffer> [finder]o <Cmd>lua require("thetto").start("lua/busted", {opts = {auto = "preview"}})<CR>
endif
