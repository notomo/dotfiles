nmap gj <Plug>(easymotion-j)
xmap gj <Plug>(easymotion-j)
omap gj <Plug>(easymotion-j)
nmap gk <Plug>(easymotion-k)
xmap gk <Plug>(easymotion-k)
omap gk <Plug>(easymotion-k)
nmap gn <Plug>(easymotion-lineanywhere)
xmap gn <Plug>(easymotion-lineanywhere)
omap gn <Plug>(easymotion-lineanywhere)
nmap gw <Plug>(easymotion-bd-w)
xmap gw <Plug>(easymotion-bd-w)
omap gw <Plug>(easymotion-bd-w)
nmap g<Enter> <Plug>(easymotion-bd-n)
xmap g<Enter> <Plug>(easymotion-bd-n)
omap g<Enter> <Plug>(easymotion-bd-n)

let s:LHS_SFX_KEY = 'l'
let s:TARGET_KEY = 't'

let s:map_info = [
\ {s:LHS_SFX_KEY : 's'      , s:TARGET_KEY : '"'},
\ {s:LHS_SFX_KEY : 'c'      , s:TARGET_KEY : ':'},
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
    silent execute join(['nmap', 'g' . s:info[s:LHS_SFX_KEY], '<Plug>(easymotion-tl)' . s:info[s:TARGET_KEY]])
    silent execute join(['xmap', 'g' . s:info[s:LHS_SFX_KEY], '<Plug>(easymotion-tl)' . s:info[s:TARGET_KEY]])
    silent execute join(['omap', 'g' . s:info[s:LHS_SFX_KEY], '<Plug>(easymotion-tl)' . s:info[s:TARGET_KEY]])
endfor

