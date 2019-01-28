setlocal noexpandtab
setlocal matchpairs+==:;
setlocal completeopt-=preview

if exists('loaded_matchit')
    call notomo#matchit#sql()
endif
