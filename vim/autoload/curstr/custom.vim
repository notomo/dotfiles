
let s:init_customizes = {'alias': [], 'action': []}

function! curstr#custom#alias(alias, targets) abort
    let dict = {'alias': a:alias, 'targets': a:targets}
    call s:custom('alias', dict)
endfunction

function! curstr#custom#action(filetype, actions) abort
    let dict = {'filetype': a:filetype, 'actions': a:actions}
    call s:custom('action', dict)
endfunction

function! curstr#custom#init() abort
    for [type, dicts] in items(s:init_customizes)
        for dict in dicts
            call _curstr_custom(type, dict)
        endfor
    endfor
    let s:init_customizes = {}
endfunction

function! s:custom(type, dict) abort
    if has('vim_starting')
        call add(s:init_customizes[a:type], a:dict)
        return
    endif
    call _curstr_custom(a:type, a:dict)
endfunction
