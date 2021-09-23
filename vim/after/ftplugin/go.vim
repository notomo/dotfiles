setlocal completeopt-=preview
setlocal noexpandtab
lua require("notomo.mapping").lsp()

nnoremap <buffer> <silent> [yank]I <Cmd>lua require("notomo.edit").yank(vim.fn.trim(vim.fn.system('go list -f "{{.ImportPath}}" ./')))<CR>
nnoremap <buffer> <silent> sgj <Cmd>lua require("notomo.text_object").next_no_indent_function()<CR>
nnoremap <buffer> <silent> sgk <Cmd>lua require("notomo.text_object").prev_no_indent_function()<CR>
nnoremap <buffer> [exec]bL <Cmd>lua require("cmdhndlr").build()<CR>

syntax keyword goKeywords nil iota true false
highlight link goKeywords Boolean

inoreabbrev <buffer> ~= !=
