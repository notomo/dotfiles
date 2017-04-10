if exists('b:did_indent')
    finish
endif
let b:did_indent = 1

setlocal indentkeys=0{,0},0),0],:,!^F,o,O,e,*<Return>,=?>,=<?,=*/
setlocal indentexpr=GetPhpIndent()
function! GetPhpIndent()
    return -1
endfunction

let b:undo_indent = 'setlocal '.join([
\   'indentexpr<',
\   'indentkeys<',
\ ])
