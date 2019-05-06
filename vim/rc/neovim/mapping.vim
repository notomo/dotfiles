
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

nnoremap [test]t :<C-u>call <SID>execute_project_test()<CR>
nnoremap [exec]bl :<C-u>call <SID>execute_project_build()<CR>
nnoremap [exec]i :<C-u>call <SID>execute_project_lint()<CR>
nnoremap S :<C-u>call <SID>execute_project_start()<CR>

function! s:execute_project_test() abort
    let makefile_path = notomo#vimrc#search_parent_recursive('Makefile', './')
    if !empty(makefile_path)
        call s:execute(fnamemodify(makefile_path, ':h'), 'make test')
        return
    endif
    let package_json_path = notomo#vimrc#search_parent_recursive('package.json', './')
    if !empty(package_json_path)
        call s:execute(fnamemodify(package_json_path, ':h'), 'npm test')
        return
    endif
endfunction

function! s:execute_project_lint() abort
    let makefile_path = notomo#vimrc#search_parent_recursive('Makefile', './')
    if !empty(makefile_path)
        call s:execute(fnamemodify(makefile_path, ':h'), 'make lint')
        return
    endif
    let package_json_path = notomo#vimrc#search_parent_recursive('package.json', './')
    if !empty(package_json_path)
        call s:execute(fnamemodify(package_json_path, ':h'), 'npm run lint')
        return
    endif
endfunction

function! s:execute_project_build() abort
    let makefile_path = notomo#vimrc#search_parent_recursive('Makefile', './')
    if !empty(makefile_path)
        call s:execute(fnamemodify(makefile_path, ':h'), 'make build')
        return
    endif

    let package_json_path = notomo#vimrc#search_parent_recursive('package.json', './')
    if !empty(package_json_path)
        call s:execute(fnamemodify(package_json_path, ':h'), 'npm run build')
        return
    endif
endfunction

function! s:execute_project_start() abort
    let makefile_path = notomo#vimrc#search_parent_recursive('Makefile', './')
    if !empty(makefile_path)
        call s:execute(fnamemodify(makefile_path, ':h'), 'make start')
        return
    endif

    let package_json_path = notomo#vimrc#search_parent_recursive('package.json', './')
    if !empty(package_json_path)
        call s:execute(fnamemodify(package_json_path, ':h'), 'npm start')
        return
    endif
endfunction

function! s:execute(dir, command) abort
    let commands = ['cd ' . a:dir, a:command]
    tabedit
    execute 'terminal ' . join(commands, ';')
endfunction

let s:prompt_pattern = '\v^\$ '
let s:cmd_start_col = 2
let s:cmd_length_limit = 20
function! s:set_term_title() abort
    let prompt_lnum  = search(s:prompt_pattern, 'nbczW')
    let cmd = escape(getline(prompt_lnum)[s:cmd_start_col : s:cmd_length_limit], '|$"`')
    let cmd = substitute(cmd, '/', '\\\\', 'g')
    let cmd = substitute(cmd, '\v\+|\%', '_', 'g')
    let title = printf('%s:%s: %s', jobpid(b:terminal_job_id), &shell, cmd)
    execute 'file ' . title
endfunction

tnoremap <CR> <Cmd>call <SID>set_term_title()<CR><CR>
