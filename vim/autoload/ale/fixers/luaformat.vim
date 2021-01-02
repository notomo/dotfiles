call ale#Set('lua_luaformat_executable', 'lua-format')
call ale#Set('lua_luaformat_options', '')

function! ale#fixers#luaformat#Fix(buffer) abort
    let l:executable = ale#Var(a:buffer, 'lua_luaformat_executable')
    let l:options = ale#Var(a:buffer, 'lua_luaformat_options')

    return {
    \   'command': ale#Escape(l:executable)
    \       . (empty(l:options) ? '' : ' ' . l:options)
    \}
endfunction
