
autocmd MyAuGroup FileType ctrlb call s:settings()
function! s:settings()
    nnoremap <buffer> l :<C-u>Ctrlb tab:next<CR>
    nnoremap <buffer> h :<C-u>Ctrlb tab:previous<CR>
    nnoremap <buffer> ga :<C-u>Ctrlb tab:first<CR>
    nnoremap <buffer> ge :<C-u>Ctrlb tab:last<CR>
    nnoremap <buffer> rl :<C-u>Ctrlb tab:reload<CR>
    nnoremap <buffer> t<Space> :<C-u>Ctrlb tab:create<CR>
    nnoremap <buffer> cc :<C-u>Ctrlb tab:close<CR>
    nnoremap <buffer> tdl :<C-u>Ctrlb tab:closeRight<CR>
    nnoremap <buffer> tda :<C-u>Ctrlb tab:closeLeft<CR>
    nnoremap <buffer> oo :<C-u>Ctrlb tab:closeOthers<CR>
    nnoremap <buffer> tma :<C-u>Ctrlb tab:moveLeft<CR>
    nnoremap <buffer> tml :<C-u>Ctrlb tab:moveRight<CR>
    nnoremap <buffer> tms :<C-u>Ctrlb tab:moveFirst<CR>
    nnoremap <buffer> tme :<C-u>Ctrlb tab:moveLast<CR>
    nnoremap <buffer> [denite]b :<C-u>Denite ctrlb/bookmark/recent<CR>
    nnoremap <buffer> [denite]s :<C-u>Denite ctrlb/bookmark/search<CR>
    nnoremap <buffer> [denite]h :<C-u>Denite ctrlb/history/search<CR>
    nnoremap <buffer> [denite]ta :<C-u>Denite ctrlb/tab<CR>
endfunction
