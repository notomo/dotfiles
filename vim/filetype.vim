if exists('g:did_load_filetypes') || !exists('g:notomo_filetype_map')
    finish
endif
augroup filetypedetect
    for [s:pattern, s:filetype] in items(g:notomo_filetype_map)
        execute printf('autocmd! BufRead,BufNewFile %s setfiletype %s', s:pattern, s:filetype)
    endfor
augroup END
