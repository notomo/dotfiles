
function! notomo#doc#path() abort
    let path = expand('<cWORD>')
    let path = substitute(path, '^file:\/\/\(localhost\)\?', '', '')
    let path = substitute(path, '#\S\+$', '', '')
    return path
endfunction

function! notomo#doc#open_under_cursor(way) abort
    return notomo#doc#open(notomo#doc#path(), a:way)
endfunction

function! notomo#doc#open(path, way) abort
    if !filereadable(a:path)
        return
    endif

    let content = systemlist(['lynx', '-dump', '-nonumbers', a:path])
    execute a:way
    setlocal buftype=nofile
    setlocal filetype=notomodoc
    call setbufline(bufnr('%'), 1, content)
    setlocal nomodifiable

    nnoremap <buffer> [keyword]r <Cmd>call notomo#doc#open_under_cursor('enew')<CR>
    nnoremap <buffer> [keyword]o <Cmd>call notomo#doc#open_under_cursor('enew')<CR>
    nnoremap <buffer> [keyword]t <Cmd>call notomo#doc#open_under_cursor('tabedit')<CR>
    nnoremap <buffer> [keyword]v <Cmd>call notomo#doc#open_under_cursor('vsplit')<CR>
endfunction
