nnoremap [unite] <Nop>
nmap <Space>u [unite]
xnoremap [unite] <Nop>
xmap <Space>u [unite]

nnoremap <silent> [unite]n :<C-u>UniteNext<CR>
nnoremap <silent> [unite]N :<C-u>UnitePrevious<CR>
nnoremap <silent> [unite]<CR> :<C-u>UniteResume<CR>

call unite#custom#profile('default', 'context', {
\   'no_split' : 1,
\   'start_insert' : 1
\ })

let g:unite_no_default_keymappings = 1
let g:unite_enable_auto_select = 0

autocmd MyAuGroup FileType unite call s:settings()
function! s:settings()
    imap <buffer> jq <Plug>(unite_exit)
    imap <buffer> jj <Plug>(unite_insert_leave)
    nnoremap <silent> <buffer> <expr> o unite#do_action('open')
    nnoremap <silent> <buffer> <expr> t<Space> unite#do_action('tabopen')
    xmap <buffer> sm <Plug>(unite_toggle_mark_selected_candidates)
    nmap <buffer> sm <Plug>(unite_toggle_mark_current_candidate)

    nnoremap <silent> <buffer> <expr> sh unite#do_action('split')
    nnoremap <silent> <buffer> <expr> sv unite#do_action('vsplit')
    nnoremap <silent> <buffer> <expr> fl unite#do_action('tabvimfiler')
    nnoremap <silent> <buffer> <expr> fo unite#do_action('vimfiler')
    nnoremap <silent> <buffer> <expr> ff unite#do_action('file')

    nnoremap <silent> <buffer> <expr> t<CR> unite#do_action('checkout_tracking')

    nmap <buffer> i <Plug>(unite_insert_enter)
    nmap <buffer> a gg<Plug>(unite_insert_enter)
    nmap <buffer> I <Plug>(unite_insert_head)
    nmap <buffer> A <Plug>(unite_append_end)
    nmap <buffer> q <Plug>(unite_exit)
    nmap <buffer> * <Plug>(unite_toggle_mark_all_candidates)
    nmap <buffer> <Tab> <Plug>(unite_choose_action)
    nmap <buffer> j <Plug>(unite_loop_cursor_down)
    nmap <buffer> k <Plug>(unite_loop_cursor_up)
    nmap <buffer> p <Plug>(unite_smart_preview)
    nmap <buffer> <CR> <Plug>(unite_do_default_action)
    nmap <buffer> gg <Plug>(unite_cursor_top)
    nmap <buffer> G <Plug>(unite_cursor_bottom)

    imap <buffer> <C-u> <Plug>(unite_delete_backward_line)
    imap <buffer> <CR> <Plug>(unite_do_default_action)
    imap <buffer> <C-b> <Plug>(unite_delete_backward_char)
endfunction

