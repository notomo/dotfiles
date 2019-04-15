
function! notomo#vim#get_indent()
    let curline = getline('.')
    if (col('.') - 1) != matchend(curline, '^\s*')
        return -1
    endif

    let line_num = prevnonblank(v:lnum - 1)
    let plus_one = indent(line_num) + shiftwidth()
    let line = getline(line_num)
    if line =~# '\v.*\(\s*$'
        " e.g. func(
        return plus_one
    elseif line =~# '\v^\s*(fu|if|else|for|while)'
        " e.g. function!
        return plus_one
    elseif line =~# '\v.*:$'
        " e.g. def func():
        return plus_one
    elseif line =~# '\v.*\[\s*$'
        " e.g. ary = [
        return plus_one
    " elseif line =~# '\v.*\{(\})@!'
    elseif line =~# '\v.*\{\s*$'
        " e.g. dict = {
        return plus_one
    endif

    return -1
endfunction
