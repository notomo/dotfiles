let b:caw_wrap_oneline_comment = ['<%#', '%>']
setlocal tabstop=2
setlocal softtabstop=2
setlocal expandtab
if exists('loaded_matchit')
    call notomo#matchit#ejs()
endif
