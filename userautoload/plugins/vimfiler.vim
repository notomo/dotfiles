let g:vimfiler_enable_auto_cd = 1
"vimデフォルトのエクスプローラをvimfilerで置き換える
let g:vimfiler_as_default_explorer = 1
"現在開いているバッファのディレクトリを開く
nnoremap <silent> <Space>to :<C-u>VimFilerBufferDir -quit<CR>
"現在開いているバッファをIDE風に開く
nnoremap <Space>tl :<C-u>:CdCurrent<CR>:VimFilerBufferDir -split -simple -toggle -no-quit -winwidth=35<CR>
let g:vimfiler_no_default_key_mappings=1
"デフォルトのキーマッピングを変更
augroup vimrc
    autocmd FileType vimfiler call s:vimfiler_my_settings()
augroup END
function! s:vimfiler_my_settings()
    nmap <buffer> j <Plug>(vimfiler_loop_cursor_down)
    nmap <buffer> k <Plug>(vimfiler_loop_cursor_up)
    nmap <buffer> gg <Plug>(vimfiler_cursor_top)
    nmap <buffer> o <Plug>(vimfiler_expand_or_edit)
    nmap <buffer> l <Plug>(vimfiler_smart_l)
    nmap <buffer> h <Plug>(vimfiler_smart_h)
    nmap <buffer> <C-l> <Plug>(vimfiler_redraw_screen)
    nmap <buffer> q <Plug>(vimfiler_exit)
    nmap <buffer> Q <Plug>(vimfiler_hide)
    nmap <buffer> e <Plug>(vimfiler_edit_file)
    " nmap <buffer> l <Plug>(vimfiler_expand_or_edit)
    " nmap <buffer> l <Plug>(vimfiler_expand_tree)
    nmap <buffer> r <Plug>(vimfiler_preview_file)
    nnoremap <silent><buffer><expr> t vimfiler#do_action("tabopen")
    " nnoremap <silent><buffer><expr> n vimfiler#do_action("persist_open")
    nmap <buffer> a <Plug>(vimfiler_choose_action)
    nnoremap <buffer><silent>/ :<C-u>Unite file -default-action=vimfiler<CR>
endfunction
 " Edit file by tabedit.
" let g:vimfiler_edit_action = 'tabopen'

function! s:my_preview()
    normal <Plug>(vimfiler_smart_l)
    normal <C-w>p
endfunction
