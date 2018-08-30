
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

function! notomo#vimrc#syntax_report() abort
    syntime on
    redraw!
    syntime off
    Capture syntime report
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

function! notomo#vimrc#url_decode() abort
    let url = expand('<cWORD>')
    return _url_decode(url)
endfunction

function! notomo#vimrc#url_encode() abort
    let url = expand('<cWORD>')
    return _url_encode(url)
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

function! notomo#vimrc#silent_handler(id, data, event) abort
endfunction

function! notomo#vimrc#escape_search_pattern(str) abort
    let escaped = escape(a:str, '\/')
    return substitute(escaped, "\n", '\\n', 'g')
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
