if has('win32')
    finish
endif

tnoremap jj <C-\><C-n>

let s:LHS_KEY = notomo#mapping#get_lhs_key()
let s:RHS_KEY = notomo#mapping#get_rhs_key()

" not effective?
tnoremap <C-h> <Left>
tnoremap <C-j> <Down>
tnoremap <C-k> <Up>
tnoremap <C-l> <Right>
tnoremap <C-e> <End>
tnoremap <C-a> <Home>
tnoremap <C-b> <BS>
tnoremap <C-d> <Del>

tnoremap <BS> <Left>

for s:info in notomo#mapping#main_input()
    silent execute join(['tnoremap', s:info[s:LHS_KEY], s:info[s:RHS_KEY]])
endfor

for s:info in notomo#mapping#sub_input()
    silent execute join(['tnoremap', s:info[s:LHS_KEY], s:info[s:RHS_KEY]])
endfor

let s:MAIN_INPUT_PFX = notomo#mapping#get_main_input_key()
execute join(['tnoremap', s:MAIN_INPUT_PFX . 'h', '<C-\><C-N>pi'])
execute join(['tnoremap', s:MAIN_INPUT_PFX . 'o', '<Tab>'])

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

nnoremap [exec]C :<C-u>CheckHealth<CR>

nnoremap [exec]J :<C-u>Jesponse<Space>
nnoremap [exec]j :<C-u>JesponseCursorUrl<CR>
