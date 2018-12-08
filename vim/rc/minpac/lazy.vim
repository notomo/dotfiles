
function! s:add_on_cmd(name, cmd) abort
    call minpac#add(a:name, {'type': 'opt'})
    execute 'autocmd MyAuGroup CmdUndefined ' . a:cmd . ' packadd ' . a:name
endfunction

function! s:add_on_ft(name, ft) abort
    call minpac#add(a:name, {'type': 'opt'})
    execute 'autocmd MyAuGroup FileType ' . a:ft . ' packadd ' . a:name
endfunction

if has('gui') && !has('nvim')
    call s:add_on_cmd('tyru/restart.vim', 'Restart')
    nnoremap [exec]R :<C-u>Restart<CR>
    let g:restart_sessionoptions = 'curdir,help,tabpages'

    call s:add_on_cmd('thinca/vim-fontzoom', 'Fontzoom')
    nmap <C-Up> <Plug>(fontzoom-larger)
    nmap <C-Down> <Plug>(fontzoom-smaller)
    nnoremap <M-Up> :<C-u>Fontzoom!<CR>
    nnoremap <M-Down> :<C-u>Fontzoom!<CR>
endif
