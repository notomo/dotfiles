map gj <Plug>(easymotion-j)
map gk <Plug>(easymotion-k)
map gn <Plug>(easymotion-lineanywhere)
map gN <Plug>(easymotion-linebackward)
map gw <Plug>(easymotion-bd-w)
map g<Enter> <Plug>(easymotion-bd-n)
map gL <Plug>(easymotion-overwin-line)
map gW <Plug>(easymotion-overwin-w)

let s:LHS_SUFFIX_KEY = "lhs_suffix"
let s:TARGET_CHAR_KEY = "target_char"

let s:easymotion_map_info = [
            \ {s:LHS_SUFFIX_KEY : "s"      , s:TARGET_CHAR_KEY : "\""},
            \ {s:LHS_SUFFIX_KEY : "l"      , s:TARGET_CHAR_KEY : "]"},
            \ {s:LHS_SUFFIX_KEY : "c"      , s:TARGET_CHAR_KEY : ":"},
            \ {s:LHS_SUFFIX_KEY : "p"      , s:TARGET_CHAR_KEY : ")"},
            \ {s:LHS_SUFFIX_KEY : "d"      , s:TARGET_CHAR_KEY : "}"},
            \ {s:LHS_SUFFIX_KEY : "y"      , s:TARGET_CHAR_KEY : "\\"},
            \ {s:LHS_SUFFIX_KEY : "t"      , s:TARGET_CHAR_KEY : ">"},
            \ {s:LHS_SUFFIX_KEY : "q"      , s:TARGET_CHAR_KEY : "\'"},
            \ {s:LHS_SUFFIX_KEY : "x"      , s:TARGET_CHAR_KEY : "*"},
            \ {s:LHS_SUFFIX_KEY : "."      , s:TARGET_CHAR_KEY : "."},
            \ {s:LHS_SUFFIX_KEY : ";"      , s:TARGET_CHAR_KEY : ";"},
            \ {s:LHS_SUFFIX_KEY : ","      , s:TARGET_CHAR_KEY : ","},
            \ {s:LHS_SUFFIX_KEY : "/"      , s:TARGET_CHAR_KEY : "/"},
            \ {s:LHS_SUFFIX_KEY : "<Space>", s:TARGET_CHAR_KEY : "<Space>"},
            \ {s:LHS_SUFFIX_KEY : "E"      , s:TARGET_CHAR_KEY : "="},
            \ {s:LHS_SUFFIX_KEY : "O"      , s:TARGET_CHAR_KEY : "<Bar>"},
            \ {s:LHS_SUFFIX_KEY : "A"      , s:TARGET_CHAR_KEY : "&"},
            \ {s:LHS_SUFFIX_KEY : "D"      , s:TARGET_CHAR_KEY : "$"},
            \ {s:LHS_SUFFIX_KEY : "P"      , s:TARGET_CHAR_KEY : "+"},
            \]

function! s:map_easymotion_fl_tl(lhs_suffix, target_char) abort
    silent execute join(["map", "gf" . a:lhs_suffix, "<Plug>(easymotion-fl)" . a:target_char])
    silent execute join(["map", "g" . a:lhs_suffix, "<Plug>(easymotion-tl)" . a:target_char])
    silent execute join(["noremap", "<Space>g" . a:lhs_suffix, "t" . a:target_char])
endfunction

for info in s:easymotion_map_info
    call s:map_easymotion_fl_tl(info[s:LHS_SUFFIX_KEY], info[s:TARGET_CHAR_KEY])
endfor

