
let s:bundle=neobundle#get('vim-easymotion')
function! s:bundle.hooks.on_source(bundle)
    let g:EasyMotion_do_mapping = 0
    let g:EasyMotion_enter_jump_first = 1
    let g:EasyMotion_move_highlight = 1
    let g:EasyMotion_landing_highlight = 0
    let g:EasyMotion_inc_highlight=1
    let g:EasyMotion_keys = 'asdghklqwertyuopzxcvbnmf;,.'
endfunction
unlet s:bundle

map gf <Plug>(easymotion-bd-fl)
map gt <Plug>(easymotion-bd-tl)
map gj <Plug>(easymotion-j)
map gk <Plug>(easymotion-k)
map gn <Plug>(easymotion-lineanywhere)
map gw <Plug>(easymotion-bd-w)
" map g<Enter> <Plug>(easymotion-bd-w)
" map g<Enter> <Plug>(easymotion-overwin-w)
map g<Enter> <Plug>(easymotion-vim-n)

" map g<Enter> <Plug>(easymotion-overwin-line)

map gs <Plug>(easymotion-tl)"
map gl <Plug>(easymotion-tl)]
map g. <Plug>(easymotion-tl).
map g; <Plug>(easymotion-tl);
map gc <Plug>(easymotion-tl):
map gp <Plug>(easymotion-tl))
map gd <Plug>(easymotion-tl)}
map g, <Plug>(easymotion-tl),
map gy <Plug>(easymotion-tl)\
map g/ <Plug>(easymotion-tl)/
map g<Space> <Plug>(easymotion-tl)<Space>
map <Space>ge <Plug>(easymotion-tl)=
map <Space>go <Plug>(easymotion-tl)|
map <Space>ga <Plug>(easymotion-tl)&
map <Space>gt <Plug>(easymotion-tl)<
map gq <Plug>(easymotion-tl)'
map <Space>gw <Plug>(easymotion-tl)"
map <Space>gd <Plug>(easymotion-tl)$
map <Space>gp <Plug>(easymotion-tl)+
map gx <Plug>(easymotion-tl)*
