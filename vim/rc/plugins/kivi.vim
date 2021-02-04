
nnoremap [exec]f <Cmd>Kivi --layout=vertical --new<CR>

autocmd MyAuGroup FileType kivi-* call s:kivi()
function! s:kivi() abort
    nnoremap <buffer> o <Cmd>KiviDo open<CR>
    nnoremap <expr> <buffer> t<Space> kivi#is_parent() ? '<Cmd>KiviDo tab_open<CR>' : '<Cmd>KiviDo tab_open --quit<CR>'
    nnoremap <expr> <buffer> sv kivi#is_parent() ? '<Cmd>KiviDo vsplit_open<CR>' : '<Cmd>KiviDo vsplit_open --quit<CR>'
    nnoremap <buffer> D <Cmd>KiviDo debug_print<CR>
    nnoremap <buffer> yr <Cmd>KiviDo yank<CR>
    nnoremap <buffer> <Space>h <Cmd>Kivi --path=~<CR>
    nnoremap <buffer> <Space>g <Cmd>Kivi --target=project<CR>
    nnoremap <buffer> B <Cmd>KiviDo back<CR>
    nnoremap <nowait> <buffer> <Space>r :<C-u>Kivi --path=/tmp<CR>
    nnoremap <buffer> sm <Cmd>KiviDo toggle_selection<CR>j
    xnoremap <buffer> sm :KiviDo toggle_selection<CR>
    nnoremap <buffer> rn <Cmd>KiviDo rename<CR>
    nnoremap <buffer> o <Cmd>KiviDo toggle_tree<CR>
    nnoremap <buffer> <2-LeftMouse> <Cmd>KiviDo child<CR>
    packadd gesture.nvim
lua << EOF
local gesture = require('gesture')
gesture.register({
    name = "go to the parent",
    buffer = "%",
    inputs = { gesture.left() },
    action = "KiviDo parent"
})
EOF
endfunction

autocmd MyAuGroup FileType kivi-file call s:kivi_file()
function! s:kivi_file() abort
    nnoremap <buffer> <Space>h <Cmd>Kivi --path=~<CR>
    nnoremap <nowait> <buffer> <Space>r :<C-u>Kivi --path=/tmp<CR>
    nnoremap <buffer> df <Cmd>KiviDo delete<CR>
    nnoremap <buffer> xf <Cmd>KiviDo cut<CR>
    nnoremap <buffer> yf <Cmd>KiviDo copy<CR>
    nnoremap <buffer> p <Cmd>KiviDo paste<CR>
    nnoremap <buffer> i <Cmd>KiviDo create<CR>
endfunction

autocmd MyAuGroup BufRead */kivi-renamer,*/kivi-creator call s:kivi_input()
function! s:kivi_input() abort
    nnoremap <buffer> q <Cmd>quit!<CR>
    inoremap <buffer> jq <ESC><Cmd>quit!<CR>
endfunction
