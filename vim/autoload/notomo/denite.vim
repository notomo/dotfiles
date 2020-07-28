
function! s:get_target_path(fnamemod_string, context) abort
    let target = a:context['targets'][0]
    if !has_key(target, 'action__path')
        return
    endif
    if empty(a:fnamemod_string)
        let path = target['action__path']
    else
        let path = fnamemodify(target['action__path'], a:fnamemod_string)
    endif
    return path
endfunction

function! notomo#denite#open(open_cmd, context) abort
    for target in a:context['targets']
        if has_key(target, 'action__line')
            let line = ' +' . target['action__line'] . ' '
        else
            let line = ''
        endif
        execute a:open_cmd
        if has_key(target, 'action__bufnr')
            execute 'edit ' . line . '#' . target['action__bufnr']
        else
            execute 'edit ' . line . target['action__path']
        endif
        if has_key(target, 'action__pattern')
            call search(target['action__pattern'])
        endif
    endfor
endfunction

function! notomo#denite#directory_open(open_cmd, context) abort
    let target = a:context['targets'][0]
    if !has_key(target, 'action__path')
        return
    endif
    execute a:open_cmd
    let path = expand(target['action__path'])
    if !isdirectory(path)
        let path = fnamemodify(target['action__path'], ':h')
    endif
    execute 'cd ' . path
    Kiview -create -split=no
endfunction

function! notomo#denite#debug_targets(context) abort
    echomsg string(a:context['targets'])
endfunction

function! notomo#denite#decls(context) abort
    execute 'Denite go/decls:' . a:context['targets'][0]['action__path']
endfunction
