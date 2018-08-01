
call curstr#custom#filetype_alias('toml', 'vim')

call curstr#custom#source_alias('openable', ['blade', 'vim/function', 'vim/runtime', 'file', 'directory'])


call curstr#custom#source_alias('bool', ['togglable/word/simple'])
call curstr#custom#source_option('bool', 'words', ['true', 'false'])
call curstr#custom#source_option('bool', 'normalized', v:true)

call curstr#custom#source_alias('access', ['togglable/word/simple'])
call curstr#custom#source_option('access', 'words', ['public', 'protected', 'private'])

call curstr#custom#source_alias('dein_hook', ['togglable/word/simple'])
call curstr#custom#source_option('dein_hook', 'words', ['hook_add', 'hook_source', 'hook_post_source'])
call curstr#custom#source_option('dein_hook', 'filetypes', ['toml'])

call curstr#custom#source_alias('camel_snake', ['togglable/word/regex'])
call curstr#custom#source_option('camel_snake', 'patterns', [['\v_(.)', '\u\1'], ['\v\C([A-Z])', '_\l\1']])

call curstr#custom#source_alias('vim_arg', ['togglable/word/regex'])
call curstr#custom#source_option('vim_arg', 'patterns', [['\va:(.*)', '\1'], ['\v^\ze[^a]*', 'a:']])
call curstr#custom#source_option('vim_arg', 'filetypes', ['vim'])
call curstr#custom#source_option('vim_arg', 'added_iskeyword', ':')

call curstr#custom#source_alias('slash', ['togglable/line/regex'])
call curstr#custom#source_option('slash', 'patterns', [['\\', '/'], ['/', '\\']])

call curstr#custom#source_alias('togglable', ['bool', 'access', 'dein_hook', 'vim_arg', 'camel_snake', 'slash'])

call curstr#custom#source_alias('debug', ['togglable/line/regex'])
call curstr#custom#source_option('debug', 'patterns', [['\v^\s*([^=[:space:]]*).*$', 'var_dump(\1);']])

call curstr#custom#source_alias('quote', ['togglable/line/regex'])
call curstr#custom#source_option('quote', 'patterns', [["\\v^([^'\"].*[^'\"])$", "'\\1'"], ["\\v^'(.*)'$", '"\1"'], ['\v"(.*)"', '\1']])


call curstr#custom#execute_option('use-cache', v:false)
