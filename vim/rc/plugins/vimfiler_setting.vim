
call vimfiler#custom#profile('default', 'context', {
\ 'safe' : 0,
\ 'simple' : 1,
\ 'no-quit' : 1,
\ })
let g:vimfiler_enable_auto_cd = 1
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_ignore_pattern = ['^\.DS_Store$']
let g:vimfiler_no_default_key_mappings = 1

function! s:set_vimfiler()
    augroup my-filetype-vimfiler
        autocmd! * <buffer>
        autocmd CursorMoved <buffer> execute "normal \<Plug>(vimfiler_print_filename)"
    augroup END
endfunction

autocmd MyAuGroup FileType vimfiler call s:set_vimfiler()

