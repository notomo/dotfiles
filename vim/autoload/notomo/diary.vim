
function! notomo#diary#open() abort
    let dir_path = expand('~/workspace/diary')
    if !isdirectory(dir_path)
        call mkdir(dir_path, 'p')
    endif
    let diary_path =  dir_path . '/' . strftime('%Y%m%d.txt')
    execute 'tab drop ' . diary_path
    execute 'lcd' dir_path
    setlocal filetype=mydiary
endfunction
