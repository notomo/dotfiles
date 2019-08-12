
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
nnoremap [exec]u :<C-u>UpdateRemotePlugins<CR>

nnoremap [exec]m :<C-u>call _run_http_server_and_open(v:false)<CR>
nnoremap [exec]M :<C-u>call _run_http_server_and_open(v:true)<CR>

nnoremap [exec]o :<C-u>call jobstart("hub browse")<CR>

nnoremap [exec]N :<C-u>call _open_note()<CR>

let s:prompt_pattern = '\v^\$ '
let s:cmd_start_col = 2
let s:cmd_length_limit = 20
function! s:set_term_title() abort
    let prompt_lnum  = search(s:prompt_pattern, 'nbczW')
    let cmd = escape(getline(prompt_lnum)[s:cmd_start_col : s:cmd_length_limit], '|$"`')
    let cmd = substitute(cmd, '/', '\\\\', 'g')
    let cmd = substitute(cmd, '\v\+|\%', '_', 'g')
    try
        let title = printf('%s:%s: %s', jobpid(b:terminal_job_id), &shell, cmd)
        execute 'file ' . title
	catch /^Vim\%((\a\+)\)\=:E900:/
    endtry
endfunction

tnoremap <CR> <Cmd>call <SID>set_term_title()<CR><CR>
