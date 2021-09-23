if exists('b:did_indent')
    finish
endif
let b:did_indent = 1

setlocal formatoptions-=t
setlocal formatoptions+=r
setlocal formatoptions+=o

setlocal indentkeys=0{,0},0),0],:,!^F,o,O,e,*<Return>,=?>,=<?,=*/
lua _G._notomo_python_indent = require("notomo.python").indent
setlocal indentexpr=v:lua._notomo_python_indent()

let b:undo_indent = 'setlocal '.join([
\   'comments<',
\   'formatoptions<',
\   'indentexpr<',
\   'indentkeys<',
\ ])
