autocmd MyAuGroup User ThettoSourceLoad call s:thetto()
function! s:thetto() abort
    lua << EOF
require('thetto/kind/directory').after = function(path)
vim.api.nvim_command("Kiview -create -split=no")
end
require('thetto/source/file/mru').ignore_pattern = "\\v^(gina|thetto|term)://"
EOF
endfunction

autocmd MyAuGroup FileType thetto call s:thetto_settings()
function! s:thetto_settings() abort
    nnoremap <buffer> <CR> :<C-u>ThettoDo<CR>
    nnoremap <buffer> dd :<C-u>ThettoDo move_to_input<CR><Esc>:<C-u>silent %delete _<CR>
    nnoremap <buffer> cc :<C-u>ThettoDo move_to_input<CR><Esc>:<C-u>silent %delete _<CR>:<C-u>ThettoDo move_to_input<CR>
    nnoremap <buffer> i :<C-u>ThettoDo move_to_input<CR><Right>
    nnoremap <buffer> I :<C-u>ThettoDo move_to_input<CR><Home>
    nnoremap <buffer> a :<C-u>ThettoDo move_to_input<CR>
    nnoremap <buffer> A :<C-u>ThettoDo move_to_input<CR><End>
    nnoremap <buffer> q :<C-u>quit<CR>
    nnoremap <silent> <buffer> <expr> j line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent> <buffer> <expr> k line('.') == 1 ? 'G' : 'k'
endfunction

autocmd MyAuGroup FileType thetto-input call s:thetto_input_settings()
function! s:thetto_input_settings() abort
    nnoremap <buffer> <CR> :<C-u>ThettoDo<CR>
    inoremap <buffer> <CR> <Esc>:ThettoDo<CR>
    nnoremap <silent> <buffer> dd :<C-u>silent %delete _<CR>
    inoremap <silent> <buffer> jq <Esc>:quit<CR>
    nnoremap <buffer> j :<C-u>ThettoDo move_to_list<CR>
    nnoremap <buffer> k :<C-u>ThettoDo move_to_list<CR>
    nnoremap <buffer> q :<C-u>quit<CR>
    inoremap <buffer> <C-u> <Cmd>lua require('notomo/insert').delete_prev()<CR>
endfunction
