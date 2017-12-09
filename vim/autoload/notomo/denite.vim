
function! notomo#denite#execute_unite_action(context, action_name) abort
    let candidates = map(a:context['targets'], {key, val -> val['source__candidate']})
    call unite#action#do_candidates(a:action_name, candidates)
endfunction

function! notomo#denite#dir_file_on_directory(context) abort
    let target = a:context['targets'][0]
    if !has_key(target, 'action__path')
        return
    endif
    let path = target['action__path']
    execute 'Denite dir_file:' . path
endfunction

function! notomo#denite#dir_file_on_file(context) abort
    let target = a:context['targets'][0]
    if !has_key(target, 'action__path')
        return
    endif
    let path = fnamemodify(target['action__path'], ':h')
    execute 'Denite dir_file:' . path
endfunction

function! notomo#denite#parent_dir_file(context) abort
    let target = a:context['targets'][0]
    if !has_key(target, 'action__path')
        return
    endif
    let path = fnamemodify(target['action__path'], ':h:h')
    execute 'Denite dir_file:' . path
endfunction

function! notomo#denite#open(open_cmd, context) abort
    let target = a:context['targets'][0]
    if !has_key(target, 'action__path')
        return
    endif
    execute a:open_cmd
    execute 'edit ' . target['action__path']
endfunction

function! notomo#denite#qfreplace(context) abort
    tabnew
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
    only
endfunction

function! notomo#denite#exrename(context) abort
    let candidates = []
    for target in a:context['targets']
        let action_path = target['action__path']
        let kind = isdirectory(action_path) ? 'directory' : 'file'
        call add(candidates, {'action__path': action_path, 'kind': kind})
    endfor
    call unite#exrename#create_buffer(candidates)
    only
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

function! notomo#denite#open_command(context) abort
    call denite#do_action(a:context, 'execute', a:context['targets'])
    only
endfunction

function! notomo#denite#outline(context) abort
    let target = a:context['targets'][0]
    execute 'Denite -auto-preview outline:' . target['action__path']
endfunction

function! notomo#denite#change_source(source_name, context) abort
    let input = '-input=' . escape(a:context['input'], ' ')
    execute join(['Denite', input, a:source_name])
endfunction

function! notomo#denite#delete_line(context) abort
    if a:context['sources'][0]['name'] !=? 'line'
        echomsg 'Invalid source'
        return
    endif
    let line_numbers = map(a:context['targets'], {key, val -> val['action__line']})
    call sort(line_numbers, {i1, i2 -> i2 - i1})
    for line in line_numbers
        execute line . 'delete'
    endfor
endfunction

function! notomo#denite#delete_others_line(context) abort
    if a:context['sources'][0]['name'] !=? 'line'
        echomsg 'Invalid source'
        return
    endif
    let line_numbers = map(a:context['targets'], {key, val -> val['action__line']})
    call sort(line_numbers, {i1, i2 -> i1 - i2})
    let lines = map(line_numbers, {key, val -> getline(val)})
    1,$delete
    call setline(1, lines)
endfunction
