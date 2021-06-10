setlocal completeopt-=preview
setlocal noexpandtab
call notomo#mapping#lsp()

nnoremap <buffer> <silent> [yank]I <Cmd>call notomo#vimrc#yank_and_echo(trim(system('go list -f "{{.ImportPath}}" ./')))<CR>
nnoremap <buffer> <silent> sgj <Cmd>call notomo#go#next()<CR>
nnoremap <buffer> <silent> sgk <Cmd>call notomo#go#prev()<CR>
nnoremap <buffer> [exec]bL <Cmd>lua require("cmdhndlr").build()<CR>

syntax keyword goKeywords nil iota true false
highlight link goKeywords Boolean

inoreabbrev <buffer> ~= !=
