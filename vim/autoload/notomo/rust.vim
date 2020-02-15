
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

function! s:open(open_way) abort
    let path = expand('<cWORD>')
    let path = substitute(path, '^file:\/\/\(localhost\)\?', '', '')
    let path = substitute(path, '#\S\+$', '', '')
    call s:_open(path, a:open_way)
endfunction

function! s:_open(path, open_way) abort
    if !filereadable(a:path)
        echomsg a:path | return
    endif

    let content = systemlist(['lynx', '-dump', '-nonumbers', a:path])
    execute a:open_way
    setlocal buftype=nofile
    call setbufline(bufnr('%'), 1, content)
    setlocal nomodifiable

    nnoremap <buffer> [keyword]r :<C-u>call <SID>open('enew')<CR>
    nnoremap <buffer> [keyword]o :<C-u>call <SID>open('enew')<CR>
    nnoremap <buffer> [keyword]t :<C-u>call <SID>open('tabedit')<CR>
    nnoremap <buffer> [keyword]v :<C-u>call <SID>open('vsplit')<CR>

    " HACK
    syntax clear
    unlet! b:current_syntax
    runtime! syntax/rust.vim
endfunction
