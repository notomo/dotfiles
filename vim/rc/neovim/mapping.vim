if has('win32')
    finish
endif

tnoremap jj <C-\><C-n>

let s:LHS_KEY = tmno3#mapping#get_lhs_key()
let s:RHS_KEY = tmno3#mapping#get_rhs_key()

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

for s:info in tmno3#mapping#main_input()
    silent execute join(['tnoremap', s:info[s:LHS_KEY], s:info[s:RHS_KEY]])
endfor

for s:info in tmno3#mapping#sub_input()
    silent execute join(['tnoremap', s:info[s:LHS_KEY], s:info[s:RHS_KEY]])
endfor

let s:MAIN_INPUT_PFX = tmno3#mapping#get_main_input_key()
execute join(['tnoremap', s:MAIN_INPUT_PFX . 'h', '<C-\><C-N>pi'])
execute join(['tnoremap', s:MAIN_INPUT_PFX . 'o', '<Tab>'])

nnoremap [term] <Nop>
nmap <Space>t [term]

nnoremap <silent> [term]o :<C-u>terminal<CR>
nnoremap <silent> [term]v :<C-u>vsplit term://bash<CR>
nnoremap <silent> [term]h :<C-u>split term://bash<CR>
nnoremap <silent> [term]t :<C-u>tabedit term://bash<CR>

nnoremap [exec]c :<C-u>CheckHealth<CR>

nnoremap [exec]j :<C-u>Jesponsiv2<Space>
