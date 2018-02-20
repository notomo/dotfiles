
let s:init_customizes = {'alias': [], 'action': []}

function! curstr#custom#alias(alias, targets) abort
    let dict = {'alias': a:alias, 'targets': a:targets}
    let type = 'alias'
    if s:init(type, dict)
        return
    endif
    call _curstr_custom(type, dict)
endfunction

function! curstr#custom#action(filetype, actions) abort
    let dict = {'filetype': a:filetype, 'actions': a:actions}
    let type = 'action'
    if s:init(type, dict)
        return
    endif
    call _curstr_custom(type, dict)
endfunction

function! curstr#custom#init() abort
    call curstr#initialize()
    for [type, dicts] in items(s:init_customizes)
        for dict in dicts
            call _curstr_custom(type, dict)
        endfor
    endfor
    let s:init_customizes = {}
    augroup curstr
        autocmd!
    augroup END
endfunction

function! s:init(type, dict) abort
    if has('vim_starting')
        call add(s:init_customizes[a:type], a:dict)
        augroup curstr
            autocmd!
            autocmd VimEnter * call curstr#custom#init()
        augroup END
        return 1
    endif
    return 0
endfunction
