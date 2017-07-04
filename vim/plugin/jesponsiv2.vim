
function! s:jesponse_cursor_url() abort
    let url = expand('<cWORD>')
    if url !=? ''
        execute 'Jesponse ' . url
    else
        echomsg 'Invalid url'
    endif
endfunction
command! JesponseCursorUrl call s:jesponse_cursor_url()

