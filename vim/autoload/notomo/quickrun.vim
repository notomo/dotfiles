
function! s:dispatch_cs() abort
    if !has('unix')
        return
    endif
    if notomo#vimrc#search_parent_recursive('*.csproj', getcwd()) !=? ''
        let g:quickrun_config['cs'] = {'type': 'cs/dotnet'}
    else
        let g:quickrun_config['cs'] = {'type': 'cs/mcs'}
    endif
endfunction

function! notomo#quickrun#execute() abort
    if &filetype ==? 'cs'
        call s:dispatch_cs()
    endif
    QuickRun
endfunction
