setlocal foldmethod=marker
if exists('loaded_matchit')
    call notomo#matchit#vim()
endif
setlocal iskeyword-=#

nnoremap <buffer> [exec]s :<C-u>source %<CR>
nnoremap <buffer> <silent> sgj :<C-u>call notomo#vim#next()<CR>
nnoremap <buffer> <silent> sgk :<C-u>call notomo#vim#prev()<CR>
call notomo#lsp#mapping()
