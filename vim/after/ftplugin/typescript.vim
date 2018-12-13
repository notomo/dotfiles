setlocal nomodeline
setlocal completeopt-=preview
setlocal tabstop=2
setlocal softtabstop=2
setlocal expandtab
nnoremap <buffer> [keyword]k :<C-u>TSType<CR>
nnoremap <buffer> [keyword]K :<C-u>TSDoc<CR>
nnoremap <buffer> [keyword]R :<C-u>TSRefs<CR>
nnoremap <buffer> [keyword]o :<C-u>TSDef<CR>
nnoremap <buffer> [keyword]v :<C-u>vsplit \| TSDef<CR>
nnoremap <buffer> [keyword]h :<C-u>split \| TSDef<CR>
nnoremap <buffer> [keyword]t :<C-u>call notomo#window#duplicate() \| TSDef<CR>
TSStart
