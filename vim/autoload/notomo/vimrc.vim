
function! notomo#vimrc#exchange() abort
    let pos = getpos('.')
    execute 's/\v%#(\_.)(\_.)/\2\1/g'
    call setpos('.', pos)
    normal! l
endfunction

function! notomo#vimrc#timer_start() abort
    let g:start_time = reltime()
endfunction

function! notomo#vimrc#timer_end() abort
    echomsg reltimestr(reltime(g:start_time)) | unlet g:start_time
endfunction

function! notomo#vimrc#cd_current() abort
    cd %:p:h
endfunction

function! notomo#vimrc#to_next_syntax(syntax_pattern, column, offset) abort
    call s:to_syntax(a:syntax_pattern, line('.'), a:column, a:offset, v:false, v:true)
endfunction

function! notomo#vimrc#to_previous_syntax(syntax_pattern, column, offset) abort
    call s:to_syntax(a:syntax_pattern, line('.'), a:column, a:offset, v:true, v:true)
endfunction

function! s:to_syntax(syntax_pattern, start_line_num, column, offset, go_backword, wrap) abort
    if a:go_backword
        let Is_limit_line = {line_num, limit_line_num -> line_num > limit_line_num }
        let limit_line_num = 0
        let move_line_num = -1
        let wrap_line_num = line('$')
    else
        let Is_limit_line = {line_num, limit_line_num -> line_num < limit_line_num }
        let limit_line_num = line('$')
        let move_line_num = 1
        let wrap_line_num = 0
    endif
    let line_num = a:start_line_num + move_line_num
    while Is_limit_line(line_num, limit_line_num)
        " if syntax_id == synID(line_num, a:column, 1)
        if synIDattr(synID(line_num, a:column, 1), 'name') =~# a:syntax_pattern
            call setpos('.', [bufnr('%'), line_num + a:offset, 1, 0])
            return
        endif
        let line_num += move_line_num
    endwhile
    if a:wrap == v:false
        return
    endif
    call s:to_syntax(a:syntax_pattern, wrap_line_num, a:column, a:offset, a:go_backword, v:false)
endfunction

function! notomo#vimrc#search_parent_recursive(file_name_pattern, start_path) abort
    let path = fnamemodify(a:start_path, ':p')
    while path !=? '//'
        let files = glob(path . a:file_name_pattern, v:false, v:true)
        if !empty(files)
            let file = files[0]
            return isdirectory(file) ? file . '/' : file
        endif
        let path = fnamemodify(path, ':h:h') . '/'
    endwhile
    return ''
endfunction

function! notomo#vimrc#add_closed_tag() abort
    let pos = getpos('.')
    let reg = @a

    execute 'normal! "ayi>'
    let yanked = @a
    let tag_name = split(yanked)[0]

    if tag_name !~? '^\/'
        let closed_tag = '</' . tag_name . '>'
        call setline('.', getline('.') . closed_tag)
        execute 'normal %'
        execute 'normal! h'
        startinsert
    else
        call setpos('.', pos)
    endif

    let @a = reg
endfunction

function! notomo#vimrc#to_multiline() abort
    let char = getline('.')[col('.') - 1] 
    if char !~? '\v\>|}|\)|]|\<'
        return ''
    endif

    let chars = getline('.')[col('.') - 2:col('.') - 1]
    if chars =~? '\v\>\<|\<\>|\{\}|\(\)|\[\]'
        return "\<CR>\<ESC>O"
    endif

    return "\<CR>\<ESC>%a\<CR>\<ESC>$a"
endfunction

function! notomo#vimrc#yank_and_echo(value) abort
    let [@", @+, @0, @*] = [a:value, a:value, a:value, a:value]
    echomsg 'yank '. a:value
endfunction

function! notomo#vimrc#update_rplugin_runtimepath() abort
    if !has('nvim')
        return
    endif

    let runtimepaths = split(&runtimepath, ',')
    let pack_path = split(&packpath, ',')[0]
    let rplugin_paths = globpath(pack_path, 'pack/*/opt/*/rplugin', v:true, v:true)
    let paths = map(rplugin_paths, { _, path -> fnamemodify(path, ':h') })
    call filter(paths, { _, path -> count(runtimepaths, path) == 0 })
    let names = map(paths, { _, path -> fnamemodify(path, ':t') })
    for name in names
        execute 'packadd' name
    endfor
endfunction

function! notomo#vimrc#update_remote_plugin() abort
    call notomo#vimrc#update_rplugin_runtimepath()
    UpdateRemotePlugins
endfunction

function! notomo#vimrc#clean() abort
    call minpac#clean()
    call notomo#vimrc#update_rplugin_runtimepath()
endfunction

function! notomo#vimrc#open_latest() abort
    if empty(v:oldfiles)
        return
    endif
    execute 'edit' v:oldfiles[0]
endfunction

function! notomo#vimrc#jq() abort
    let tmp = @+
    normal! ]}v%y
    tabedit | setlocal buftype=nofile noswapfile fileformat=unix
    put | %join!
    let @+ = tmp
    %!jq '.'
endfunction

function! notomo#vimrc#open_note() abort
    let dir_path = expand('~/workspace/memo')
    if !isdirectory(dir_path)
        call mkdir(dir_path, 'p')
    endif

    let file_path = dir_path . '/' . 'note.md'
    if !filereadable(file_path)
        call system(['touch', file_path])
    endif

    let before_tab_num = tabpagenr()
    execute 'tab drop' file_path
    execute 'lcd' dir_path

    let note_tab_num = tabpagenr()
    let offset = before_tab_num - note_tab_num
    if offset > 0
        execute 'tabmove +' . offset
    elseif offset < -1
        execute 'tabmove ' . (offset + 1)
    endif
endfunction

function! notomo#vimrc#open_proto(filetype) abort
    let type = empty(a:filetype) ? 'nofiletype' : a:filetype
    let dir_path = expand('~/workspace/proto/' . type)
    if !isdirectory(dir_path)
        call mkdir(dir_path, 'p')
    endif
    let pattern = dir_path . '/proto\.*'
    let paths = glob(pattern, v:true, v:true)
    call sort(paths, { a, b -> strlen(a) - strlen(b) })
    if !empty(paths)
        let file_path = paths[0]
    else
        let file_path = dir_path . '/proto.' . type
    endif
    execute 'tab drop' file_path
    execute 'lcd' dir_path
endfunction

let s:port = 49152
function! notomo#vimrc#mkup(open_current) abort
    if !executable('mkup')
        echomsg 'not found executable' | return
    endif

    let s:port += 1
    let port = get(g:, 'local#var#port', s:port)
    if exists('g:local#var#document_root') && !a:open_current
        let document_root = expand(g:local#var#document_root)
        let path = ''
    else
        let document_root = getcwd()
        let path = filereadable(expand('%:p')) ? expand('%') : ''
    endif

    if !isdirectory(document_root)
        echomsg document_root . ' is not directory' | return
    endif

    let cd_cmd = printf('cd %s;', document_root)
    let server_cmd = printf('mkup -http :%s', port)

    tabedit
    terminal
    let cmds = printf("%s\n%s\n", cd_cmd, server_cmd)
    call jobsend(b:terminal_job_id, cmds)

    let host = get(g:, 'local#var#host', 'localhost')
    let url = printf('http://%s:%s/%s', host, port, path)
    execute 'OpenBrowser' url

    tabprevious
    +tabclose
endfunction

function! notomo#vimrc#job(cmd) abort
    call jobstart(a:cmd, {
        \ 'on_exit': function('s:handle_exit'),
        \ 'on_stdout': function('s:handle_stdout'),
        \ 'on_stderr': function('s:handle_stderr'),
        \ 'stderr_buffered': v:true,
        \ 'stdout_buffered': v:true,
        \ 'cmd_name': join(a:cmd, ' '),
    \ })
endfunction

function! s:handle_stderr(job_id, data, event) abort dict
    echohl WarningMsg
    let data = filter(a:data, { _, v -> !empty(v) })
    for message in data
        echomsg printf('[%s]: %s', self.cmd_name, message)
    endfor
    echohl None
endfunction

function! s:handle_stdout(job_id, data, event) abort dict
    let data = filter(a:data, { _, v -> !empty(v) })
    for message in data
        echomsg printf('[%s]: %s', self.cmd_name, message)
    endfor
endfunction

function! s:handle_exit(job_id, exit_code, event) abort dict
endfunction
