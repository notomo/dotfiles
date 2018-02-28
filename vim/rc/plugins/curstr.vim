
nnoremap <silent> [keyword]fo :<C-u>Curstr -action=open<CR>
nnoremap <silent> [keyword]ft :<C-u>Curstr -action=tab_open<CR>
nnoremap <silent> [keyword]fv :<C-u>Curstr -action=vertical_open<CR>
nnoremap <silent> [keyword]fh :<C-u>Curstr -action=horizontal_open<CR>
nnoremap <silent> [keyword]f<CR> :<C-u>Curstr<CR>

call curstr#custom#filetype_action_source('php', ['tag', 'blade'])
call curstr#custom#filetype_alias('blade', 'php')
call curstr#custom#filetype_action_source('vim', ['file', 'vim/function', 'vim/help'])
call curstr#custom#filetype_action_source('python', ['vim/function'])
call curstr#custom#action_source_alias('openable', ['file', 'directory'])
call curstr#custom#filetype_action_source('_', ['openable'])
call curstr#custom#execute_option('use-cache', v:false)
