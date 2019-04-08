
nnoremap [exec]v :<C-u>Vimonga database.list -open=tabedit<CR>

autocmd MyAuGroup FileType vimonga-conns call s:vimonga_conns()
function! s:vimonga_conns() abort
    nnoremap <buffer> l <Cmd>Vimonga database.list<CR>
endfunction

autocmd MyAuGroup FileType vimonga-dbs call s:vimonga_dbs()
function! s:vimonga_dbs() abort
    nnoremap <buffer> l <Cmd>Vimonga collection.list<CR>
    nnoremap <buffer> h <Cmd>Vimonga connection.list<CR>
    nnoremap <buffer> t<Space> <Cmd>Vimonga collection.list -open=tabedit<CR>
    nnoremap <buffer> dd <Cmd>Vimonga database.drop<CR>
    nnoremap <buffer> u <Cmd>Vimonga user.list<CR>
endfunction

autocmd MyAuGroup FileType vimonga-users call s:vimonga_users()
function! s:vimonga_users() abort
    nnoremap <buffer> h <Cmd>Vimonga database.list<CR>
    nnoremap <buffer> I <Cmd>Vimonga user.new<CR>
    nnoremap <buffer> X :<C-u>Vimonga user.drop -user=
endfunction

autocmd MyAuGroup FileType vimonga-user-new call s:vimonga_user_new()
function! s:vimonga_user_new() abort
    nnoremap <buffer> [file]w <Cmd>Vimonga user.create<CR>
endfunction

autocmd MyAuGroup FileType vimonga-colls call s:vimonga_collections()
function! s:vimonga_collections() abort
    nnoremap <buffer> l <Cmd>Vimonga document.find<CR>
    nnoremap <buffer> dd <Cmd>Vimonga collection.drop<CR>
    nnoremap <buffer> h <Cmd>Vimonga database.list<CR>
    nnoremap <buffer> t<Space> <Cmd>Vimonga document.find -open=tabedit<CR>
    nnoremap <buffer> i <Cmd>Vimonga index.list<CR>
    nnoremap <buffer> I <Cmd>Vimonga collection.create<CR>
endfunction

autocmd MyAuGroup FileType vimonga-indexes call s:vimonga_indexes()
function! s:vimonga_indexes() abort
    nnoremap <buffer> h <Cmd>Vimonga collection.list<CR>
    nnoremap <buffer> I <Cmd>Vimonga index.new<CR>
    nnoremap <buffer> X :<C-u>Vimonga index.drop -index=
endfunction

autocmd MyAuGroup FileType vimonga-index-new call s:vimonga_index_new()
function! s:vimonga_index_new() abort
    nnoremap <buffer> [file]w <Cmd>Vimonga index.create<CR>
endfunction

autocmd MyAuGroup FileType vimonga-docs call s:vimonga_documents()
function! s:vimonga_documents() abort
    nnoremap <buffer> h <Cmd>Vimonga collection.list<CR>
    nnoremap <buffer> <C-n> <Cmd>Vimonga document.page.next<CR>
    nnoremap <buffer> <C-e> <Cmd>Vimonga document.page.last<CR>
    nnoremap <buffer> <C-p> <Cmd>Vimonga document.page.prev<CR>
    nnoremap <buffer> <C-a> <Cmd>Vimonga document.page.first<CR>
    nnoremap <buffer> dd <Cmd>Vimonga document.projection.hide<CR>
    nnoremap <buffer> dr <Cmd>Vimonga document.projection.reset_all<CR>
    nnoremap <buffer> sa <Cmd>Vimonga document.sort.ascending<CR>
    nnoremap <buffer> sd <Cmd>Vimonga document.sort.descending<CR>
    nnoremap <buffer> sr <Cmd>Vimonga document.sort.reset<CR>
    nnoremap <buffer> ss <Cmd>Vimonga document.sort.toggle<CR>
    nnoremap <buffer> sR <Cmd>Vimonga document.sort.reset_all<CR>
    nnoremap <buffer> a <Cmd>Vimonga document.query.add<CR>
    nnoremap <buffer> A <Cmd>Vimonga document.query.reset_all<CR>
    nnoremap <buffer> t<Space> <Cmd>Vimonga document.one -open=tabedit<CR>
    nnoremap <buffer> o <Cmd>Vimonga document.one<CR>
    nnoremap <buffer> I <Cmd>Vimonga document.new -open=tabedit<CR>
    nnoremap <buffer> F <Cmd>Vimonga document.query.find_by_oid -open=tabedit<CR>
endfunction

autocmd MyAuGroup FileType vimonga-doc call s:vimonga_document()
function! s:vimonga_document() abort
    nnoremap <buffer> X <Cmd>Vimonga document.one.delete<CR>
endfunction

autocmd MyAuGroup FileType vimonga-doc-new call s:vimonga_document_new()
function! s:vimonga_document_new() abort
    nnoremap <buffer> [file]w <Cmd>Vimonga document.one.insert<CR>
endfunction

call vimonga#config#set('default_port', 27020)
call vimonga#config#set('connection_config', '~/.vim/minpac/pack/minpac/start/vimonga/example/connection.json')
