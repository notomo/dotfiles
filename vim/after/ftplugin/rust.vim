setlocal completeopt-=preview
setlocal nomodeline
call notomo#mapping#lsp()

nnoremap <buffer> <silent> sgj <Cmd>call notomo#rust#next()<CR>
nnoremap <buffer> <silent> sgk <Cmd>call notomo#rust#prev()<CR>
nnoremap <buffer> [keyword]r <Cmd>call notomo#rust#doc(expand('<cword>'))<CR>
xnoremap <buffer> R :call notomo#rust#selected_doc()<CR>
