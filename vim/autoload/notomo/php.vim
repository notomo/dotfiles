
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

" TODO builtin object(using highlight name)
function! notomo#php#get_class_path(class_name)
    let cursor_pos = getpos('.')
    call cursor(1, 1)
    let line_num = search('\v\s*use\s+\S+(\s+as\s+)?' . a:class_name . '\s*;', 'nW')
    if line_num == 0
        let class_path = notomo#php#get_namespace() . '\' . a:class_name
    else
        let line = getline(line_num)
        let class_path = matchstr(line, '\v\s*use\s+\zs\S+\ze(\s+|;)')
    endif
    call setpos('.', cursor_pos)
    return class_path
endfunction

function! notomo#php#get_namespace()
    let cursor_pos = getpos('.')
    call cursor(1, 1)
    let line_num = search('\v\s*namespace\s+\S+\s*;', 'nW')
    let line = getline(line_num)
    let namespace = matchstr(line, '\v\s*namespace\s+\zs\S+\ze\s*;')
    call setpos('.', cursor_pos)
    return namespace
endfunction
