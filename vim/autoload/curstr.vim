
function! curstr#execute(arg_string) abort
    call curstr#initialize()
    call _execute_curstr(a:arg_string)
endfunction

function! curstr#load(factory_name) abort
    call curstr#initialize()
    return _load_curstr(a:factory_name)
endfunction

function! curstr#initialize() abort
    if exists('g:curstr#_channel_id')
        return
    endif
    let g:curstr_actions = get(g:, 'curstr_actions', {})

    if !exists('g:loaded_remote_plugins')
      runtime! plugin/rplugin.vim
    endif
endfunction
