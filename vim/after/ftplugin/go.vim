setlocal completeopt-=preview
setlocal noexpandtab
nnoremap <buffer> [keyword]o :<C-u>LspDefinition<CR>
nnoremap <buffer> [keyword]v :<C-u>vsplit \| LspDefinition<CR>
nnoremap <buffer> [keyword]h :<C-u>split \| LspDefinition<CR>
nnoremap <buffer> [keyword]t :<C-u>call notomo#window#duplicate() \| LspDefinition<CR>

nnoremap <buffer> <silent> sgj :<C-u>call go#textobj#FunctionJump('n', 'next')<CR>
nnoremap <buffer> <silent> sgk :<C-u>call go#textobj#FunctionJump('n', 'prev')<CR>
xnoremap <buffer> <silent> sgj :<C-u>call go#textobj#FunctionJump('v', 'next')<CR>
xnoremap <buffer> <silent> sgk :<C-u>call go#textobj#FunctionJump('v', 'prev')<CR>

nnoremap <buffer> <silent> [yank]I :<C-u>call notomo#vimrc#yank_and_echo(trim(system('go list -f "{{.ImportPath}}" ./')))<CR>
nnoremap <buffer> <silent> [denite]K :<C-u>call notomo#denite#go_package_dir()<CR>
