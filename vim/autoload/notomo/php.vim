
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
    let plus_one = indent(line_num) + &l:shiftwidth
    let line = getline(line_num)
    if line =~# '\v.*\([^)]*$'
        " e.g. $ary = array(
        return plus_one
    elseif line =~# '\v^[^"]*"[^";]*$'
        " e.g. $str = "
        return plus_one
    elseif line =~# "\\v^[^']*'[^';]*$"
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
