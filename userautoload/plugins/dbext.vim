let s:COMMAND_DB_EXEC_SQL = ":DBExecSQL"
let s:LIMIT_NUM = 5

function! s:range_lines(first_line_num, last_line_num) abort
    let lines = []
    for line_num in range(a:first_line_num, a:last_line_num)
        call add(lines, getline(line_num))
    endfor
    return lines
endfunction

function! s:unit_sql_lines(first_line_num, last_line_num) abort
    let lines = []
    let hasSemiColon = 0
    for line_num in range(a:first_line_num, a:last_line_num)
        let line = getline(line_num)
        call add(lines, line)
        if line =~ ".*;$"
            let hasSemiColon = 1
            break
        endif
    endfor
    if hasSemiColon == 0
        call add(lines, ";")
    endif
    return lines
endfunction

function! s:execute_sql(sql) abort
    execute s:COMMAND_DB_EXEC_SQL . " " . a:sql
endfunction

nnoremap [dbext] <Nop>
nmap <Space>m [dbext]
vnoremap [dbext] <Nop>
vmap <Space>m [dbext]

nnoremap [dbext]u :<C-u>DBExecSQLUnderCursor<CR>
vnoremap [dbext]e :DBExecVisualSQL<CR>
nnoremap [dbext]l :<C-u>DBExecSQL SHOW TABLES;<CR>
nnoremap [dbext]d :<C-u>DBDescribeTable<CR>
nnoremap [dbext]h :<C-u>DBHistory<CR>
nnoremap [dbext]r :<C-u>DBResultsToggleResize<CR>
nnoremap [dbext]e :<C-u>DBExecSQL<Space>

nnoremap [dbext]f :<C-u>DescribeTableFromName<Space>
command! -nargs=1 DescribeTableFromName call <SID>describe_table_from_name(<f-args>)
function! s:describe_table_from_name(table_name) abort
    if a:table_name != ""
        let sql = "DESC " . a:table_name . ";"
        call s:execute_sql(sql)
    endif
endfunction

vnoremap [dbext]x :<C-u>'<,'>ExplainSQL<CR>
command! -range ExplainSQL :<line1>,<line2>call <SID>explain_sql()
function! s:explain_sql() range
    let lines_str = join(s:unit_sql_lines(a:firstline, a:lastline))
    let sql = "EXPLAIN " . lines_str
    call s:execute_sql(sql)
endfunction

vnoremap [dbext]m :<C-u>'<,'>ExecuteLimitSQL<CR>
command! -range ExecuteLimitSQL :<line1>,<line2>call <SID>execute_limit_sql()
function! s:execute_limit_sql() range
    let lines_str = join(s:unit_sql_lines(a:firstline, a:lastline))
    let sql = lines_str[0:-2] . " LIMIT " . s:LIMIT_NUM . ";"
    call s:execute_sql(sql)
endfunction

function! s:get_visual_selection()
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][col1 - 1:]
    return join(lines, "\n")
endfunction

vnoremap [dbext]s :<C-u>call <SID>select_value()<CR>
function! s:select_value() abort
    let selection_text = s:get_visual_selection()
    let sql = "SELECT " . selection_text
    call s:execute_sql(sql)
endfunction
