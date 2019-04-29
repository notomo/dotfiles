
call curstr#custom#filetype_alias('toml', 'vim')

call curstr#custom#source_alias('swagger', ['file/pattern'])
call curstr#custom#source_option('swagger', 'source_pattern', '\v^([^#]*)#(\/[^/]*)*(\w+)$')
call curstr#custom#source_option('swagger', 'result_pattern', '\1')
call curstr#custom#source_option('swagger', 'search_pattern', '\3:')

call curstr#custom#source_alias('openable', ['vim/function', 'swagger', 'file', 'directory', 'vim/runtime'])


call curstr#custom#source_alias('bool', ['togglable/word/simple'])
call curstr#custom#source_option('bool', 'words', ['true', 'false'])
call curstr#custom#source_option('bool', 'normalized', v:true)

call curstr#custom#source_alias('access', ['togglable/word/simple'])
call curstr#custom#source_option('access', 'words', ['public', 'protected', 'private'])

call curstr#custom#source_alias('camel_snake', ['togglable/word/regex'])
call curstr#custom#source_option('camel_snake', 'patterns', [['\v_(.)', '\u\1'], ['\v\C([A-Z])', '_\l\1']])

call curstr#custom#source_alias('togglable', ['bool', 'access', 'camel_snake'])

call curstr#custom#source_alias('quote', ['togglable/line/regex'])
call curstr#custom#source_option('quote', 'patterns', [["\\v^([^'\"].*[^'\"])$", "'\\1'"], ["\\v^'(.*)'$", '"\1"'], ['\v"(.*)"', '\1']])

let s:pattern_groups = [
    \ ['%_test.go', '%.go'],
    \ ['%.test.ts', '%.ts'],
    \ ['%lazy.toml', '%eager.toml'],
    \ ['%/autoload/notomo/%.vim', '%/rc/plugins/%.vim'],
    \ ['%/test/rplugin/%/test_%.py', '%/rplugin/%/%.py'],
    \ ['%/test/autoload/%.vim', '%/autoload/%.vim'],
    \ ['%/test/plugin/%.vim', '%/plugin/%.vim'],
\ ]
call curstr#custom#source_alias('altr_next', ['togglable/file'])
call curstr#custom#source_option('altr_next', 'pattern_groups', s:pattern_groups)
call curstr#custom#source_alias('altr_previous', ['altr_next'])
call curstr#custom#source_option('altr_previous', 'offset', -1)
nnoremap [file]f :<C-u>Curstr altr_next<CR>
nnoremap [file]b :<C-u>Curstr altr_previous<CR>
nnoremap [file]l :<C-u>Curstr altr_next -action=tab_open<CR>
nnoremap [file]h :<C-u>Curstr altr_next -action=vertical_open<CR>

call curstr#custom#source_alias('altr_next_new', ['altr_next'])
call curstr#custom#source_option('altr_next_new', 'create', v:true)
nnoremap [file]t :<C-u>Curstr altr_next_new<CR>

call curstr#custom#source_alias('print_vim', ['togglable/line/regex'])
call curstr#custom#source_option('print_vim', 'patterns', [['\v^(\s*)let\s+([^=[:space:]]*).*$', '\1echomsg string(\2)']])
call curstr#custom#source_option('print_vim', 'filetypes', ['vim'])
call curstr#custom#source_alias('print_go', ['togglable/line/regex'])
call curstr#custom#source_option('print_go', 'patterns', [['\v^(\s*)([^=[:space:],]*).*$', '\1fmt.Println(\2)']])
call curstr#custom#source_option('print_go', 'filetypes', ['go'])
call curstr#custom#source_alias('print_python', ['togglable/line/regex'])
call curstr#custom#source_option('print_python', 'patterns', [['\v^(\s*)([^=[:space:],]*).*$', '\1print(\2)']])
call curstr#custom#source_option('print_python', 'filetypes', ['python'])
call curstr#custom#source_alias('print_js', ['togglable/line/regex'])
call curstr#custom#source_option('print_js', 'patterns', [['\v^(\s*)(let\s+|const\s+)?([^=[:space:],]*).*$', '\1console.log(\3)']])
call curstr#custom#source_option('print_js', 'filetypes', ['javascript'])
call curstr#custom#source_alias('print_ts', ['togglable/line/regex'])
call curstr#custom#source_option('print_ts', 'patterns', [['\v^(\s*)(let\s+|const\s+)?([^=[:space:],:]*).*$', '\1console.log(\3)']])
call curstr#custom#source_option('print_ts', 'filetypes', ['typescript'])
call curstr#custom#source_alias('print_rust', ['togglable/line/regex'])
call curstr#custom#source_option('print_rust', 'patterns', [['\v^(\s*)let\s+(mut\s+)?([^=[:space:],:]*).*$', '\1println!("{:?}", \3);']])
call curstr#custom#source_option('print_rust', 'filetypes', ['rust'])
call curstr#custom#source_alias('print', ['print_vim', 'print_go', 'print_python', 'print_js', 'print_ts', 'print_rust'])
nnoremap [replace]j :<C-u>Curstr print -action=append<CR>

call curstr#custom#execute_option('use-cache', v:false)
