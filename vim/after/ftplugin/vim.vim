setlocal expandtab
setlocal foldmethod=marker

if exists('loaded_matchit')
    let b:match_words = '\<if\>:\<elseif\>:\<else\>:\<endif\>,\<for\>:\<endfor\>,\<while\>:\<endwhile\>,\<try\>:\<catch\>:\<finally\>:\<endtry\>,\<function\>:\<endfunction\>'
endif


