nnoremap [test]t :<C-u>TDDTest make npm<CR>
nnoremap [test]f :<C-u>TDDTest -layout=horizontal -target=file<CR>
nnoremap [test]l :<C-u>TDDTest -last<CR>
nnoremap [test]n :<C-u>TDDTest -layout=horizontal -target=near<CR>

nnoremap [exec]i :<C-u>TDDTest make_lint npm_lint<CR>
nnoremap [exec]bl :<C-u>TDDTest make_build npm_build<CR>
nnoremap S :<C-u>TDDTest make_start npm_start<CR>
nnoremap [exec]dd :<C-u>TDDTest make_doc<CR>

nnoremap <Leader>Q :<C-u>TDDTest -type=run -layout=horizontal -target=file<CR>

autocmd MyAuGroup User TDDSourceLoad ++once call s:settings()
function! s:settings() abort
    call tdd#command#alias('make_lint', 'make')
    call tdd#command#args('make_lint', ['lint'])
    call tdd#command#alias('npm_lint', 'npm')
    call tdd#command#args('npm_lint', ['run', 'lint'])

    call tdd#command#alias('make_build', 'make')
    call tdd#command#args('make_build', ['build'])
    call tdd#command#alias('npm_build', 'npm')
    call tdd#command#args('npm_build', ['run', 'build'])

    call tdd#command#alias('make_start', 'make')
    call tdd#command#args('make_start', ['start'])
    call tdd#command#alias('npm_start', 'npm')
    call tdd#command#args('npm_start', ['start'])

    call tdd#command#alias('make_doc', 'make')
    call tdd#command#args('make_doc', ['doc'])
endfunction
