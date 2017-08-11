if exists('b:did_indent')
    finish
endif
let b:did_indent = 1

setlocal formatoptions-=t
setlocal formatoptions+=r
setlocal formatoptions+=o

setlocal indentkeys=0{,0},0),0],:,!^F,o,O,e,*<Return>,=?>,=<?,=*/
setlocal indentexpr=GetPythonIndent()
function! GetPythonIndent()
    let curline = getline('.')
    if (col('.') - 1) != matchend(curline, '^\s*')
        return -1
    endif
    if curline =~# '\v^\s*[])"'']$'
        " e.g. var = func(\n)
        return -1
    endif

    let line_num = prevnonblank(v:lnum - 1)
    let plus_one = indent(line_num) + &l:shiftwidth
    let line = getline(line_num)
    if line =~# '\v.*\([^)]*$'
        " e.g. func(
        return plus_one
    elseif line =~# '\v.*:$'
        " e.g. def func():
        return plus_one
    elseif line =~# '\v.*\[[^]]*$'
        " e.g. ary = [
        return plus_one
    endif

    return -1
endfunction

let b:undo_indent = 'setlocal '.join([
\   'comments<',
\   'formatoptions<',
\   'indentexpr<',
\   'indentkeys<',
\ ])
