setlocal nomodeline
setlocal completeopt-=preview
setlocal tabstop=2
setlocal softtabstop=2
nnoremap <buffer> [exec]s <Cmd>luafile %<CR>
nnoremap <buffer> <expr> [exec]l ':lua ' . getline('.') . '<CR>'
lua require("notomo.mapping").lsp()
call ale#fix#registry#Add('luaformat', 'ale#fixers#luaformat#Fix', ['lua'], '')
inoreabbrev <buffer> != ~=
if expand("%")  =~? '_spec.lua$'
    nnoremap <buffer> [finder]o <Cmd>lua require("thetto").start("lua/busted", {opts = {auto = "preview"}})<CR>
endif

nnoremap <buffer> <silent> sgj <Cmd>lua require("notomo.text_object").next_no_indent_function()<CR>
nnoremap <buffer> <silent> sgk <Cmd>lua require("notomo.text_object").prev_no_indent_function()<CR>
