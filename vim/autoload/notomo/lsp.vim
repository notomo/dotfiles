
function! notomo#lsp#mapping() abort
    nnoremap <buffer> [keyword]o <Cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <buffer> [keyword]v :<C-u>vsplit \| lua vim.lsp.buf.definition()<CR>
    nnoremap <buffer> [keyword]h :<C-u>split \| lua vim.lsp.buf.definition()<CR>
    nnoremap <buffer> [keyword]t :<C-u>call notomo#window#duplicate() \| lua vim.lsp.buf.definition()<CR>
endfunction
