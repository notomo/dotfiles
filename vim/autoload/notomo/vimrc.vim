
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

function! notomo#vimrc#to_next_syntax(syntax_name, offset) abort
    call s:to_syntax(a:syntax_name, line('.'), a:offset, v:false, v:true)
endfunction

function! notomo#vimrc#to_previous_syntax(syntax_name, offset) abort
    call s:to_syntax(a:syntax_name, line('.'), a:offset, v:true, v:true)
endfunction

function! s:to_syntax(syntax_name, start_line_num, offset, go_backword, wrap) abort
    let syntax_id = hlID(a:syntax_name)
    if syntax_id == 0
        echomsg 'Invalid syntax name: ' . a:syntax_name
        return
    endif
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
        if syntax_id == synID(line_num, 1, 1)
            call setpos('.', [bufnr('%'), line_num + a:offset, 1, 0])
            return
        endif
        let line_num += move_line_num
    endwhile
    if a:wrap == v:false
        return
    endif
    call s:to_syntax(a:syntax_name, wrap_line_num, a:offset, a:go_backword, v:false)
endfunction
