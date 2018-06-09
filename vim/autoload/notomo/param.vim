
function! notomo#param#mapping() abort
    inoremap <buffer> <expr> j<Space>p complete_parameter#pre_complete("()")
    smap <buffer> j<Space>; <Plug>(complete_parameter#goto_next_parameter)
    imap <buffer> j<Space>; <Plug>(complete_parameter#goto_next_parameter)
    smap <buffer> j<Space>n <Plug>(complete_parameter#goto_previous_parameter)
    imap <buffer> j<Space>n <Plug>(complete_parameter#goto_previous_parameter)
endfunction

