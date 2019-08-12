nnoremap [test]t :<C-u>TDDTest make npm<CR>

call tdd#config#command_alias('make_lint', 'make')
call tdd#config#command('make_lint', ['lint'])
call tdd#config#command_alias('npm_lint', 'npm')
call tdd#config#command('npm_lint', ['run', 'lint'])
nnoremap [exec]i :<C-u>TDDTest make_lint npm_lint<CR>

call tdd#config#command_alias('make_build', 'make')
call tdd#config#command('make_build', ['build'])
call tdd#config#command_alias('npm_build', 'npm')
call tdd#config#command('npm_build', ['run', 'build'])
nnoremap [exec]bl :<C-u>TDDTest make_build npm_build<CR>

call tdd#config#command_alias('make_start', 'make')
call tdd#config#command('make_start', ['start'])
call tdd#config#command_alias('npm_start', 'npm')
call tdd#config#command('npm_start', ['start'])
nnoremap S :<C-u>TDDTest make_start npm_start<CR>
