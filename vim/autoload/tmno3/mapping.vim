
let s:LHS_KEY = 'l'
let s:RHS_KEY = 'r'
let s:MAP_ONLY_KEY = 'o'
let s:REMAP_KEY = 'rm'

let s:MAIN_INPUT_PFX = 'j<Space>'
let s:SUB_INPUT_PFX = 'jk'

function! tmno3#mapping#tab() abort
    let tab_mappings = []
    call add(tab_mappings, {s:LHS_KEY : 't', s:RHS_KEY : '<Esc><Plug>(new_tab)', s:MAP_ONLY_KEY : 1, s:REMAP_KEY : 1}) " open new tab
    call add(tab_mappings, {s:LHS_KEY : 'l', s:RHS_KEY : '<Esc>gt', s:MAP_ONLY_KEY : 0, s:REMAP_KEY : 0}) " move right
    call add(tab_mappings, {s:LHS_KEY : 's', s:RHS_KEY : ':<C-u>tabr<CR>', s:MAP_ONLY_KEY : 0, s:REMAP_KEY : 0}) " move right end
    call add(tab_mappings, {s:LHS_KEY : 'e', s:RHS_KEY : ':<C-u>tabl<CR>', s:MAP_ONLY_KEY : 0, s:REMAP_KEY : 0}) " move left end
    call add(tab_mappings, {s:LHS_KEY : 'a', s:RHS_KEY : '<Esc>gT', s:MAP_ONLY_KEY : 0, s:REMAP_KEY : 0}) " move left
    call add(tab_mappings, {s:LHS_KEY : 'h', s:RHS_KEY : '<Esc>gT', s:MAP_ONLY_KEY : 0, s:REMAP_KEY : 0}) " move left
    call add(tab_mappings, {s:LHS_KEY : 'q', s:RHS_KEY : '<Esc><Plug>(tabclose_c)', s:MAP_ONLY_KEY : 0, s:REMAP_KEY : 1}) " close a tab
    call add(tab_mappings, {s:LHS_KEY : 'da', s:RHS_KEY : '<Esc><Plug>(tabclose_l)', s:MAP_ONLY_KEY : 1, s:REMAP_KEY : 1}) " close left tabs
    call add(tab_mappings, {s:LHS_KEY : 'dl', s:RHS_KEY : '<Esc><Plug>(tabclose_r)', s:MAP_ONLY_KEY : 1, s:REMAP_KEY : 1}) " close right tabs
    call add(tab_mappings, {s:LHS_KEY : 'd;', s:RHS_KEY : ':<C-u>+tabclose<CR>', s:MAP_ONLY_KEY : 0, s:REMAP_KEY : 0}) " close a right tab
    call add(tab_mappings, {s:LHS_KEY : 'ml', s:RHS_KEY : ':<C-u>tabm+1<CR>', s:MAP_ONLY_KEY : 0, s:REMAP_KEY : 0}) " move a tab right
    call add(tab_mappings, {s:LHS_KEY : 'ms', s:RHS_KEY : ':<C-u>tabm 0<CR>', s:MAP_ONLY_KEY : 0, s:REMAP_KEY : 0}) " move a tab right end
    call add(tab_mappings, {s:LHS_KEY : 'me', s:RHS_KEY : ':<C-u>tabm<CR>', s:MAP_ONLY_KEY : 0, s:REMAP_KEY : 0}) " move a tab left end
    call add(tab_mappings, {s:LHS_KEY : 'ma', s:RHS_KEY : ':<C-u>tabm-1<CR>', s:MAP_ONLY_KEY : 0, s:REMAP_KEY : 0}) " move a tab left
    return tab_mappings
endfunction

function! tmno3#mapping#main_input() abort
    let main_input_mappings = []
    call add(main_input_mappings, {s:LHS_KEY : s:MAIN_INPUT_PFX . 'a', s:RHS_KEY : '-'})
    call add(main_input_mappings, {s:LHS_KEY : s:MAIN_INPUT_PFX . 'e', s:RHS_KEY : '='})
    call add(main_input_mappings, {s:LHS_KEY : s:MAIN_INPUT_PFX . 's', s:RHS_KEY : '_'})
    call add(main_input_mappings, {s:LHS_KEY : s:MAIN_INPUT_PFX . 'r', s:RHS_KEY : '<Bar>'})
    call add(main_input_mappings, {s:LHS_KEY : s:MAIN_INPUT_PFX . 'g', s:RHS_KEY : '\'})
    call add(main_input_mappings, {s:LHS_KEY : s:MAIN_INPUT_PFX . 'w', s:RHS_KEY : '""<Left>'})
    call add(main_input_mappings, {s:LHS_KEY : s:MAIN_INPUT_PFX . 'b', s:RHS_KEY : '``<Left>'})
    call add(main_input_mappings, {s:LHS_KEY : s:MAIN_INPUT_PFX . 'l', s:RHS_KEY : '[]<Left>'})
    call add(main_input_mappings, {s:LHS_KEY : s:MAIN_INPUT_PFX . 't', s:RHS_KEY : '<><Left>'})
    call add(main_input_mappings, {s:LHS_KEY : s:MAIN_INPUT_PFX . 'p', s:RHS_KEY : '()<Left>'})
    call add(main_input_mappings, {s:LHS_KEY : s:MAIN_INPUT_PFX . 'd', s:RHS_KEY : '{}<Left>'})
    call add(main_input_mappings, {s:LHS_KEY : s:MAIN_INPUT_PFX . 'q', s:RHS_KEY : "''<Left>"})
    call add(main_input_mappings, {s:LHS_KEY : s:MAIN_INPUT_PFX . 'h', s:RHS_KEY : '<C-r>"'})
    call add(main_input_mappings, {s:LHS_KEY : s:MAIN_INPUT_PFX . 'v', s:RHS_KEY : '<C-q>'})
    return main_input_mappings
endfunction

function! tmno3#mapping#sub_input() abort
    let sub_input_mappings = []
    call add(sub_input_mappings, {s:LHS_KEY : s:SUB_INPUT_PFX . 'a', s:RHS_KEY : '&'})
    call add(sub_input_mappings, {s:LHS_KEY : s:SUB_INPUT_PFX . 'h', s:RHS_KEY : '^'})
    call add(sub_input_mappings, {s:LHS_KEY : s:SUB_INPUT_PFX . 'p', s:RHS_KEY : '+'})
    call add(sub_input_mappings, {s:LHS_KEY : s:SUB_INPUT_PFX . 's', s:RHS_KEY : '#'})
    call add(sub_input_mappings, {s:LHS_KEY : s:SUB_INPUT_PFX . 'r', s:RHS_KEY : '%'})
    call add(sub_input_mappings, {s:LHS_KEY : s:SUB_INPUT_PFX . 'm', s:RHS_KEY : '@'})
    call add(sub_input_mappings, {s:LHS_KEY : s:SUB_INPUT_PFX . 't', s:RHS_KEY : '~'})
    call add(sub_input_mappings, {s:LHS_KEY : s:SUB_INPUT_PFX . 'd', s:RHS_KEY : '$'})
    call add(sub_input_mappings, {s:LHS_KEY : s:SUB_INPUT_PFX . 'e', s:RHS_KEY : '!'})
    call add(sub_input_mappings, {s:LHS_KEY : s:SUB_INPUT_PFX . 'b', s:RHS_KEY : '`'})
    call add(sub_input_mappings, {s:LHS_KEY : s:SUB_INPUT_PFX . 'c', s:RHS_KEY : ':'})
    call add(sub_input_mappings, {s:LHS_KEY : s:SUB_INPUT_PFX . 'x', s:RHS_KEY : '*'})
    call add(sub_input_mappings, {s:LHS_KEY : s:SUB_INPUT_PFX . 'q', s:RHS_KEY : '?'})
    call add(sub_input_mappings, {s:LHS_KEY : s:SUB_INPUT_PFX . ';', s:RHS_KEY : '"'})
    call add(sub_input_mappings, {s:LHS_KEY : s:SUB_INPUT_PFX . ',', s:RHS_KEY : "'"})
    call add(sub_input_mappings, {s:LHS_KEY : s:SUB_INPUT_PFX . 'g', s:RHS_KEY : '=>'})
    call add(sub_input_mappings, {s:LHS_KEY : s:SUB_INPUT_PFX . 'f', s:RHS_KEY : '->'})
    return sub_input_mappings
endfunction
