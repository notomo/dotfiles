autocmd MyAuGroup User ThettoSourceLoad lua dofile(vim.fn.expand('~/dotfiles/vim/lua/notomo/thetto.lua'))

autocmd MyAuGroup FileType thetto call s:thetto_settings()
function! s:thetto_settings() abort
    nnoremap <buffer> <CR> :<C-u>ThettoDo<CR>
    nnoremap <buffer> dd :<C-u>ThettoDo move_to_input<CR><Esc>:<C-u>silent delete _<CR>
    nnoremap <buffer> cc :<C-u>ThettoDo move_to_input<CR><Esc>:<C-u>silent delete _<CR>:<C-u>ThettoDo move_to_input<CR>
    nnoremap <buffer> i :<C-u>ThettoDo move_to_input<CR>
    nnoremap <buffer> I :<C-u>ThettoDo move_to_input<CR><Home>
    nnoremap <buffer> a :<C-u>ThettoDo move_to_input --x-behavior=a<CR>
    nnoremap <buffer> A :<C-u>ThettoDo move_to_input<CR><End>
    nnoremap <buffer> q :<C-u>ThettoDo quit<CR>
    nnoremap <buffer> o :<C-u>ThettoDo open<CR>
    nnoremap <buffer> sv :<C-u>ThettoDo vsplit_open<CR>
    nnoremap <buffer> D :<C-u>ThettoDo debug_print<CR>
    nnoremap <buffer> t<Space> :<C-u>ThettoDo tab_open<CR>
    nnoremap <silent> <buffer> <expr> j line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent> <buffer> <expr> k line('.') == 1 ? 'G' : 'k'
    nnoremap <silent> <buffer> <2-LeftMouse> :<C-u>ThettoDo<CR>
    nnoremap <buffer> <Tab> :<C-u>ThettoDo<Space>
    nnoremap <buffer> sm :<C-u>ThettoDo toggle_selection<CR><Down>
    nnoremap <buffer> sa :<C-u>ThettoDo toggle_all_selection<CR><Down>
    nnoremap <buffer> fo :<C-u>ThettoDo directory_open<CR>
    nnoremap <buffer> fl :<C-u>ThettoDo directory_tab_open<CR>
    nnoremap <buffer> ff :<C-u>ThettoDo directory_enter<CR>
    nnoremap <buffer> yy :<C-u>ThettoDo yank<CR>

    " custom
    nnoremap <buffer> <Leader>rp :<C-u>ThettoDo qfreplace<CR>
endfunction

autocmd MyAuGroup FileType thetto-input call s:thetto_input_settings()
function! s:thetto_input_settings() abort
    nnoremap <buffer> <CR> :<C-u>ThettoDo<CR>
    inoremap <buffer> <CR> <Esc>:ThettoDo<CR>
    inoremap <silent> <buffer> jq <Cmd>ThettoDo quit<CR><ESC>
    nnoremap <buffer> j :<C-u>ThettoDo move_to_list<CR>
    nnoremap <silent> <buffer> <expr> J line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent> <buffer> <expr> k line('.') == 1 ? 'G' : 'k'
    nnoremap <silent> <buffer> <expr> K line('.') == 1 ? 'G' : 'k'
    nnoremap <buffer> q :<C-u>ThettoDo quit<CR>
    nnoremap <buffer> o :<C-u>ThettoDo open<CR>
    nnoremap <buffer> sv :<C-u>ThettoDo vsplit_open<CR>
    nnoremap <buffer> t<Space> :<C-u>ThettoDo tab_open<CR>
    nnoremap <buffer> fan :<C-u>ThettoDo add_filter --x-name=-substring<CR>Gi
    nnoremap <buffer> fd :<C-u>ThettoDo remove_filter<CR>
    nnoremap <buffer> fi :<C-u>ThettoDo inverse_filter<CR>
    nnoremap <buffer> sr :<C-u>ThettoDo reverse_sorter<CR>

    " custom
    inoremap <buffer> <C-u> <Cmd>lua require('notomo/insert').delete_prev()<CR>
endfunction

nnoremap [finder]R :<C-u>Thetto vim/runtimepath<CR>
nnoremap <Space>ur :<C-u>Thetto file/mru<CR>
nnoremap [finder]<CR> :<C-u>Thetto --resume<CR>
nnoremap <Space>usf :<C-u>Thetto file/recursive<CR>
nnoremap <Space>usg :<C-u>Thetto file/recursive --target=project<CR>
nnoremap [finder]f :<C-u>Thetto file/in_dir<CR>
nnoremap [finder]h :<C-u>Thetto vim/help<CR>
nnoremap [finder]l :<C-u>Thetto line<CR>
nnoremap [finder]r :<C-u>Thetto directory/recursive --target=project --sorters=length<CR>
nnoremap [finder]v :<C-u>Thetto file/recursive --cwd=~/dotfiles<CR>
nnoremap [finder]O :<C-u>Thetto vim/option<CR>
nnoremap [finder]H :<C-u>Thetto vim/highlight_group<CR>
nnoremap [finder]B :<C-u>Thetto vim/buffer<CR>
nnoremap [finder]y :<C-u>Thetto file/bookmark<CR>
nnoremap [finder]ga :<C-u>Thetto git/branch<CR>
nnoremap [finder]gA :<C-u>Thetto git/branch --x-all --xx-track<CR>
nnoremap [finder]go :<C-u>Thetto directory/recursive --cwd=$GOPATH/src --x-max-depth=3<CR>
nnoremap [keyword]gg :<C-u>Thetto file/grep --target=project --pattern-type=word<CR>
nnoremap <silent> [finder]gl :<C-u>Thetto file/grep<CR>
nnoremap <silent> [finder]gg :<C-u>Thetto file/grep --target=project<CR>
nnoremap [finder]P :<C-u>Thetto process<CR>
nnoremap [finder]a :<C-u>Thetto vim/autocmd<CR>
nnoremap [finder]s :<C-u>Thetto source<CR>
nnoremap [finder]n :<C-u>ThettoDo --resume --offset=1<CR>
nnoremap [finder]N :<C-u>ThettoDo --resume --offset=-1<CR>
nnoremap [finder]m :<C-u>Thetto vim/keymap<CR>
nnoremap [finder]o :<C-u>Thetto outline<CR>

" custom source
nnoremap [finder]p :<C-u>Thetto plugin<CR>
nnoremap [finder]b :<C-u>Thetto url/bookmark --action=browser_open<CR>
nnoremap [finder]e :<C-u>Thetto emoji --action=append --xx-key=emoji<CR>

" custom action
nnoremap [finder]; :<C-u>Thetto vim/filetype --action=open_proto<CR>
