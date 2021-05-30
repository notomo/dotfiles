setlocal completeopt-=preview
setlocal noexpandtab
call notomo#mapping#lsp()

nnoremap <buffer> <silent> [yank]I :<C-u>call notomo#vimrc#yank_and_echo(trim(system('go list -f "{{.ImportPath}}" ./')))<CR>
nnoremap <buffer> <silent> sgj :<C-u>call notomo#go#next()<CR>
nnoremap <buffer> <silent> sgk :<C-u>call notomo#go#prev()<CR>
nnoremap <buffer> <expr> [exec]bL ":\<C-u>TDDTest go/go -layout=horizontal -args=build\\ -o\\ " .. tempname() .. "\<CR>"

syntax keyword goKeywords nil iota true false
highlight link goKeywords Boolean

inoreabbrev <buffer> ~= !=
