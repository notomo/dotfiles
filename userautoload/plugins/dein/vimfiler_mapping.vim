"現在開いているバッファのディレクトリを開く
nnoremap <silent> <Space>to :<C-u>VimFilerBufferDir -quit<CR>
"現在開いているバッファをIDE風に開く
nnoremap <Space>tl :<C-u>VimFilerBufferDir -split -simple -toggle -no-quit -winwidth=35<CR>

function! NewUnixFormatFile() abort
    let file_name = input("New files name(comma separated):")
    if file_name != ""
        execute "normal \<Plug>(vimfiler_new_file)".file_name."\<CR>|l\<Space>fouma"
    else
        echomsg " Canceled"
    endif
endfunction
command! NewUnixFormatFileCommand call NewUnixFormatFile()

