
function! DockerTransform(cmd) abort
    if !exists('g:local#var#container_name') || stridx(g:local#var#container_name, ' ') != -1
        return a:cmd
    endif
    return join(['docker exec', g:local#var#container_name, a:cmd])
endfunction

let test#strategy = 'neovim'
let g:test#custom_transformations = {'docker': function('DockerTransform')}
let g:test#transformation = 'docker'
" let test#filename_modifier = ':p'
