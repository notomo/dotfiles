
function! notomo#matchit#sql() abort
    let b:match_ignorecase = 1
    let b:match_words = '\<select\>:\<from\>:\<join\>:\<where\>'
endfunction

function! notomo#matchit#vim() abort
    let b:match_words = '\<if\>:\<elseif\>:\<else\>:\<endif\>,\<for\>:\<endfor\>,\<while\>:\<endwhile\>,\<try\>:\<catch\>:\<finally\>:\<endtry\>,\<func\(tion\)\?\>:\<endfunc\(tion\)\?\>,\<augroup [^E]\w*\>:\<augroup END\>'
endfunction

function! notomo#matchit#smarty() abort
    let b:match_ignorecase = 1
    let b:match_words = '<:>,' .
    \ '<\@<=[ou]l\>[^>]*\%(>\|$\):<\@<=li\>:<\@<=/[ou]l>,' .
    \ '<\@<=dl\>[^>]*\%(>\|$\):<\@<=d[td]\>:<\@<=/dl>,' .
    \ '<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>'
    let b:match_words .= ',{if\>:{elseif\>:{else\>:{/if\>,{foreach\>:{foreachelse\>:{/foreach\>'
endfunction

function! notomo#matchit#ejs() abort
    let b:match_ignorecase = 1
    let b:match_words = '<:>,' .
    \ '<\@<=[ou]l\>[^>]*\%(>\|$\):<\@<=li\>:<\@<=/[ou]l>,' .
    \ '<\@<=dl\>[^>]*\%(>\|$\):<\@<=d[td]\>:<\@<=/dl>,' .
    \ '<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>'
endfunction
