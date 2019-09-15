setlocal completeopt-=preview
nnoremap <buffer> [keyword]o :<C-u>LspDefinition<CR>
nnoremap <buffer> [keyword]v :<C-u>vsplit \| LspDefinition<CR>
nnoremap <buffer> [keyword]h :<C-u>split \| LspDefinition<CR>
nnoremap <buffer> [keyword]t :<C-u>call notomo#window#duplicate() \| LspDefinition<CR>
nnoremap <buffer> [keyword]r :<C-u>LspHover<CR>

nnoremap <buffer> <silent> sgj :<C-u>call notomo#rust#next()<CR>
nnoremap <buffer> <silent> sgk :<C-u>call notomo#rust#prev()<CR>
