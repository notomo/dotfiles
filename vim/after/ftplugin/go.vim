setlocal completeopt-=preview
setlocal noexpandtab
nnoremap <buffer> [keyword]o :<C-u>GoDef<CR>
nnoremap <buffer> [keyword]v :<C-u>vsplit \| GoDef<CR>
nnoremap <buffer> [keyword]h :<C-u>split \| GoDef<CR>
nnoremap <buffer> [keyword]t :<C-u>call notomo#window#duplicate() \| GoDef<CR>
nmap <buffer> [keyword]k <Plug>(go-info)
nmap <buffer> sgj ]]
nmap <buffer> sgk [[
nnoremap <buffer> [exec]bl :<C-u>GoBuild<CR>
nnoremap <buffer> [exec]gr :<C-u>GoReferrers<CR>
nnoremap <buffer> [exec]gi :<C-u>GoImplements<CR>
nnoremap <buffer> [test]g :<C-u>GoCoverageToggle<CR>
nnoremap <buffer> [denite]o :<C-u>Denite decls -auto-preview<CR>
