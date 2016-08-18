

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

