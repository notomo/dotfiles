
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

function! notomo#denite#dir_file_on_directory(context) abort
    execute 'Denite dir_file:' . s:get_target_path('', a:context)
endfunction

function! notomo#denite#dir_file_on_file(context) abort
    execute 'Denite dir_file:' . s:get_target_path(':h', a:context)
endfunction

function! notomo#denite#parent_dir_file(context) abort
    execute 'Denite dir_file:' . s:get_target_path(':h:h', a:context)
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
    endfor
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
    Qfreplace
    only
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

function! notomo#denite#project_dir_file_rec_on_file(context) abort
    execute 'cd ' . s:get_target_path(':h', a:context)
    execute 'DeniteProjectDir file/rec'
endfunction

function! notomo#denite#project_dir_file_rec(context) abort
    execute 'cd ' . s:get_target_path('', a:context)
    execute 'DeniteProjectDir file/rec'
endfunction

function! notomo#denite#dir_file_rec(context) abort
    execute 'cd ' . s:get_target_path('', a:context)
    execute 'Denite file/rec'
endfunction

function! notomo#denite#dir_file_rec_on_file(context) abort
    execute 'cd ' . s:get_target_path(':h', a:context)
    execute 'Denite file/rec'
endfunction

function! notomo#denite#project_dir_by_path(dir_path, context) abort
    execute 'cd ' . a:dir_path
    let input = '-input=' . escape(a:context['input'], ' ')
    execute join(['DeniteProjectDir', input, 'file/rec'])
endfunction

function! notomo#denite#grep_plugin_setting(context) abort
    let target = a:context['targets'][0]
    if !has_key(target, 'word')
        return
    endif
    let plugin = target['word']
    execute join(['Denite', 'grep:~/dotfiles/vim/rc/minpac::' . plugin, '-no-empty', '-immediately-1'])
endfunction

function! notomo#denite#debug_targets(context) abort
    echomsg string(a:context['targets'])
endfunction

function! notomo#denite#go_package_dir() abort
    let cword = expand('<cWORD>')
    let name = '^' . trim(cword, '"') . '$'
    let input = '-input=' . escape(name, '/')
    let cmd = 'Denite go/package ' . input . ' -no-empty -immediately-1 -default-action=tabopen'
    execute cmd
    echomsg cmd
endfunction

function! notomo#denite#get(option_name) abort
    if stridx(a:option_name, ';') != -1
        return
    endif
    execute 'let g:notomo_tmp = &' . a:option_name
    let value = g:notomo_tmp
    unlet g:notomo_tmp
    return value
endfunction

function! notomo#denite#convert(context) abort
    let url = escape(a:context['targets'][0]['action__url'], ':')
    execute 'Denite url_substitute_pattern:' . url
endfunction

function! notomo#denite#decls(context) abort
    execute 'Denite go/decls:' . a:context['targets'][0]['action__path']
endfunction

function! notomo#denite#go_project_decls() abort
    let project_path = fnamemodify(notomo#vimrc#search_parent_recursive('.git', './'), ':h:h')
    let path = escape(project_path, '/')
    execute 'Denite go/decls:' . path . ':1'
endfunction

function! notomo#denite#append_emoji(context) abort
    for target in a:context['targets']
        let target['word'] = target['action__text']
        call denite#do_action(a:context, 'append', [target])
    endfor
endfunction

function! notomo#denite#redir(cmd) abort
    let [tmp_verbose, tmp_verbosefile] = [&verbose, &verbosefile]
    set verbose=0 verbosefile=
    redir => result
    silent! execute a:cmd
    redir END
    let [&verbose, &verbosefile] = [tmp_verbose, tmp_verbosefile]
    return result
endfunction
