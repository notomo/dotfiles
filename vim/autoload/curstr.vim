
function! curstr#execute(arg_string) abort
    call curstr#initialize()
    call _curstr_execute(a:arg_string)
endfunction

function! curstr#load(factory_name) abort
    call curstr#initialize()
    return _curstr_load(a:factory_name)
endfunction

function! curstr#initialize() abort
    if exists('g:curstr#_channel_id')
        return
    endif

    if !exists('g:loaded_remote_plugins')
      runtime! plugin/rplugin.vim
    endif
endfunction
