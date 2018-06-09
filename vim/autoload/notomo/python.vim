
function! notomo#python#get_indent()
    let curline = getline('.')
    if (col('.') - 1) != matchend(curline, '^\s*')
        return -1
    endif
    if curline =~# '\v^\s*[])"''}]+$'
        " e.g. var = func(\n)
        return -1
    endif

    let line_num = prevnonblank(v:lnum - 1)
    let plus_one = indent(line_num) + &l:shiftwidth
    let line = getline(line_num)
    if line =~# '\v.*\([^)]*$'
        " e.g. func(
        return plus_one
    elseif line =~# '\v.*:$'
        " e.g. def func():
        return plus_one
    elseif line =~# '\v.*\[[^]]*$'
        " e.g. ary = [
        return plus_one
    " elseif line =~# '\v.*\{(\})@!'
    elseif line =~# '\v.*\{[^}]*$'
        " e.g. dict = {
        return plus_one
    endif

    return -1
endfunction

function! notomo#python#semshi_mapping() abort
    nnoremap <buffer> sgj :<C-u>Semshi goto function next<CR>
    nnoremap <buffer> sga :<C-u>Semshi goto function first<CR>
    nnoremap <buffer> sge :<C-u>Semshi goto function lasst<CR>
    nnoremap <buffer> sgk :<C-u>Semshi goto function prev<CR>

    nnoremap <buffer> sna :<C-u>Semshi goto name first<CR>
    nnoremap <buffer> sne :<C-u>Semshi goto name last<CR>
    nnoremap <buffer> snj :<C-u>Semshi goto name next<CR>
    nnoremap <buffer> snk :<C-u>Semshi goto name prev<CR>

    nnoremap <buffer> scj :<C-u>Semshi goto class next<CR>
    nnoremap <buffer> sck :<C-u>Semshi goto class prev<CR>

endfunction

function! notomo#python#semshi_highlight()
    highlight semshiLocal ctermfg=NONE guifg=NONE
    highlight semshiImported ctermfg=NONE guifg=NONE
    highlight semshiParameter ctermfg=NONE guifg=NONE
    highlight semshiUnresolved ctermfg=NONE guifg=NONE

    highlight semshiGlobal ctermfg=229 guifg=#fffaaa
    highlight semshiParameterUnused ctermfg=189 guifg=#e7d5ff
    highlight semshiFree ctermfg=132 guifg=#a9667a
    highlight semshiBuiltin ctermfg=210 guifg=#fd8489
    highlight semshiSelected ctermfg=255 guifg=#ffffff ctermbg=60 guibg=#607080

    highlight semshiAttribute ctermfg=181 guifg=#e7c6b7
    highlight semshiSelf ctermfg=181 guifg=#e7c6b7

    highlight semshiErrorSign ctermfg=0 guifg=#000000 ctermbg=167 guibg=#ab6560
    highlight semshiErrorChar ctermfg=0 guifg=#000000 ctermbg=167 guibg=#ab6560
    sign define semshiError text=E> texthl=semshiErrorSign
endfunction
