autocmd MyAuGroup TermOpen * nnoremap <buffer> F <Cmd>lua require('flompt').open()<CR>

autocmd MyAuGroup FileType flompt call s:flompt_settings()
function! s:flompt_settings() abort
    inoremap <buffer> <CR> <Cmd>lua require('flompt').send()<CR>
    nnoremap <buffer> <CR> <Cmd>lua require('flompt').send()<CR>
    nnoremap <nowait> <buffer> q <Cmd>lua require('flompt').close()<CR>
    inoremap <buffer> jq <ESC><Cmd>lua require('flompt').close()<CR>
endfunction
