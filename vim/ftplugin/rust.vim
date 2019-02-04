if exists('b:did_ftplugin')
    finish
endif
let b:did_ftplugin = 1

setlocal comments=s0:/*!,m:\ ,ex:*/,s1:/*,mb:*,ex:*/

let b:undo_ftplugin = 'setlocal '.join([
\   'comments<',
\ ])
