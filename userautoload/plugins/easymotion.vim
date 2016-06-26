
let s:bundle=neobundle#get('vim-easymotion')
function! s:bundle.hooks.on_source(bundle)
    let g:EasyMotion_do_mapping = 0 "Disable default mappings
    let g:EasyMotion_enter_jump_first = 1
    let g:EasyMotion_move_highlight = 1
    let g:EasyMotion_landing_highlight = 0
    let g:EasyMotion_inc_highlight=1
    let g:EasyMotion_keys = 'asdghklqwertyuiopzxcvbnmf;'
	" EMCommandLineNoreMap <Space> <CR>
	" EMCommandLineNoreMap <S-Space> <Space>
	" EMCommandLineNoreMap <C-n> <Over>(em-scroll-f)
	" EMCommandLineNoreMap <C-p> <Over>(em-scroll-b)
	" EMCommandLineNoreMap jj <ESC>
	" EMCommandLineNoreMap <C-v> <Over>(paste)
	" EMCommandLineNoreMap <C-b> <BS>

endfunction
unlet s:bundle

map gf <Plug>(easymotion-bd-fl)
map gt <Plug>(easymotion-bd-tl)
map gj <Plug>(easymotion-j)
map gk <Plug>(easymotion-k)
map gl <Plug>(easymotion-bd-jk)
map gn <Plug>(easymotion-lineanywhere)
map gw <Plug>(easymotion-bd-w)

map g. <Plug>(easymotion-tl).
map g; <Plug>(easymotion-tl);
map gp <Plug>(easymotion-tl))
map gd <Plug>(easymotion-tl)}
