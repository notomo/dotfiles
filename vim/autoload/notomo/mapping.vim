
let s:LHS_KEY = 'l'
let s:RHS_KEY = 'r'
let s:MAP_ONLY_KEY = 'o'
let s:REMAP_KEY = 'rm'
let s:MAIN_INPUT_PFX = 'j<Space>'
let s:SUB_INPUT_PFX = 'jk'
let s:CALCULATOR_KEY = s:SUB_INPUT_PFX . '<CR>'

function! notomo#mapping#get_lhs_key() abort
    return s:LHS_KEY
endfunction

function! notomo#mapping#get_rhs_key() abort
    return s:RHS_KEY
endfunction

function! notomo#mapping#get_map_only_key() abort
    return s:MAP_ONLY_KEY
endfunction

function! notomo#mapping#get_remap_key() abort
    return s:REMAP_KEY
endfunction

function! notomo#mapping#get_main_input_key() abort
    return s:MAIN_INPUT_PFX
endfunction

function! notomo#mapping#get_calculator_key() abort
    return s:CALCULATOR_KEY
endfunction

function! notomo#mapping#tab() abort
    let mappings = []
    call add(mappings, {s:LHS_KEY : 'l', s:RHS_KEY : '<Esc>gt', s:MAP_ONLY_KEY : 0, s:REMAP_KEY : 0}) " move right
    call add(mappings, {s:LHS_KEY : 's', s:RHS_KEY : '<Cmd>tabr<CR>', s:MAP_ONLY_KEY : 0, s:REMAP_KEY : 0}) " move right end
    call add(mappings, {s:LHS_KEY : 'e', s:RHS_KEY : '<Cmd>tabl<CR>', s:MAP_ONLY_KEY : 0, s:REMAP_KEY : 0}) " move left end
    call add(mappings, {s:LHS_KEY : 'a', s:RHS_KEY : '<Esc>gT', s:MAP_ONLY_KEY : 0, s:REMAP_KEY : 0}) " move left
    call add(mappings, {s:LHS_KEY : 'h', s:RHS_KEY : '<Esc>gT', s:MAP_ONLY_KEY : 0, s:REMAP_KEY : 0}) " move left
    call add(mappings, {s:LHS_KEY : 'q', s:RHS_KEY : '<Esc><Plug>(tabclose_c)', s:MAP_ONLY_KEY : 0, s:REMAP_KEY : 1}) " close a tab
    call add(mappings, {s:LHS_KEY : 'da', s:RHS_KEY : '<Esc><Plug>(tabclose_l)', s:MAP_ONLY_KEY : 1, s:REMAP_KEY : 1}) " close left tabs
    call add(mappings, {s:LHS_KEY : 'dl', s:RHS_KEY : '<Esc><Plug>(tabclose_r)', s:MAP_ONLY_KEY : 1, s:REMAP_KEY : 1}) " close right tabs
    call add(mappings, {s:LHS_KEY : 'd;', s:RHS_KEY : '<Cmd>+tabclose<CR>', s:MAP_ONLY_KEY : 0, s:REMAP_KEY : 0}) " close a right tab
    call add(mappings, {s:LHS_KEY : 'ml', s:RHS_KEY : '<Cmd>tabm+1<CR>', s:MAP_ONLY_KEY : 0, s:REMAP_KEY : 0}) " move a tab right
    call add(mappings, {s:LHS_KEY : 'ms', s:RHS_KEY : '<Cmd>tabm 0<CR>', s:MAP_ONLY_KEY : 0, s:REMAP_KEY : 0}) " move a tab right end
    call add(mappings, {s:LHS_KEY : 'me', s:RHS_KEY : '<Cmd>tabm<CR>', s:MAP_ONLY_KEY : 0, s:REMAP_KEY : 0}) " move a tab left end
    call add(mappings, {s:LHS_KEY : 'ma', s:RHS_KEY : '<Cmd>tabm-1<CR>', s:MAP_ONLY_KEY : 0, s:REMAP_KEY : 0}) " move a tab left
    return mappings
endfunction

function! notomo#mapping#main_input() abort
    return [
        \ {s:LHS_KEY : s:MAIN_INPUT_PFX . 'a', s:RHS_KEY : '-'},
        \ {s:LHS_KEY : s:MAIN_INPUT_PFX . 'e', s:RHS_KEY : '='},
        \ {s:LHS_KEY : s:MAIN_INPUT_PFX . 's', s:RHS_KEY : '_'},
        \ {s:LHS_KEY : s:MAIN_INPUT_PFX . 'r', s:RHS_KEY : '<Bar>'},
        \ {s:LHS_KEY : s:MAIN_INPUT_PFX . 'g', s:RHS_KEY : '\'},
        \ {s:LHS_KEY : s:MAIN_INPUT_PFX . 'w', s:RHS_KEY : '""<Left>'},
        \ {s:LHS_KEY : s:MAIN_INPUT_PFX . 'b', s:RHS_KEY : '``<Left>'},
        \ {s:LHS_KEY : s:MAIN_INPUT_PFX . 'l', s:RHS_KEY : '[]<Left>'},
        \ {s:LHS_KEY : s:MAIN_INPUT_PFX . 't', s:RHS_KEY : '<><Left>'},
        \ {s:LHS_KEY : s:MAIN_INPUT_PFX . 'p', s:RHS_KEY : '()<Left>'},
        \ {s:LHS_KEY : s:MAIN_INPUT_PFX . 'd', s:RHS_KEY : '{}<Left>'},
        \ {s:LHS_KEY : s:MAIN_INPUT_PFX . 'q', s:RHS_KEY : "''<Left>"},
        \ {s:LHS_KEY : s:MAIN_INPUT_PFX . 'h', s:RHS_KEY : '<C-r>+'},
        \ {s:LHS_KEY : s:MAIN_INPUT_PFX . 'v', s:RHS_KEY : '<C-q>'},
        \ {s:LHS_KEY : s:MAIN_INPUT_PFX . 'c', s:RHS_KEY : '::'},
        \ {s:LHS_KEY : s:MAIN_INPUT_PFX . 'fe', s:RHS_KEY : ':='},
        \ {s:LHS_KEY : s:MAIN_INPUT_PFX . 'fq', s:RHS_KEY : '<C-c>'},
        \ {s:LHS_KEY : s:MAIN_INPUT_PFX . 'fp', s:RHS_KEY : '<Up><CR>'},
        \ {s:LHS_KEY : s:MAIN_INPUT_PFX . 'm', s:RHS_KEY : '<CR>'},
    \ ]
endfunction

function! notomo#mapping#sub_input() abort
    return [
        \ {s:LHS_KEY : s:SUB_INPUT_PFX . 'a', s:RHS_KEY : '&'},
        \ {s:LHS_KEY : s:SUB_INPUT_PFX . 'h', s:RHS_KEY : '^'},
        \ {s:LHS_KEY : s:SUB_INPUT_PFX . 'p', s:RHS_KEY : '+'},
        \ {s:LHS_KEY : s:SUB_INPUT_PFX . 's', s:RHS_KEY : '#'},
        \ {s:LHS_KEY : s:SUB_INPUT_PFX . 'r', s:RHS_KEY : '%'},
        \ {s:LHS_KEY : s:SUB_INPUT_PFX . 'm', s:RHS_KEY : '@'},
        \ {s:LHS_KEY : s:SUB_INPUT_PFX . 't', s:RHS_KEY : '~'},
        \ {s:LHS_KEY : s:SUB_INPUT_PFX . 'd', s:RHS_KEY : '$'},
        \ {s:LHS_KEY : s:SUB_INPUT_PFX . 'e', s:RHS_KEY : '!'},
        \ {s:LHS_KEY : s:SUB_INPUT_PFX . 'b', s:RHS_KEY : '`'},
        \ {s:LHS_KEY : s:SUB_INPUT_PFX . 'c', s:RHS_KEY : ':'},
        \ {s:LHS_KEY : s:SUB_INPUT_PFX . 'x', s:RHS_KEY : '*'},
        \ {s:LHS_KEY : s:SUB_INPUT_PFX . 'q', s:RHS_KEY : '?'},
        \ {s:LHS_KEY : s:SUB_INPUT_PFX . ';', s:RHS_KEY : '"'},
        \ {s:LHS_KEY : s:SUB_INPUT_PFX . ',', s:RHS_KEY : "'"},
        \ {s:LHS_KEY : s:SUB_INPUT_PFX . 'g', s:RHS_KEY : '=>'},
        \ {s:LHS_KEY : s:SUB_INPUT_PFX . 'f', s:RHS_KEY : '->'},
        \ {s:LHS_KEY : s:SUB_INPUT_PFX . 'z', s:RHS_KEY : '<-'},
        \ {s:LHS_KEY : s:SUB_INPUT_PFX . 'v', s:RHS_KEY : '<%=  %><Left><Left><Left>'},
    \ ]
endfunction

function! notomo#mapping#lsp() abort
    nnoremap <buffer> [keyword]o <Cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <buffer> [keyword]v <Cmd>vsplit \| lua vim.lsp.buf.definition()<CR>
    nnoremap <buffer> [keyword]h <Cmd>split \| lua vim.lsp.buf.definition()<CR>
    nnoremap <buffer> [keyword]t <Cmd>lua require("wintablib.window").duplicate_as_right_tab()<CR>:lua vim.lsp.buf.definition()<CR>
endfunction
