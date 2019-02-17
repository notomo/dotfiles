
autocmd MyAuGroup FileType vimonga-db call s:vimonga_db()
function! s:vimonga_db() abort
    nnoremap <buffer> l :<C-u>call vimonga#database_action('open')<CR>
    nnoremap <buffer> t<Space> :<C-u>call vimonga#database_action('tab_open')<CR>
endfunction

autocmd MyAuGroup FileType vimonga-coll call s:vimonga_collection()
function! s:vimonga_collection() abort
    nnoremap <buffer> l :<C-u>call vimonga#collection_action('open')<CR>
    nnoremap <buffer> h :<C-u>call vimonga#collection_action('open_parent')<CR>
    nnoremap <buffer> t<Space> :<C-u>call vimonga#collection_action('tab_open')<CR>
endfunction

autocmd MyAuGroup FileType vimonga-doc call s:vimonga_document()
function! s:vimonga_document() abort
    nnoremap <buffer> h :<C-u>call vimonga#document_action('open_parent')<CR>
endfunction

call vimonga#config#set('default_port', 27020)
