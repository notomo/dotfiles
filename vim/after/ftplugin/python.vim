setlocal completeopt-=preview
setlocal nomodeline
let b:cursorword = 0
call notomo#python#semshi_mapping()
nnoremap <buffer> [keyword]o :<C-u>call LanguageClient_textDocument_definition()<CR>
nnoremap <buffer> [keyword]v :<C-u>vsplit \| call LanguageClient_textDocument_definition()<CR>
nnoremap <buffer> [keyword]h :<C-u>split \| call LanguageClient_textDocument_definition()<CR>
nnoremap <buffer> [keyword]t :<C-u>call notomo#window#duplicate() \| call LanguageClient_textDocument_definition()<CR>
