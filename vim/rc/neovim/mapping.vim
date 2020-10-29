
if has('win32')
    tnoremap <C-u> <ESC>
endif

let s:MAIN_INPUT_PFX = notomo#mapping#get_main_input_key()
execute join(['tnoremap', s:MAIN_INPUT_PFX . 'h', '<Cmd>put +<CR>'])

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
nnoremap [exec]u :<C-u>call notomo#vimrc#update_remote_plugin()<CR>

nnoremap [exec]m :<C-u>call notomo#vimrc#mkup(v:false)<CR>
nnoremap [exec]M :<C-u>call notomo#vimrc#mkup(v:true)<CR>

nnoremap [exec]o :<C-u>call notomo#vimrc#job(['gh', 'repo', 'view', '--web'])<CR>
nnoremap [exec]P :<C-u>call notomo#github#view_pr()<CR>
nnoremap [exec]O :<C-u>call notomo#github#view_repo(expand('<cWORD>'))<CR>
nnoremap [exec]I :<C-u>call notomo#github#view_issue(expand('<cword>'))<CR>

let s:prompt_pattern = '\v^\$ '
let s:cmd_start_col = 2
let s:cmd_length_limit = 20
function! s:set_term_title() abort
    let prompt_lnum  = search(s:prompt_pattern, 'nbcW')
    let cmd = escape(getline(prompt_lnum)[s:cmd_start_col : s:cmd_length_limit], '|$"`')
    let cmd = substitute(cmd, '/', '\\\\', 'g')
    let cmd = substitute(cmd, '\v[+%{}]', '_', 'g')
    try
        let title = printf('%s:%s: %s', jobpid(b:terminal_job_id), &shell, cmd)
        execute 'file ' . title
    catch /^Vim\%((\a\+)\)\=:E900:/
    endtry
endfunction

tnoremap <CR> <Cmd>call <SID>set_term_title()<CR><CR>

nnoremap <silent> [yank]ud :<C-u>call notomo#vimrc#yank_and_echo(luaeval("require 'notomo/url'.cursor_url_decode()"))<CR>
nnoremap <silent> [yank]ue :<C-u>call notomo#vimrc#yank_and_echo(luaeval("require 'notomo/url'.cursor_url_encode()"))<CR>

xnoremap <silent> <C-j> :<C-u>lua require('notomo/insert').replace_down()<CR>gv
xnoremap <silent> <C-k> :<C-u>lua require('notomo/insert').replace_up()<CR>gv

nnoremap <silent> [yank]M :<C-u>call notomo#vimrc#yank_and_echo(trim(system('mongo --eval "(new ObjectId()).str" --quiet')))<CR>
