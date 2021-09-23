setlocal foldmethod=marker
let b:match_words = '\<if\>:\<elseif\>:\<else\>:\<endif\>,\<for\>:\<endfor\>,\<while\>:\<endwhile\>,\<try\>:\<catch\>:\<finally\>:\<endtry\>,\<func\(tion\)\?\>:\<endfunc\(tion\)\?\>,\<augroup [^E]\w*\>:\<augroup END\>'
setlocal iskeyword-=#

nnoremap <buffer> [exec]s <Cmd>source %<CR>
nnoremap <buffer> <silent> sgj <Cmd>lua require("notomo.vim").next()<CR>
nnoremap <buffer> <silent> sgk <Cmd>lua require("notomo.vim").prev()<CR>
call notomo#mapping#lsp()
