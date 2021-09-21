setlocal completeopt-=preview
setlocal nomodeline
call notomo#mapping#lsp()

nnoremap <buffer> <silent> sgj <Cmd>TSTextobjectGotoNextStart @function.outer<CR>
nnoremap <buffer> <silent> sgk <Cmd>TSTextobjectGotoPreviousStart @function.outer<CR>
nnoremap <buffer> [keyword]r <Cmd>call notomo#rust#doc(expand('<cword>'))<CR>
xnoremap <buffer> R :call notomo#rust#selected_doc()<CR>
