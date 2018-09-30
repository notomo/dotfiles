
nnoremap <expr> [browser]<CR> ':<C-u>Ctrlb tab:tabOpen -url=' . expand('<cWORD>') . '<CR>'
nnoremap <expr> [browser]b ':<C-u>Ctrlb tab:open -url=' . expand('<cWORD>') . '<CR>'
nnoremap [exec]L :<C-u>Ctrlb tab:reload<CR>
nnoremap [exec]gg :<C-u>Ctrlb scroll:toTop<CR>
nnoremap [exec]gh :<C-u>Ctrlb tab:previous<CR>
nnoremap [exec]ga :<C-u>Ctrlb tab:first<CR>
nnoremap [exec]ge :<C-u>Ctrlb tab:last<CR>
nnoremap [exec]gl :<C-u>Ctrlb tab:next<CR>
nnoremap [exec]G :<C-u>Ctrlb scroll:toBottom<CR>

autocmd MyAuGroup FileType ctrlb-ctrl call s:ctrl_settings()
function! s:ctrl_settings()
    nnoremap <buffer> l :<C-u>Ctrlb tab:next<CR>
    nnoremap <buffer> h :<C-u>Ctrlb tab:previous<CR>
    nnoremap <buffer> ga :<C-u>Ctrlb tab:first<CR>
    nnoremap <buffer> ge :<C-u>Ctrlb tab:last<CR>
    nnoremap <buffer> rl :<C-u>Ctrlb tab:reload<CR>
    nnoremap <buffer> t<Space> :<C-u>Ctrlb tab:create<CR>
    nnoremap <buffer> t<CR> :<C-u>Ctrlb tab:duplicate<CR>
    nnoremap <buffer> cc :<C-u>Ctrlb tab:close<CR>
    nnoremap <buffer> dd :<C-u>Ctrlb tab:closeOthers<CR>
    nnoremap <buffer> tdl :<C-u>Ctrlb tab:closeRight<CR>
    nnoremap <buffer> tda :<C-u>Ctrlb tab:closeLeft<CR>
    nnoremap <buffer> tma :<C-u>Ctrlb tab:moveLeft<CR>
    nnoremap <buffer> tml :<C-u>Ctrlb tab:moveRight<CR>
    nnoremap <buffer> tms :<C-u>Ctrlb tab:moveFirst<CR>
    nnoremap <buffer> tme :<C-u>Ctrlb tab:moveLast<CR>
    nnoremap <buffer> [denite]b :<C-u>Denite ctrlb/bookmark/recent<CR>
    nnoremap <buffer> [denite]s :<C-u>Denite ctrlb/bookmark/search<CR>
    nnoremap <buffer> [denite]h :<C-u>Denite ctrlb/history/search<CR>
    nnoremap <buffer> [denite]ta :<C-u>Denite ctrlb/tab<CR>
    nnoremap <buffer> gg :<C-u>Ctrlb scroll:toTop<CR>
    nnoremap <buffer> G :<C-u>Ctrlb scroll:toBottom<CR>
    nnoremap <buffer> k :<C-u>Ctrlb scroll:up<CR>
    nnoremap <buffer> j :<C-u>Ctrlb scroll:down<CR>
    nnoremap <buffer> gb :<C-u>Ctrlb navigation:back<CR>
    nnoremap <buffer> gf :<C-u>Ctrlb navigation:forward<CR>
    nnoremap <buffer> J :<C-u>Ctrlb zoom:down<CR>
    nnoremap <buffer> K :<C-u>Ctrlb zoom:up<CR>
    nnoremap <buffer> R :<C-u>Ctrlb zoom:reset<CR>
endfunction

autocmd MyAuGroup FileType ctrlb-bookmarkTree call s:bookmark_tree_settings()
function! s:bookmark_tree_settings()
    nnoremap <buffer> <CR> :<C-u>call ctrlb#do_action('bookmarkTree', 'open')<CR>
    nnoremap <buffer> l :<C-u>call ctrlb#do_action('bookmarkTree', 'open')<CR>
    nnoremap <buffer> h :<C-u>call ctrlb#do_action('bookmarkTree', 'openParent')<CR>
    nnoremap <buffer> t<Space> :<C-u>call ctrlb#do_action('bookmarkTree', 'tabOpen')<CR>
    nnoremap <buffer> D :<C-u>call ctrlb#do_action('bookmarkTree', 'debug')<CR>
    nnoremap <buffer> <expr> j line('.') == line('$') ? 'gg' : 'j'
    nnoremap <buffer> <expr> k line('.') == 1 ? 'G' : 'k'
endfunction
