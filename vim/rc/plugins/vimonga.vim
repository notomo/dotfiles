
nnoremap [exec]v :<C-u>Vimonga database<CR>

autocmd MyAuGroup FileType vimonga-dbs call s:vimonga_dbs()
function! s:vimonga_dbs() abort
    nnoremap <buffer> l :<C-u>call vimonga#action('database', 'open')<CR>
    nnoremap <buffer> t<Space> :<C-u>call vimonga#action('database', 'tab_open')<CR>
    nnoremap <buffer> dd :<C-u>call vimonga#action('database', 'drop')<CR>
    nnoremap <buffer> u :<C-u>call vimonga#action('users', 'open')<CR>
endfunction

autocmd MyAuGroup FileType vimonga-users call s:vimonga_users()
function! s:vimonga_users() abort
    nnoremap <buffer> h :<C-u>call vimonga#action('collection', 'open_parent')<CR>
endfunction

autocmd MyAuGroup FileType vimonga-colls call s:vimonga_collections()
function! s:vimonga_collections() abort
    nnoremap <buffer> l :<C-u>call vimonga#action('collection', 'open')<CR>
    nnoremap <buffer> dd :<C-u>call vimonga#action('collection', 'drop')<CR>
    nnoremap <buffer> h :<C-u>call vimonga#action('collection', 'open_parent')<CR>
    nnoremap <buffer> t<Space> :<C-u>call vimonga#action('collection', 'tab_open')<CR>
    nnoremap <buffer> i :<C-u>call vimonga#action('collection', 'open_indexes')<CR>
    nnoremap <buffer> I :<C-u>call vimonga#action('collection', 'create')<CR>
endfunction

autocmd MyAuGroup FileType vimonga-indexes call s:vimonga_indexes()
function! s:vimonga_indexes() abort
    nnoremap <buffer> h :<C-u>call vimonga#action('indexes', 'open_parent')<CR>
endfunction

autocmd MyAuGroup FileType vimonga-docs call s:vimonga_documents()
function! s:vimonga_documents() abort
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
    nnoremap <buffer> t<Space> :<C-u>call vimonga#action('document', 'tab_open_one')<CR>
    nnoremap <buffer> o :<C-u>call vimonga#action('document', 'open_one')<CR>
    nnoremap <buffer> I :<C-u>call vimonga#action('document', 'tab_new')<CR>
endfunction

autocmd MyAuGroup FileType vimonga-doc call s:vimonga_document()
function! s:vimonga_document() abort
    nnoremap <buffer> h :<C-u>call vimonga#action('collection', 'open')<CR>
    nnoremap <buffer> X :<C-u>call vimonga#action('document', 'delete_one')<CR>
endfunction

autocmd MyAuGroup FileType vimonga-doc-new call s:vimonga_document_new()
function! s:vimonga_document_new() abort
    nnoremap <buffer> [file]w :<C-u>call vimonga#action('document', 'insert')<CR>
endfunction

call vimonga#config#set('default_port', 27020)
