
nnoremap [exec]v :<C-u>Vimonga database<CR>

autocmd MyAuGroup FileType vimonga-db call s:vimonga_db()
function! s:vimonga_db() abort
    nnoremap <buffer> l :<C-u>call vimonga#action('database', 'open')<CR>
    nnoremap <buffer> t<Space> :<C-u>call vimonga#action('database', 'tab_open')<CR>
    nnoremap <buffer> dd :<C-u>call vimonga#action('database', 'drop')<CR>
endfunction

autocmd MyAuGroup FileType vimonga-coll call s:vimonga_collection()
function! s:vimonga_collection() abort
    nnoremap <buffer> l :<C-u>call vimonga#action('collection', 'open')<CR>
    nnoremap <buffer> dd :<C-u>call vimonga#action('collection', 'drop')<CR>
    nnoremap <buffer> h :<C-u>call vimonga#action('collection', 'open_parent')<CR>
    nnoremap <buffer> t<Space> :<C-u>call vimonga#action('collection', 'tab_open')<CR>
    nnoremap <buffer> i :<C-u>call vimonga#action('collection', 'open_indexes')<CR>
endfunction

autocmd MyAuGroup FileType vimonga-indexes call s:vimonga_indexes()
function! s:vimonga_indexes() abort
    nnoremap <buffer> h :<C-u>call vimonga#action('indexes', 'open_parent')<CR>
endfunction

autocmd MyAuGroup FileType vimonga-doc call s:vimonga_document()
function! s:vimonga_document() abort
    nnoremap <buffer> h :<C-u>call vimonga#action('document', 'open_parent')<CR>
    nnoremap <buffer> <C-n> :<C-u>call vimonga#action('document', 'open_next')<CR>
    nnoremap <buffer> <C-e> :<C-u>call vimonga#action('document', 'open_last')<CR>
    nnoremap <buffer> <C-p> :<C-u>call vimonga#action('document', 'open_prev')<CR>
    nnoremap <buffer> <C-a> :<C-u>call vimonga#action('document', 'open_first')<CR>
    nnoremap <buffer> dd :<C-u>call vimonga#action('document', 'projection_hide')<CR>
    nnoremap <buffer> dr :<C-u>call vimonga#action('document', 'projection_reset_all')<CR>
    nnoremap <buffer> sa :<C-u>call vimonga#action('document', 'sort_ascending')<CR>
    nnoremap <buffer> sd :<C-u>call vimonga#action('document', 'sort_descending')<CR>
    nnoremap <buffer> sr :<C-u>call vimonga#action('document', 'sort_reset')<CR>
    nnoremap <buffer> ss :<C-u>call vimonga#action('document', 'sort_toggle')<CR>
    nnoremap <buffer> sR :<C-u>call vimonga#action('document', 'sort_reset_all')<CR>
    nnoremap <buffer> a :<C-u>call vimonga#action('document', 'query_add')<CR>
    nnoremap <buffer> A :<C-u>call vimonga#action('document', 'query_reset_all')<CR>
endfunction

call vimonga#config#set('default_port', 27020)

let s:config_path = expand('<sfile>:h') . '/vimonga.toml'
call vimonga#config#set('config_path', s:config_path)
