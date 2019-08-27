nnoremap [test]t :<C-u>TDDTest make npm<CR>

call tdd#command#alias('make_lint', 'make')
call tdd#command#args('make_lint', ['lint'])
call tdd#command#alias('npm_lint', 'npm')
call tdd#command#args('npm_lint', ['run', 'lint'])
nnoremap [exec]i :<C-u>TDDTest make_lint npm_lint<CR>

call tdd#command#alias('make_build', 'make')
call tdd#command#args('make_build', ['build'])
call tdd#command#alias('npm_build', 'npm')
call tdd#command#args('npm_build', ['run', 'build'])
nnoremap [exec]bl :<C-u>TDDTest make_build npm_build<CR>

call tdd#command#alias('make_start', 'make')
call tdd#command#args('make_start', ['start'])
call tdd#command#alias('npm_start', 'npm')
call tdd#command#args('npm_start', ['start'])
nnoremap S :<C-u>TDDTest make_start npm_start<CR>
