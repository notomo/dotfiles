setlocal nomodeline
setlocal completeopt-=preview
setlocal tabstop=2
setlocal softtabstop=2
call notomo#lsp#mapping()
nnoremap <buffer> [exec]bL <Cmd>tabedit<CR><Cmd>FlutterRun<CR><Cmd>only<CR>
nnoremap <buffer> [file]L <Cmd>FlutterHotRestart<CR>
