setlocal nomodeline
setlocal completeopt-=preview
setlocal tabstop=2
setlocal softtabstop=2
call notomo#lsp#mapping()
nnoremap <buffer> [exec]bL <Cmd>tabedit<CR><Cmd>FlutterRun<CR><Cmd>only<CR>
nnoremap <buffer> [file]L <Cmd>FlutterHotRestart<CR>
nnoremap <buffer> [finder]o <Cmd>Thetto lsp_adapter/dart_outline --auto=preview<CR>
nnoremap <buffer> [finder]O <Cmd>Thetto lsp_adapter/flutter_outline --auto=preview<CR>
