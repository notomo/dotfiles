setlocal foldmethod=marker
if exists('loaded_matchit')
    call notomo#matchit#vim()
endif
setlocal iskeyword-=#

nnoremap <buffer> [exec]s <Cmd>source %<CR>
nnoremap <buffer> <silent> sgj <Cmd>call notomo#vim#next()<CR>
nnoremap <buffer> <silent> sgk <Cmd>call notomo#vim#prev()<CR>
call notomo#mapping#lsp()
