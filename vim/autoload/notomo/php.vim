
function! notomo#php#get_indent()
    let curline = getline('.')
    if (col('.') - 1) != matchend(curline, '^\s*')
        return -1
    endif
    if curline =~# '\v^\s*[]})"''];?$'
        " e.g. $ary = array(\n);
        return -1
    endif

    let line_num = prevnonblank(v:lnum - 1)
    let plus_one = indent(line_num) + shiftwidth()
    let line = getline(line_num)
    if line =~# '\v.*\([^)]*$'
        " e.g. $ary = array(
        return plus_one
    elseif line =~# '\v^[^"]*"[^";]*$'
        " e.g. $str = "
        return plus_one
    elseif line =~# "\v^[^']*'[^';]*$"
        " e.g. $str = '
        return plus_one
    elseif line =~# '\v.*\{[^}]*$'
        " e.g. if ($bool) {
        return plus_one
    elseif line =~# '\v.*\[[^]]*$'
        " e.g. $ary = [
        return plus_one
    elseif line =~# '\v.*:\s*$'
        " e.g. case 'value':
        return plus_one
    elseif line =~# '\v\S+-\>\k+\(.*\)\s*$'
        " e.g. $var->methodChain()
        return plus_one
    endif

    return -1
endfunction

function! notomo#php#get_class_path()
    " ex. SubNameSpace\Class
    let path = matchstr(expand('<cWORD>'), '\v\zs(\\)?(\w+\\)*' . expand('<cword>') . '(\\\w+)*\ze([^0-9A-Za-z])?')
    if path =~? '^\\'
        " global path
        return path
    endif
    " ex. SubNameSpace
    let alias_name = matchstr(path, '^\zs\k\w*\ze.*')
    echomsg alias_name

    let cursor_pos = getpos('.')
    call cursor(1, 1)
    let line_num = search('\v\s*use\s+(\S+)?(\s+as\s+)?' . alias_name . '\s*;', 'nW')
    echomsg line_num
    call setpos('.', cursor_pos)

    if line_num == 0
        let alias_path = notomo#php#get_namespace() . '\' . alias_name
    else
        " ex. UsedNameSpace\SubNameSpace
        let alias_path = matchstr(getline(line_num), '\v\s*use\s+\zs\S+\ze(\s+|;)')
    endif

    " ex. UsedNameSpace\SubNameSpace\Class
    return alias_path . path[len(alias_name):]
endfunction

function! notomo#php#get_namespace()
    let line_num = search('\v\s*namespace\s+\S+\s*;', 'nbW')
    let namespace = matchstr(getline(line_num), '\v\s*namespace\s+\zs\S+\ze\s*;')
    return namespace
endfunction
