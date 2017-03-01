let s:hsplit = {'is_selectable' : 1}
function! s:hsplit.func(candidates)
    wincmd p
    execute 'split '. a:candidates[0].action__path
endfunction
call unite#custom_action('file', 'hsplit', s:hsplit)
unlet s:hsplit

function! s:new_file() abort
    let file_names = input('New file names separated with commas : ')
    for file_name in split(file_names, ',')
        execute "normal \<Plug>(vimfiler_new_file)" . file_name . "\<CR>"
        execute "normal \<Plug>(vimfiler_edit_file)"
        set fileformat=unix
        wincmd p
    endfor
endfunction

autocmd MyAuGroup FileType vimfiler call s:vimfiler_my_settings()
function! s:vimfiler_my_settings()
    nmap <buffer> j <Plug>(vimfiler_loop_cursor_down)
    nmap <buffer> k <Plug>(vimfiler_loop_cursor_up)
    nmap <buffer> gg <Plug>(vimfiler_cursor_top)
    nmap <buffer> o <Plug>(vimfiler_expand_or_edit)
    nmap <buffer> <CR> <Plug>(vimfiler_expand_or_edit)
    nmap <buffer> l <Plug>(vimfiler_smart_l)
    nmap <buffer> h <Plug>(vimfiler_smart_h)
    nmap <buffer> q <Plug>(vimfiler_exit)
    nmap <buffer> Q <Plug>(vimfiler_hide)
    nmap <buffer> e <Plug>(vimfiler_edit_file)
    nmap <buffer> <Space>pv <Plug>(vimfiler_preview_file)
    nnoremap <silent><buffer><expr> to vimfiler#do_action('tabopen')
    nmap <buffer> a <Plug>(vimfiler_choose_action)
    nnoremap <buffer><silent> u <C-w>l:<C-u>Unite file<CR>
    nmap <buffer> x <Plug>(vimfiler_execute_external_filer)
    nmap <buffer> X <Plug>(vimfiler_execute_system_associated)
    nmap <buffer> <2-LeftMouse> <Plug>(vimfiler_double_click)
    nmap <buffer>yp <Plug>(vimfiler_yank_full_path)
    nmap <buffer>yf <Plug>(vimfiler_clipboard_copy_file)
    nmap <buffer>xf <Plug>(vimfiler_clipboard_move_file)
    nmap <buffer>p <Plug>(vimfiler_clipboard_paste)
    nmap <buffer>rn <Plug>(vimfiler_rename_file)
    nmap <buffer>df <Plug>(vimfiler_delete_file)
    nmap <buffer>nd <Plug>(vimfiler_make_directory)
    nnoremap <buffer>nf :<C-u>call <SID>new_file()<CR>
    nmap <buffer>K <Plug>(vimfiler_jump_first_child)
    nmap <buffer>J <Plug>(vimfiler_jump_last_child)
    nmap <buffer><Space>h <Plug>(vimfiler_switch_to_home_directory)
    nmap <buffer><Space>r <Plug>(vimfiler_switch_to_root_directory)
    nmap <buffer><Space>g <Plug>(vimfiler_switch_to_project_directory)
    nmap <buffer>sm <Plug>(vimfiler_toggle_mark_current_line)
    nmap <buffer><Space>pu <Plug>(vimfiler_pushd)
    nmap <buffer><Space>po <Plug>(vimfiler_popd)
    nmap <buffer>cd <Plug>(vimfiler_cd_input_directory)
    vmap <buffer>sm <Plug>(vimfiler_toggle_mark_selected_lines)
    nmap <buffer>sv <Plug>(vimfiler_split_edit_file)
    nnoremap <silent> <buffer> <expr> sh vimfiler#do_action('hsplit')
    nmap <buffer>O <Plug>(vimfiler_expand_tree_recursive)
    nmap <buffer> ss <Plug>(vimfiler_select_sort_type)
    nmap <buffer> rl <Plug>(vimfiler_close)[exec]f
    nmap <buffer> ug <Plug>(vimfiler_grep)
endfunction
