
if !has('nvim') && !has('terminal')
    finish
endif

let s:LHS_KEY = notomo#mapping#get_lhs_key()
let s:RHS_KEY = notomo#mapping#get_rhs_key()

tnoremap jj <C-\><C-n>

if has('win32')
    tnoremap <C-u> <C-Home>
endif

for s:info in notomo#mapping#main_input()
    silent execute join(['tnoremap', s:info[s:LHS_KEY], s:info[s:RHS_KEY]])
endfor

for s:info in notomo#mapping#sub_input()
    silent execute join(['tnoremap', s:info[s:LHS_KEY], s:info[s:RHS_KEY]])
endfor

let s:MAIN_INPUT_PFX = notomo#mapping#get_main_input_key()
execute join(['tnoremap', s:MAIN_INPUT_PFX . 'o', '<Tab>'])
execute join(['tnoremap', s:MAIN_INPUT_PFX . 'h', '<C-w>"+'])

nnoremap [term] <Nop>
nmap <Space>t [term]

nnoremap <silent> [term]o :<C-u>terminal ++curwin<CR>

function! s:open_terminal(open_cmd) abort
    execute a:open_cmd . ' terminal'
endfunction
nnoremap <silent> [term]v :<C-u>call <SID>open_terminal('vertical')<CR>
nnoremap <silent> [term]h :<C-u>call <SID>open_terminal('')<CR>
nnoremap <silent> [term]t :<C-u>call <SID>open_terminal('tab')<CR>

