
function! notomo#vim_test#transform(cmd) abort
    let command = s:coverage(a:cmd)
    if &filetype ==? 'python' && command =~? '^nose2'
        return s:nose2(command)
    endif
    if &filetype ==? 'python' && command =~? '^pytest'
        return s:pytest(command)
    endif
    if exists('g:local#var#container_name') && stridx(g:local#var#container_name, ' ') == -1
        return s:docker(command)
    endif
    return command
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

function! s:coverage(cmd) abort
    if !s:enabled_coverage
        return a:cmd
    endif
    if &filetype ==? 'php' && a:cmd =~? '^phpunit'
        let command = substitute(a:cmd, '--no-coverage', '', 'g')
        return command
    endif
    return a:cmd
endfunction

function! notomo#vim_test#set_project_root() abort
    if &filetype ==? ''
        return
    endif
    if &filetype ==? 'python'
        let config_file = notomo#vimrc#search_parent_recursive('\.coveragerc', './')
        let g:test#project_root = fnamemodify(config_file, ':h')
        return
    endif
    if &filetype ==? 'vim'
        let config_file = notomo#vimrc#search_parent_recursive('\.themisrc', './')
        let g:test#project_root = fnamemodify(config_file, ':h:h')
        return
    endif
    if &filetype ==? 'typescript'
        let config_file = notomo#vimrc#search_parent_recursive('package\.json', './')
        let g:test#project_root = fnamemodify(config_file, ':h')
        return
    endif
    unlet! g:test#project_root
    return
endfunction

let s:enabled_coverage = v:false
function! notomo#vim_test#toggle_coverage() abort
    let s:enabled_coverage = !s:enabled_coverage
    echomsg 'coverage ' . (s:enabled_coverage ? 'enabled!' : 'disabled!')
endfunction
