
function! notomo#vimrc#exchange() abort
    let pos = getpos('.')
    execute 's/\v%#(\_.)(\_.)/\2\1/g'
    call setpos('.', pos)
    normal! l
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
    normal! G
endfunction

function! notomo#vimrc#open_sandbox(name, filetype) abort
    let type = empty(a:filetype) ? 'nofiletype' : a:filetype
    let dir_path = expand('~/workspace/proto/' . type)
    if !isdirectory(dir_path)
        call mkdir(dir_path, 'p')
    endif
    let file_path = join([dir_path, a:name], '/')
    execute 'tab drop' file_path
    execute 'lcd' dir_path
endfunction

function! notomo#vimrc#rotate_file() abort
    let origin = expand("%")
    if empty(origin)
        return
    endif
    for i in range(10000)
        let name = printf('%s_%s', i, origin)
        if !filereadable(name) && !bufexists(name)
            execute 'file' name
            write
            execute 'edit' origin
            return
        endif
    endfor
    throw 'fail rotate:' .. origin
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
