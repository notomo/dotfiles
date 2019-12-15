setlocal completeopt-=preview
setlocal noexpandtab
nnoremap <buffer> [keyword]o :<C-u>call LanguageClient#textDocument_definition()<CR>
nnoremap <buffer> [keyword]v :<C-u>vsplit \| call LanguageClient_textDocument_definition()<CR>
nnoremap <buffer> [keyword]h :<C-u>split \| call LanguageClient_textDocument_definition()<CR>
nnoremap <buffer> [keyword]t :<C-u>call notomo#window#duplicate() \| call LanguageClient_textDocument_definition()<CR>
" nnoremap <buffer> [keyword]o <Cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <buffer> [keyword]v :<C-u>vsplit \| lua vim.lsp.buf.definition()<CR>
" nnoremap <buffer> [keyword]h :<C-u>split \| lua vim.lsp.buf.definition()<CR>
" nnoremap <buffer> [keyword]t :<C-u>call notomo#window#duplicate() \| lua vim.lsp.buf.definition()<CR>

nnoremap <buffer> <silent> [yank]I :<C-u>call notomo#vimrc#yank_and_echo(trim(system('go list -f "{{.ImportPath}}" ./')))<CR>
nnoremap <buffer> <silent> [denite]K :<C-u>call notomo#denite#go_package_dir()<CR>
nnoremap <buffer> <silent> [denite]o :<C-u>Denite go/symbol<CR>
nnoremap <buffer> <silent> sgj :<C-u>call notomo#go#next()<CR>
nnoremap <buffer> <silent> sgk :<C-u>call notomo#go#prev()<CR>

syntax keyword goKeywords nil iota true false
highlight link goKeywords Boolean
