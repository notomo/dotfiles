
let s:COMMAND_DB_EXEC_SQL = ":DBExecSQL"
let s:LIMIT_NUM = 5

function! s:get_visual_selection()
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][col1 - 1:]
    return join(lines, "\n")
endfunction

function! s:range_lines(first_line_num, last_line_num) abort
    let lines = []
    for line_num in range(a:first_line_num, a:last_line_num)
        call add(lines, getline(line_num))
    endfor
    return lines
endfunction

function! s:unit_sql_lines(first_line_num, last_line_num) abort
    let lines = []
    let has_semicolon = 0
    for line_num in range(a:first_line_num, a:last_line_num)
        let line = getline(line_num)
        call add(lines, line)
        if line =~ ".*;$"
            let has_semicolon = 1
            break
        endif
    endfor
    if has_semicolon == 0
        call add(lines, ";")
    endif
    return lines
endfunction

function! s:execute_sql(sql) abort
    execute s:COMMAND_DB_EXEC_SQL . " " . a:sql
endfunction

function! tmno3#dbext#describe(table_name) abort
    if a:table_name != ""
        let sql = "DESC " . a:table_name . ";"
        call s:execute_sql(sql)
    endif
endfunction

function! tmno3#dbext#explain() range
    let lines_str = join(s:unit_sql_lines(a:firstline, a:lastline))
    let sql = "EXPLAIN " . lines_str
    call s:execute_sql(sql)
endfunction

function! tmno3#dbext#limit_execute() range
    let lines_str = join(s:unit_sql_lines(a:firstline, a:lastline))
    let sql = lines_str[0:-2] . " LIMIT " . s:LIMIT_NUM . ";"
    call s:execute_sql(sql)
endfunction

function! tmno3#dbext#select_value() abort
    let selection_text = s:get_visual_selection()
    let sql = "SELECT " . selection_text
    call s:execute_sql(sql)
endfunction
