setlocal completeopt-=preview
setlocal nomodeline
call notomo#lsp#mapping()

nnoremap <buffer> <silent> sgj :<C-u>call notomo#rust#next()<CR>
nnoremap <buffer> <silent> sgk :<C-u>call notomo#rust#prev()<CR>
nnoremap <buffer> [keyword]r :<C-u>call notomo#rust#doc(expand('<cword>'))<CR>
xnoremap <buffer> R :call notomo#rust#selected_doc()<CR>
