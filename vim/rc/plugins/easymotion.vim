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

let s:LHS_SFX_KEY = 'l'
let s:TARGET_KEY = 't'

let s:map_info = [
\ {s:LHS_SFX_KEY : 's'      , s:TARGET_KEY : '"'},
\ {s:LHS_SFX_KEY : 'l'      , s:TARGET_KEY : ']'},
\ {s:LHS_SFX_KEY : 'p'      , s:TARGET_KEY : ')'},
\ {s:LHS_SFX_KEY : 'd'      , s:TARGET_KEY : '}'},
\ {s:LHS_SFX_KEY : 'y'      , s:TARGET_KEY : '\'},
\ {s:LHS_SFX_KEY : 't'      , s:TARGET_KEY : '>'},
\ {s:LHS_SFX_KEY : 'q'      , s:TARGET_KEY : "'"},
\ {s:LHS_SFX_KEY : '.'      , s:TARGET_KEY : '.'},
\ {s:LHS_SFX_KEY : ';'      , s:TARGET_KEY : ';'},
\ {s:LHS_SFX_KEY : ','      , s:TARGET_KEY : ','},
\ {s:LHS_SFX_KEY : '<Space>', s:TARGET_KEY : '<Space>'},
\ {s:LHS_SFX_KEY : 'r'      , s:TARGET_KEY : '<Bar>'},
\ ]

for s:info in s:map_info
    silent execute join(['map', 'g' . s:info[s:LHS_SFX_KEY], '<Plug>(easymotion-tl)' . s:info[s:TARGET_KEY]])
endfor

