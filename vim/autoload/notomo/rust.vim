
function! notomo#rust#next() abort
    call s:goto('next', 0)
endfunction

function! notomo#rust#prev() abort
    call s:goto('prev', -1)
endfunction

function! s:goto(next_prev, offset) abort
    if a:next_prev ==# 'next'
        let flags = ''
    else
        let flags = 'b'
    endif
    call search('\v^\s*\zsfn', flags)
endfunction

function! notomo#rust#doc(target) abort
    let path = trim(system(['rustup', 'doc', '--path', a:target]))
    call s:_open(path, 'tabedit')
endfunction

function! notomo#rust#selected_doc() abort
    let [_, start] = getpos("'<")[1:2]
    let [_, end] = getpos("'>")[1:2]
    let line = getline('.')
    let target = line[start - 1 : end - 1]
    call notomo#rust#doc(target)
endfunction

function! s:_open(path, open_way) abort
    call notomo#doc#open(a:path, a:open_way)
    if &filetype !=? 'notomodoc'
        return
    endif

    nnoremap <buffer> [keyword]r <Cmd>call <SID>_open(notomo#doc#path(), 'enew')<CR>
    nnoremap <buffer> [keyword]o <Cmd>call <SID>_open(notomo#doc#path(), 'enew')<CR>
    nnoremap <buffer> [keyword]t <Cmd>call <SID>_open(notomo#doc#path(), 'tabedit')<CR>
    nnoremap <buffer> [keyword]v <Cmd>call <SID>_open(notomo#doc#path(), 'vsplit')<CR>

    " HACK
    syntax clear
    unlet! b:current_syntax
    runtime! syntax/rust.vim
endfunction
