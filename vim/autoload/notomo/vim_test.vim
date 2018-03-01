
function! notomo#vim_test#transform(cmd) abort
    if &filetype ==? 'python' && a:cmd =~? '^nose2'
        return s:nose2(a:cmd)
    endif
    if &filetype ==? 'python' && a:cmd =~? '^pytest'
        return s:pytest(a:cmd)
    endif
    if exists('g:local#var#container_name') && stridx(g:local#var#container_name, ' ') == -1
        return s:docker(a:cmd)
    endif
    return a:cmd
endfunction

function! s:nose2(cmd) abort
    let config_file = notomo#vimrc#search_parent_recursive('unittest\.cfg', './')
    if empty(config_file)
        return a:cmd
    endif
    let current_file = expand('%:p:r')
    let config_dir = fnamemodify(config_file, ':h')
    let project_relative_module_path = join(split(current_file[len(config_dir):], '/'), '.')
    let modified = join(['nose2', '-s', config_dir, '-c', config_file, project_relative_module_path])
    return modified
endfunction

function! s:pytest(cmd) abort
    return 'python3 -m ' . a:cmd
endfunction

function! s:docker(cmd) abort
    return join(['docker exec', g:local#var#container_name, a:cmd])
endfunction
