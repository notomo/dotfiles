
function! tmno3#denite#execute_unite_action(context, action_name) abort
    let targets = a:context['targets']
    let candidates = []
    for target in targets
        call add(candidates, target['source__candidate'])
    endfor
    call unite#action#do_candidates(a:action_name, candidates)
endfunction

function! tmno3#denite#dir_file(context) abort
    let target = a:context['targets'][0]
    if !has_key(target, 'action__path')
        return
    endif
    let path = target['action__path']
    let a:context['quit'] = v:false
    execute 'Denite dir_file:' . path
endfunction

function! tmno3#denite#parent_dir_file(context) abort
    let target = a:context['targets'][0]
    if !has_key(target, 'action__path')
        return
    endif
    let path = fnamemodify(target['action__path'], ':h:h')
    let a:context['quit'] = v:false
    execute 'Denite -mode=normal dir_file:' . path
endfunction

function! tmno3#denite#open(open_cmd, context) abort
    let target = a:context['targets'][0]
    if !has_key(target, 'action__path')
        return
    endif
    execute a:open_cmd
    let path = target['action__path']
    execute 'edit ' . path
endfunction
