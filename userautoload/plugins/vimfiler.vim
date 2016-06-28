"現在開いているバッファのディレクトリを開く
nnoremap <silent> <Space>to :<C-u>VimFilerBufferDir -quit<CR>
"現在開いているバッファをIDE風に開く
nnoremap <Space>tl :<C-u>:CdCurrent<CR>:VimFilerBufferDir -split -simple -toggle -no-quit -winwidth=35<CR>

function! NewUnixFormatFile() abort
	let file_name = input("New files name(comma separated):")
	execute "normal NF".file_name."\<CR>l\<Space>fouma"
endfunction
command! NewUnixFormatFileCommand call NewUnixFormatFile()

let s:bundle=neobundle#get('vimfiler.vim')
function! s:bundle.hooks.on_source(bundle)
    call vimfiler#custom#profile('default', 'context', {
    \ 'safe' : 0,
    \ 'simple' : 1,
    \ 'no-quit' : 1,
    \ })
    let g:vimfiler_enable_auto_cd = 1
    "vimデフォルトのエクスプローラをvimfilerで置き換える
    let g:vimfiler_as_default_explorer = 1
    let g:vimfiler_ignore_pattern = ['^\.DS_Store$']
    "デフォルトのキーマッピングを変更
    let g:vimfiler_no_default_key_mappings=1
endfunction
unlet s:bundle

autocmd MyAuGroup FileType vimfiler call s:vimfiler_my_settings()
function! s:vimfiler_my_settings()
    nmap <buffer> j <Plug>(vimfiler_loop_cursor_down)
    nmap <buffer> k <Plug>(vimfiler_loop_cursor_up)
    nmap <buffer> gg <Plug>(vimfiler_cursor_top)
    nmap <buffer> o <Plug>(vimfiler_expand_or_edit)
    nmap <buffer> <Enter> <Plug>(vimfiler_expand_or_edit)
    nmap <buffer> l <Plug>(vimfiler_smart_l)
    nmap <buffer> h <Plug>(vimfiler_smart_h)
    nmap <buffer> rl <Plug>(vimfiler_redraw_screen)
    nmap <buffer> q <Plug>(vimfiler_exit)
    nmap <buffer> Q <Plug>(vimfiler_hide)
    nmap <buffer> e <Plug>(vimfiler_edit_file)
    nmap <buffer> v <Plug>(vimfiler_preview_file)
    nnoremap <silent><buffer><expr> t vimfiler#do_action("tabopen")
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
    nmap <buffer>NF <Plug>(vimfiler_new_file)
    nnoremap <buffer>nf :<C-u>NewUnixFormatFileCommand<CR>
    nmap <buffer>K <Plug>(vimfiler_jump_first_child)
    nmap <buffer>J <Plug>(vimfiler_jump_last_child)
    nmap <buffer><Space>h <Plug>(vimfiler_switch_to_home_directory)
    nmap <buffer><Space>r <Plug>(vimfiler_switch_to_root_directory)
    nmap <buffer>s <Plug>(vimfiler_toggle_mark_current_line)
    nmap <buffer><Space>pu <Plug>(vimfiler_pushd)
    nmap <buffer><Space>po <Plug>(vimfiler_popd)
    " nmap <buffer>f <Plug>(vimfiler_find)
    nmap <buffer><Space>m <Plug>(vimfiler_toggle_mark_current_line)
    nmap <buffer>cd <Plug>(vimfiler_cd_input_directory)
endfunction
