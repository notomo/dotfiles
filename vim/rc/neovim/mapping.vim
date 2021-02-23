
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
nnoremap <silent> [term]g :<C-u>call <SID>open_terminal_on_project_root()<CR>

function! s:open_terminal_on_project_root() abort
    let path = finddir('.git', ',;')
    let project_path = '.'
    if path != ''
        let project_path = fnamemodify(path, ':p:h:h')
    endif
    tabedit
    call termopen(&shell, {'cwd': project_path})
    execute 'lcd' project_path
endfunction

nnoremap [exec]C :<C-u>checkhealth<CR>
nnoremap [exec]u :<C-u>call notomo#vimrc#update_remote_plugin()<CR>

nnoremap [exec]m :<C-u>call notomo#vimrc#mkup(v:false)<CR>
nnoremap [exec]M :<C-u>call notomo#vimrc#mkup(v:true)<CR>

nnoremap [exec]o :<C-u>call notomo#vimrc#job(['gh', 'repo', 'view', '--web'])<CR>
nnoremap [exec]P :<C-u>call notomo#github#view_pr()<CR>
nnoremap [exec]O :<C-u>call notomo#github#view_repo(expand('<cWORD>'))<CR>
nnoremap [exec]I :<C-u>call notomo#github#view_issue(expand('<cword>'))<CR>

function! s:set_title(prompt_pattern, max_length) abort
    let path = nvim_buf_get_name(0)
    let shell = split(fnamemodify(path, ':t'), ':')[0]
    let term_path = printf('%s/%s', fnamemodify(path, ':h'), shell)

    let prompt_line = getline(search(a:prompt_pattern, 'nbcW'))
    let prompt = matchstr(prompt_line, a:prompt_pattern)
    let cmd = prompt_line[strlen(prompt) : a:max_length]
    let cmd = substitute(cmd, '/', '\\', 'g')

    call nvim_buf_set_name(0, printf('%s:%s', term_path, cmd))
    redrawtabline
endfunction

tnoremap <CR> <Cmd>call <SID>set_title('^\$ ', 24)<CR><CR>

nnoremap <silent> [yank]ud :<C-u>call notomo#vimrc#yank_and_echo(luaeval("require 'notomo/url'.cursor_url_decode()"))<CR>
nnoremap <silent> [yank]ue :<C-u>call notomo#vimrc#yank_and_echo(luaeval("require 'notomo/url'.cursor_url_encode()"))<CR>

xnoremap <silent> <C-j> :<C-u>lua require('notomo/insert').replace_down()<CR>gv
xnoremap <silent> <C-k> :<C-u>lua require('notomo/insert').replace_up()<CR>gv

nnoremap <silent> [yank]M :<C-u>call notomo#vimrc#yank_and_echo(trim(system('mongo --eval "(new ObjectId()).str" --quiet')))<CR>

nnoremap [win]O <Cmd>lua require("wintablib.window").close_floating()<CR>
nnoremap [win]H <Cmd>lua require("wintablib.window").from_left_tab()<CR>
nnoremap [win]L <Cmd>lua require("wintablib.window").from_right_tab()<CR>
nnoremap [win]l <Cmd>lua require("wintablib.window").to_right_tab()<CR>
nnoremap [win]w <Cmd>lua require("wintablib.window").duplicate_as_right_tab()<CR>
nnoremap [win]b <Cmd>lua require("wintablib.window").from_alt()<CR>
nnoremap [win]j <Cmd>lua require("wintablib.window").close_downside()<CR>
nnoremap [win]; <Cmd>lua require("wintablib.window").close_rightside()<CR>
nnoremap [win]a <Cmd>lua require("wintablib.window").close_leftside()<CR>
nnoremap [winmv]f <Cmd>lua require("wintablib.window").focus_on_floating()<CR>
nnoremap <silent> <Plug>(tabclose_r) <Cmd>lua require("wintablib.tab").close_right()<CR>
nnoremap <silent> <Plug>(tabclose_l) <Cmd>lua require("wintablib.tab").close_left()<CR>
nnoremap <silent> <Plug>(tabclose_c) <Cmd>lua require("wintablib.tab").close()<CR>
nnoremap <silent> <Plug>(new_tab) <Cmd>lua require("wintablib.tab").scratch()<CR>

function! s:start_termdebug() abort
    packadd termdebug

    let path = expand('~/workspace/neovim/')
    let nvim = path .. 'build/bin/nvim'
    let rc = expand('~/dotfiles/tool/nvim_development/debugrc.vim')
    tabedit
    execute 'tcd' path
    execute 'TermdebugCommand' nvim '-u' rc
    call TermDebugSendCommand('run')
    Source

    nnoremap [term]s <Cmd>Step<CR>
    nnoremap [term]b <Cmd>Break<CR>
    nnoremap [term]B <Cmd>Clear<CR>
    nnoremap [term]n <Cmd>Over<CR>
    nnoremap [term]c <Cmd>Continue<CR>
    nnoremap [term]f <Cmd>Finish<CR>
    nnoremap [keyword]e :Evaluate<CR>

    " restore K
    nnoremap <silent> <S-k> :<C-u>keepjumps normal! {<CR>
endfunction

function! s:quit_termdebug() abort
    if !exists('*TermDebugSendCommand')
        return
    endif
    try
        call TermDebugSendCommand('quit')
        call TermDebugSendCommand('y')
    catch /Can't send data to closed stream\|E900: Invalid channel id/
    endtry
endfunction

nnoremap [term]S <Cmd>call <SID>start_termdebug()<CR>
nnoremap [term]q <Cmd>call <SID>quit_termdebug()<CR>
