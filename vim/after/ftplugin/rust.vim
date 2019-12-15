setlocal completeopt-=preview
nnoremap <buffer> [keyword]o :<C-u>call LanguageClient_textDocument_definition()<CR>
nnoremap <buffer> [keyword]v :<C-u>vsplit \| call LanguageClient_textDocument_definition()<CR>
nnoremap <buffer> [keyword]h :<C-u>split \| call LanguageClient_textDocument_definition()<CR>
nnoremap <buffer> [keyword]t :<C-u>call notomo#window#duplicate() \| call LanguageClient_textDocument_definition()<CR>
nnoremap <buffer> [keyword]r :<C-u>call LanguageClient_textDocument_hover()<CR>
" nnoremap <buffer> [keyword]o :<C-u>lua vim.lsp.buf.definition()<CR>
" nnoremap <buffer> [keyword]v :<C-u>vsplit \| lua vim.lsp.buf.definition()<CR>
" nnoremap <buffer> [keyword]h :<C-u>split \| lua vim.lsp.buf.definition()<CR>
" nnoremap <buffer> [keyword]t :<C-u>call notomo#window#duplicate() \| lua vim.lsp.buf.definition()<CR>
" nnoremap <buffer> [keyword]r :<C-u>lua vim.lsp.buf.hover()<CR>

nnoremap <buffer> <silent> sgj :<C-u>call notomo#rust#next()<CR>
nnoremap <buffer> <silent> sgk :<C-u>call notomo#rust#prev()<CR>
