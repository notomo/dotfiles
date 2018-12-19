
function! notomo#gesture#key(key, text) abort
    if !gesture#is_started()
        return a:key
    endif
    return ":\<C-u>call gesture#input_text('" . a:text . "')\<CR>"
endfunction
