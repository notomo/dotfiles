
function! notomo#diary#open() abort
    let dir_path = expand('~/workspace/diary')
    if !isdirectory(dir_path)
        call mkdir(dir_path, 'p')
    endif
    let diary_path =  dir_path . '/' . strftime('%Y%m%d.txt')
    execute 'tab drop ' . diary_path
    execute 'lcd' dir_path
    setlocal filetype=mydiary

    let content = join(getbufline('%', 1, '$'), '')
    if content !=? ''
        return
    endif

    write

    let dir = reverse(readdir('.'))
    let others = dir[1:]
    if empty(others)
        return
    endif

    let before = others[0]
    let content = readfile(before)
    call append(0, content)
    write 
endfunction
