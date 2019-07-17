
function! notomo#diary#open() abort
    let diary_folder_path = expand('~/workspace/diary')
    if !isdirectory(diary_folder_path)
        call mkdir(diary_folder_path, 'p')
    endif
    let diary_path =  diary_folder_path . '/' . strftime('%Y%m%d.txt')
    execute 'tab drop ' . diary_path
    set filetype=mydiary
endfunction
