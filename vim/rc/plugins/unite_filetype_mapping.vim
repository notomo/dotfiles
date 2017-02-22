function! s:change_source(source_name) abort
    execute 'Unite ' . a:source_name . ' -no-start-insert -input=' . join(split(getline(1), ' '), '\ ')
endfunction

autocmd MyAuGroup FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
    imap <buffer> jq <Plug>(unite_exit)
    imap <buffer> jj <Plug>(unite_insert_leave)
    nnoremap <silent> <buffer> <expr> o unite#do_action('open')
    nnoremap <silent> <buffer> <expr> to unite#do_action('tabopen')
    vmap <buffer> sm <Plug>(unite_toggle_mark_selected_candidates)
    nmap <buffer> sm <Plug>(unite_toggle_mark_current_candidate)

    nnoremap <silent> <buffer> <expr> sh unite#do_action('split')
    nnoremap <silent> <buffer> <expr> sv unite#do_action('vsplit')
    nnoremap <silent> <buffer> <expr> fl unite#do_action('tabvimfiler')
    nnoremap <silent> <buffer> <expr> fo unite#do_action('vimfiler')
    nnoremap <silent> <buffer> <expr> ff unite#do_action('file')
    nnoremap <silent> <buffer> <expr> fp unite#do_action('parent_file')
    nnoremap <silent> <buffer> uf :call <SID>change_source('file')<CR>
    nnoremap <silent> <buffer> ub :call <SID>change_source('buffer')<CR>
    nnoremap <silent> <buffer> ur :call <SID>change_source('neomru/file')<CR>
    nnoremap <silent> <buffer> ut :call <SID>change_source('tab')<CR>

    nmap <buffer> i <Plug>(unite_insert_enter)
    nmap <buffer> a gg<Plug>(unite_insert_enter)
    nmap <buffer> I <Plug>(unite_insert_head)
    nmap <buffer> A <Plug>(unite_append_end)
    nmap <buffer> q <Plug>(unite_exit)
    nmap <buffer> <C-r> <Plug>(unite_restart)
    nmap <buffer> * <Plug>(unite_toggle_mark_all_candidates)
    nmap <buffer> <Tab> <Plug>(unite_choose_action)
    nmap <buffer> <C-l> <Plug>(unite_redraw)
    nmap <buffer> j <Plug>(unite_loop_cursor_down)
    nmap <buffer> k <Plug>(unite_loop_cursor_up)
    nmap <buffer> <2-LeftMouse> <Plug>(unite_do_default_action)
    nmap <buffer> <RightMouse> <Plug>(unite_exit)
    nmap <buffer> p <Plug>(unite_smart_preview)
    nmap <buffer> <CR> <Plug>(unite_do_default_action)
    nmap <buffer> gg <Plug>(unite_cursor_top)
    nmap <buffer> G <Plug>(unite_cursor_bottom)

    imap <buffer> <C-u> <Plug>(unite_delete_backward_line)
    imap <buffer> <CR> <Plug>(unite_do_default_action)
    imap <buffer> <C-n> <Plug>(unite_select_next_page)
    imap <buffer> <C-p> <Plug>(unite_select_previous_page)
    imap <buffer> <2-LeftMouse> <Plug>(unite_do_default_action)
    imap <buffer> <RightMouse> <Plug>(unite_exit)
    imap <buffer> <C-b> <Plug>(unite_delete_backward_char)
    imap <buffer> <C-N> <Plug>(unite_narrowing_input_history)
endfunction

