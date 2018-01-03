let s:NUMBER_MODE_NM = 'number'

function! s:number_map(lhs, rhs) abort
    call submode#map(s:NUMBER_MODE_NM, 'ci', 's', a:lhs, a:rhs)
endfunction

function! notomo#number#setup_submode() abort
    call submode#enter_with(s:NUMBER_MODE_NM, 'ci', '', notomo#mapping#get_number_mode_key(), '<Nop>')
    call submode#enter_with(s:NUMBER_MODE_NM, 'ci', '', notomo#mapping#get_calculator_key(), '<C-r>=')
    call submode#leave_with(s:NUMBER_MODE_NM, 'ci', '', '<CR>')
    call s:number_map('a', '1')
    call s:number_map('s', '2')
    call s:number_map('d', '3')
    call s:number_map('f', '4')
    call s:number_map('g', '5')
    call s:number_map('h', '6')
    call s:number_map('j', '7')
    call s:number_map('k', '8')
    call s:number_map('l', '9')
    call s:number_map(';', '0')

    call s:number_map('e', '=')
    call s:number_map('p', '+')
    call s:number_map('m', '-')
    call s:number_map('x', '*')
    call s:number_map('/', '/')
    call s:number_map('.', '.')
    call s:number_map(',', ',')
    call s:number_map('<Space>', '<Space>')
    call s:number_map('t', '<Tab>')

    call s:number_map('1', '1')
    call s:number_map('2', '2')
    call s:number_map('3', '3')
    call s:number_map('4', '4')
    call s:number_map('5', '5')
    call s:number_map('6', '6')
    call s:number_map('7', '7')
    call s:number_map('8', '8')
    call s:number_map('9', '9')
    call s:number_map('0', '0')

    call s:number_map('<C-k>', '<Up>')
    call s:number_map('<C-l>', '<Right>')
    call s:number_map('<C-h>', '<Left>')
    call s:number_map('<C-j>', '<Down>')
    call s:number_map('<C-b>', '<BS>')
    call s:number_map('<C-d>', '<Del>')
    call s:number_map('v', '<C-r>+')

    call s:number_map('b', '<Left>')
    call s:number_map('w', '<Right>')

    let tmp_enter_key = notomo#mapping#get_sub_input_key()  . 'N'
    call submode#enter_with(s:NUMBER_MODE_NM, 'ci', '', tmp_enter_key, '<Nop>')
    call feedkeys(tmp_enter_key)
    return ''
endfunction

