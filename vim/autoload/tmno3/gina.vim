
function! tmno3#gina#adjust_diff_fenc() abort
    let buf_nums = tabpagebuflist()
    for buf_num in buf_nums
        let file_path = substitute(fnamemodify(bufname(buf_num), ':p'), '\', '/', 'g')
        echomsg tmno3#gina#get_file_path(file_path)
    endfor
endfunction

function! tmno3#gina#get_fenc(bufnum) abort
    
endfunction

function! tmno3#gina#get_file_path(gina_file_path) abort
    let git = gina#core#get_or_fail()
    let abspath = gina#core#repo#abspath(git, '')
    let repo_name = fnamemodify(abspath, ':h:t')
    let relpath = substitute(a:gina_file_path, '\v^gina://' . repo_name . ':show:?[^:]{-}:', '', '')
    if relpath !=? a:gina_file_path
        let file_path = abspath . relpath
    else
        let file_path = a:gina_file_path
    endif
    return file_path
endfunction

function! tmno3#gina#set_diff_mode(buf_num) abort
    call setbufvar(a:buf_num, '&diff', 1)
    call setbufvar(a:buf_num, '&scrollbind', 1)
    call setbufvar(a:buf_num, '&cursorbind', 1)
    call setbufvar(a:buf_num, '&scrollopt', getbufvar(a:buf_num, '&scrollopt') + 'hor')
    call setbufvar(a:buf_num, '&wrap', 0)
    call setbufvar(a:buf_num, '&foldmethod', 'diff')
    call setbufvar(a:buf_num, '&foldcolumn', 2)
endfunction

