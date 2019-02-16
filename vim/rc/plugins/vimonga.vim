
autocmd MyAuGroup FileType vimonga-db call s:vimonga_db()
function! s:vimonga_db() abort
    nnoremap <buffer> t<Space> :<C-u>call vimonga#database_action('open')<CR>
endfunction

call vimonga#config#set('default_port', 27020)
