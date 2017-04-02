
function! tmno3#gina#adjust_diff_fenc() abort
    let buf_nums = tabpagebuflist()
    let show_bufs = []
    let exists_file_bufs = []
    for buf_num in buf_nums
        let show_buf_file_path = tmno3#gina#convert_from_show_buf(buf_num)
        if show_buf_file_path !=? ''
            call add(show_bufs, buf_num)
        else
            call add(exists_file_bufs, buf_num)
        endif
    endfor

    if len(exists_file_bufs) != 1
        return
    endif

    let exists_fenc = getbufvar(exists_file_bufs[0], '&fileencoding')
    for show_buf in show_bufs
        let fenc = getbufvar(show_buf, '&fileencoding')
        if fenc != exists_fenc
            call tmno3#gina#change_diff_fenc(exists_fenc)
            break
        endif
    endfor
endfunction

function! tmno3#gina#convert_from_show_buf(buf_num) abort
    let gina_file_path = substitute(fnamemodify(bufname(a:buf_num), ':p'), '\', '/', 'g')
    let git = gina#core#get_or_fail()
    let abspath = gina#core#repo#abspath(git, '')
    let repo_name = fnamemodify(abspath, ':h:t')
    let relpath = substitute(gina_file_path, '\v^gina://' . repo_name . ':show:?[^:]{-}:', '', '')
    if relpath !=# gina_file_path
        return abspath . relpath
    endif
    return ''
endfunction

function! tmno3#gina#change_diff_fenc(fenc) abort
    let buf_nums = tabpagebuflist()
    let tmp_buf = buf_nums[0]
    let tmp_diff = getbufvar(tmp_buf, '&diff')
    let tmp_scrollbind = getbufvar(tmp_buf, '&scrollbind')
    let tmp_cursorbind = getbufvar(tmp_buf, '&cursorbind')
    let tmp_scrollopt = getbufvar(tmp_buf, '&scrollopt')
    let tmp_wrap = getbufvar(tmp_buf, '&wrap')
    let tmp_foldmethod = getbufvar(tmp_buf, '&foldmethod')
    execute 'windo e! ' . '++enc=' . a:fenc
    for buf_num in buf_nums
        call setbufvar(buf_num, '&diff', tmp_diff)
        call setbufvar(buf_num, '&scrollbind', tmp_scrollbind)
        call setbufvar(buf_num, '&cursorbind', tmp_cursorbind)
        call setbufvar(buf_num, '&scrollopt', tmp_scrollopt)
        call setbufvar(buf_num, '&wrap', tmp_wrap)
        call setbufvar(buf_num, '&foldmethod', tmp_foldmethod)
    endfor
endfunction

