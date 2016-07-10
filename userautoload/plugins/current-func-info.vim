function! s:yank_current_function_name(name) abort
    if a:name != ""
        let @+ = a:name
        echomsg "yank ".a:name
    else
        echomsg "no_function"
    endif
endfunction
" nnoremap <Leader>fe :echomsg cfi#format("%s", "no_function")<CR>
nnoremap <silent> <Leader>f :<C-u>call <SID>yank_current_function_name(cfi#format("%s", "no_function"))<CR>
