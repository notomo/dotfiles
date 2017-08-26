
function! notomo#denite#execute_unite_action(context, action_name) abort
    let targets = a:context['targets']
    let candidates = []
    for target in targets
        call add(candidates, target['source__candidate'])
    endfor
    call unite#action#do_candidates(a:action_name, candidates)
endfunction

function! notomo#denite#dir_file_on_directory(context) abort
    let target = a:context['targets'][0]
    if !has_key(target, 'action__path')
        return
    endif
    let path = target['action__path']
    let a:context['quit'] = v:false
    execute 'Denite -mode=normal dir_file:' . path
endfunction

function! notomo#denite#dir_file_on_file(context) abort
    let target = a:context['targets'][0]
    if !has_key(target, 'action__path')
        return
    endif
    let path = fnamemodify(target['action__path'], ':h')
    let a:context['quit'] = v:false
    execute 'Denite -mode=normal dir_file:' . path
endfunction

function! notomo#denite#parent_dir_file(context) abort
    let target = a:context['targets'][0]
    if !has_key(target, 'action__path')
        return
    endif
    let path = fnamemodify(target['action__path'], ':h:h')
    let a:context['quit'] = v:false
    execute 'Denite -mode=normal dir_file:' . path
endfunction

function! notomo#denite#open(open_cmd, context) abort
    let target = a:context['targets'][0]
    if !has_key(target, 'action__path')
        return
    endif
    execute a:open_cmd
    let path = target['action__path']
    execute 'edit ' . path
endfunction

function! notomo#denite#qfreplace(context) abort
    let qflist = []
    for target in a:context['targets']
        if !has_key(target, 'action__line') || !has_key(target, 'action__text')
            continue
        endif
        let dict = {'filename': target['action__path'], 'lnum': target['action__line'], 'text': target['action__text']}
        call add(qflist, dict)
    endfor
    if len(qflist) == 0
        return
    endif
    call setqflist(qflist)
    call qfreplace#start('')
endfunction

function! notomo#denite#exrename(context) abort
    let paths = []
    for target in a:context['targets']
        call add(paths, target['action__path'])
    endfor
    call vulk_rename#execute(paths)
endfunction

function! notomo#denite#directory_open(open_cmd, context) abort
    let target = a:context['targets'][0]
    if !has_key(target, 'action__path')
        return
    endif
    execute a:open_cmd
    let path = target['action__path']
    if !isdirectory(path)
        let path = fnamemodify(target['action__path'], ':h')
    endif
    execute 'edit ' . path
endfunction
