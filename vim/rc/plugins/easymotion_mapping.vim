map gj <Plug>(easymotion-j)
map gJ <Plug>(easymotion-w)
map gk <Plug>(easymotion-k)
map gn <Plug>(easymotion-lineanywhere)
map gN <Plug>(easymotion-linebackward)
map gw <Plug>(easymotion-bd-w)
map g<Enter> <Plug>(easymotion-bd-n)
map gL <Plug>(easymotion-overwin-line)
map gW <Plug>(easymotion-overwin-w)
map gu <Plug>(easymotion-jumptoanywhere)

let g:EasyMotion_re_anywhere = '\v("\zs.)|(#\zs.)|' . "('\\zs.)"

let s:LHS_SFX_KEY = "l"
let s:TARGET_KEY = "t"

let s:map_info = [
            \ {s:LHS_SFX_KEY : "s"      , s:TARGET_KEY : "\""},
            \ {s:LHS_SFX_KEY : "l"      , s:TARGET_KEY : "]"},
            \ {s:LHS_SFX_KEY : "c"      , s:TARGET_KEY : ":"},
            \ {s:LHS_SFX_KEY : "p"      , s:TARGET_KEY : ")"},
            \ {s:LHS_SFX_KEY : "d"      , s:TARGET_KEY : "}"},
            \ {s:LHS_SFX_KEY : "y"      , s:TARGET_KEY : "\\"},
            \ {s:LHS_SFX_KEY : "t"      , s:TARGET_KEY : ">"},
            \ {s:LHS_SFX_KEY : "q"      , s:TARGET_KEY : "\'"},
            \ {s:LHS_SFX_KEY : "x"      , s:TARGET_KEY : "*"},
            \ {s:LHS_SFX_KEY : "."      , s:TARGET_KEY : "."},
            \ {s:LHS_SFX_KEY : ";"      , s:TARGET_KEY : ";"},
            \ {s:LHS_SFX_KEY : ","      , s:TARGET_KEY : ","},
            \ {s:LHS_SFX_KEY : "/"      , s:TARGET_KEY : "/"},
            \ {s:LHS_SFX_KEY : "<Space>", s:TARGET_KEY : "<Space>"},
            \ {s:LHS_SFX_KEY : "E"      , s:TARGET_KEY : "="},
            \ {s:LHS_SFX_KEY : "r"      , s:TARGET_KEY : "<Bar>"},
            \ {s:LHS_SFX_KEY : "A"      , s:TARGET_KEY : "&"},
            \ {s:LHS_SFX_KEY : "D"      , s:TARGET_KEY : "$"},
            \ {s:LHS_SFX_KEY : "P"      , s:TARGET_KEY : "+"},
            \]

function! s:map_fl_tl(lhs, target) abort
    silent execute join(["map", "gf" . a:lhs, "<Plug>(easymotion-fl)" . a:target])
    silent execute join(["map", "g" . a:lhs, "<Plug>(easymotion-tl)" . a:target])
endfunction

for s:info in s:map_info
    call s:map_fl_tl(s:info[s:LHS_SFX_KEY], s:info[s:TARGET_KEY])
endfor

