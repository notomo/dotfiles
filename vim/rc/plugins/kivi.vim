autocmd MyAuGroup FileType kivi-* call s:kivi()
function! s:kivi() abort
    nnoremap <buffer> o <Cmd>KiviDo open<CR>
    nnoremap <buffer> t<Space> <Cmd>KiviDo tab_open<CR>
    nnoremap <buffer> sv <Cmd>KiviDo vsplit_open<CR>
    nnoremap <buffer> D <Cmd>KiviDo debug_print<CR>
    nnoremap <buffer> yr <Cmd>KiviDo yank<CR>
    nnoremap <buffer> <Space>h <Cmd>Kivi --path=~<CR>
    nnoremap <buffer> B <Cmd>KiviDo back<CR>
    nnoremap <nowait> <buffer> <Space>r :<C-u>Kivi --path=/tmp<CR>
    nnoremap <buffer> sm <Cmd>KiviDo toggle_selection<CR>j
    xnoremap <buffer> sm :KiviDo toggle_selection<CR>
    nnoremap <buffer> rn <Cmd>KiviDo rename<CR>
endfunction

autocmd MyAuGroup FileType kivi-file call s:kivi_file()
function! s:kivi_file() abort
    nnoremap <buffer> <Space>h <Cmd>Kivi --path=~<CR>
    nnoremap <nowait> <buffer> <Space>r :<C-u>Kivi --path=/tmp<CR>
    nnoremap <buffer> df <Cmd>KiviDo delete<CR>
    nnoremap <buffer> xf <Cmd>KiviDo cut<CR>
    nnoremap <buffer> yf <Cmd>KiviDo copy<CR>
    nnoremap <buffer> p <Cmd>KiviDo paste<CR>
endfunction
