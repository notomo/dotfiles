
function! tmno3#matchit#sql() abort
    let b:match_ignorecase = 1
    let b:match_words = '\<select\>:\<from\>:\<join\>:\<where\>'
endfunction
