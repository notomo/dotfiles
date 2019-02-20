setlocal foldmethod=marker
if exists('loaded_matchit')
    call notomo#matchit#vim()
endif
setlocal iskeyword-=#

nnoremap <buffer> [exec]s :<C-u>source %<CR>
