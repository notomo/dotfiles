
if has('win32')
    tnoremap <C-u> <ESC>
endif

let s:MAIN_INPUT_PFX = notomo#mapping#get_main_input_key()
execute join(['tnoremap', s:MAIN_INPUT_PFX . 'h', '<C-\><C-N>pi'])

nnoremap [term] <Nop>
nmap <Space>t [term]

nnoremap <silent> [term]o :<C-u>terminal<CR>

function! s:open_terminal(open_cmd) abort
    execute a:open_cmd
    execute 'terminal'
endfunction
nnoremap <silent> [term]v :<C-u>call <SID>open_terminal('vsplit')<CR>
nnoremap <silent> [term]h :<C-u>call <SID>open_terminal('split')<CR>
nnoremap <silent> [term]t :<C-u>call <SID>open_terminal('tabedit')<CR>

nnoremap [exec]C :<C-u>checkhealth<CR>

nnoremap [exec]J :<C-u>Jesponse<Space>
nnoremap [exec]j :<C-u>JesponseCursorUrl<CR>

nnoremap [exec]m :<C-u>call _run_http_server_and_open(v:false)<CR>
nnoremap [exec]M :<C-u>call _run_http_server_and_open(v:true)<CR>
