setlocal foldmethod=marker
if exists('loaded_matchit')
    call notomo#matchit#vim()
endif
setlocal iskeyword-=#
