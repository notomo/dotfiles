
call curstr#custom#filetype_alias('toml', 'vim')

call curstr#custom#source_alias('openable', ['blade', 'vim/function', 'file', 'directory', 'vim/runtime'])


call curstr#custom#source_alias('bool', ['togglable/word/simple'])
call curstr#custom#source_option('bool', 'words', ['true', 'false'])
call curstr#custom#source_option('bool', 'normalized', v:true)

call curstr#custom#source_alias('access', ['togglable/word/simple'])
call curstr#custom#source_option('access', 'words', ['public', 'protected', 'private'])

call curstr#custom#source_alias('camel_snake', ['togglable/word/regex'])
call curstr#custom#source_option('camel_snake', 'patterns', [['\v_(.)', '\u\1'], ['\v\C([A-Z])', '_\l\1']])

call curstr#custom#source_alias('togglable', ['bool', 'access', 'camel_snake'])

call curstr#custom#source_alias('debug', ['togglable/line/regex'])
call curstr#custom#source_option('debug', 'patterns', [['\v^\s*([^=[:space:]]*).*$', 'var_dump(\1);']])

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


call curstr#custom#execute_option('use-cache', v:false)
