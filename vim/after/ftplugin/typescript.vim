setlocal nomodeline
setlocal completeopt-=preview
setlocal tabstop=2
setlocal softtabstop=2
setlocal expandtab
nnoremap <buffer> [keyword]o :<C-u>call LanguageClient#textDocument_definition()<CR>
nnoremap <buffer> [keyword]v :<C-u>vsplit \| call LanguageClient_textDocument_definition()<CR>
nnoremap <buffer> [keyword]h :<C-u>split \| call LanguageClient_textDocument_definition()<CR>
nnoremap <buffer> [keyword]t :<C-u>call notomo#window#duplicate() \| call LanguageClient_textDocument_definition()<CR>
