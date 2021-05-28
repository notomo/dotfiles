autocmd MyAuGroup User ThettoSourceLoad lua dofile(vim.fn.expand('~/dotfiles/vim/lua/notomo/thetto.lua'))

ThettoSetup file/mru

autocmd MyAuGroup FileType thetto call s:thetto_settings()
function! s:thetto_settings() abort
    nnoremap <buffer> <CR> :<C-u>ThettoDo<CR>
    nnoremap <buffer> dd :<C-u>ThettoDo move_to_input<CR><Esc>:<C-u>silent delete _<CR>
    nnoremap <buffer> cc :<C-u>ThettoDo move_to_input<CR><Esc>:<C-u>silent delete _<CR>:<C-u>ThettoDo move_to_input<CR>
    nnoremap <buffer> i :<C-u>ThettoDo move_to_input --x-behavior=a<CR>
    nnoremap <buffer> I :<C-u>ThettoDo move_to_input<CR><Home>
    nnoremap <buffer> a :<C-u>ThettoDo move_to_input --x-behavior=a<CR>
    nnoremap <buffer> A :<C-u>ThettoDo move_to_input<CR><End>
    nnoremap <nowait> <buffer> q :<C-u>ThettoDo quit<CR>
    nnoremap <buffer> o :<C-u>ThettoDo open<CR>
    nnoremap <buffer> sv :<C-u>ThettoDo vsplit_open<CR>
    nnoremap <buffer> D :<C-u>ThettoDo debug_print<CR>
    nnoremap <buffer> t<Space> :<C-u>ThettoDo tab_open<CR>
    nnoremap <silent> <buffer> <expr> j line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent> <buffer> <expr> k line('.') == 1 ? 'G' : 'k'
    nnoremap <silent> <buffer> <2-LeftMouse> :<C-u>ThettoDo<CR>
    inoremap <silent> <buffer> <2-LeftMouse> <Cmd>ThettoDo<CR><ESC>
    nnoremap <buffer> <Tab> :<C-u>ThettoDo<Space>
    nnoremap <buffer> sm :<C-u>ThettoDo toggle_selection<CR><Down>
    xnoremap <buffer> sm :ThettoDo toggle_selection<CR>
    nnoremap <buffer> sa :<C-u>ThettoDo toggle_all_selection<CR>
    nnoremap <buffer> fo :<C-u>ThettoDo directory_open<CR>
    nnoremap <buffer> fl :<C-u>ThettoDo directory_tab_open<CR>
    nnoremap <buffer> ff :<C-u>ThettoDo directory_enter<CR>
    nnoremap <buffer> yy :<C-u>ThettoDo yank<CR>
    nnoremap <buffer> tsl :<C-u>ThettoDo toggle_sorter --x-name=length<CR>
    nnoremap <buffer> p :<C-u>ThettoDo toggle_preview<CR>
    nnoremap <buffer> P :<C-u>ThettoDo dry_run<CR>

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
nnoremap <Space>ur :<C-u>Thetto file/mru --auto=preview --target=project<CR>
nnoremap [finder]<CR> :<C-u>Thetto --resume<CR>
nnoremap <Space>usf :<C-u>Thetto file/recursive --auto=preview<CR>
nnoremap <Space>usg :<C-u>Thetto file/recursive --target=project --auto=preview<CR>
nnoremap [finder]f :<C-u>Thetto file/in_dir<CR>
nnoremap [finder]h :<C-u>Thetto vim/help --sorters=length<CR>
nnoremap [finder]l :<C-u>Thetto line --auto=preview --filters=regex --filters=-regex --filters=substring --filters=-substring<CR>
nnoremap [finder]r :<C-u>Thetto directory/recursive --target=project --sorters=length<CR>
nnoremap [finder]v :<C-u>Thetto file/recursive --cwd=~/dotfiles --auto=preview<CR>
nnoremap [finder]O :<C-u>Thetto vim/option<CR>
nnoremap [finder]H :<C-u>Thetto vim/highlight_group<CR>
nnoremap [finder]B :<C-u>Thetto vim/buffer --auto=preview<CR>
nnoremap [finder]y :<C-u>Thetto file/bookmark<CR>
nnoremap [finder]ga :<C-u>Thetto git/branch<CR>
nnoremap [finder]gA :<C-u>Thetto git/branch --x-all --xx-track<CR>
nnoremap [finder]gt :<C-u>Thetto git/tag<CR>
nnoremap [finder]gT :<C-u>Thetto git/tag --x-merged<CR>
nnoremap [finder]go :<C-u>Thetto directory/recursive --cwd=$GOPATH/src --x-max-depth=3<CR>
nnoremap [keyword]gg :<C-u>Thetto file/grep --target=project --pattern-type=word --auto=preview<CR>
nnoremap <silent> [finder]gl :<C-u>Thetto file/grep --auto=preview<CR>
nnoremap <silent> [finder]gg :<C-u>Thetto file/grep --target=project --auto=preview<CR>
nnoremap [finder]P :<C-u>Thetto process<CR>
nnoremap [finder]a :<C-u>Thetto vim/autocmd<CR>
nnoremap [finder]s :<C-u>Thetto source<CR>
nnoremap [finder]n :<C-u>ThettoDo --resume --offset=1<CR>
nnoremap [finder]N :<C-u>ThettoDo --resume --offset=-1<CR>
nnoremap [finder]m :<C-u>Thetto vim/keymap<CR>
nnoremap [finder]o :<C-u>Thetto outline --filters=regex --filters=-regex --auto=preview<CR>
nnoremap [finder], :<C-u>Thetto make/target --target=project --auto=preview<CR>
nnoremap [exec], :<C-u>Thetto make/target --target=upward --target-patterns=Makefile --auto=preview --no-insert<CR>
nnoremap [finder]S :<C-u>Thetto vim/substitute --auto=preview<CR>
xnoremap [finder]s :Thetto vim/substitute --auto=preview<CR>
nnoremap [finder]gd :<C-u>Thetto git/diff --auto=preview --target=project<CR>
nnoremap [finder]gr :<C-u>Thetto git/diff --auto=preview --target=project --x-expr=%:p<CR>
nnoremap [finder]G :<C-u>Thetto file/grep --auto=preview --target=project --filters=interactive --filters=substring --filters=-substring --filters=substring:path:relative --filters=-substring:path:relative --debounce-ms=100<CR>
nnoremap [finder]gL :<C-u>Thetto file/grep --auto=preview --filters=interactive --filters=substring --filters=-substring --filters=substring:path:relative --filters=-substring:path:relative --debounce-ms=100<CR>
nnoremap [file]f :<C-u>Thetto file/alter --auto=preview --immediately --no-insert<CR>
nnoremap [file]l :<C-u>Thetto file/alter --auto=preview --immediately --no-insert --action=tab_open<CR>
nnoremap [file]t :<C-u>Thetto file/alter --auto=preview --x-allow-new  --immediately --no-insert<CR>
nnoremap [finder]T :<C-u>Thetto vim/buffer --x-buftype=terminal --auto=preview<CR>
nnoremap [exec]cm :<C-u>Thetto vim/execute --x-cmd=messages --display-limit=1000 --no-insert --offset=1000<CR>
nnoremap [exec]cv :<C-u>Thetto vim/execute --x-cmd=version --no-insert<CR>
nnoremap [finder]J :<C-u>Thetto vim/jump --auto=preview<CR>
nnoremap [finder]c :<C-u>Thetto vim/command<CR>
nnoremap [finder]M :<C-u>Thetto manual --sorters=length<CR>
nnoremap [finder]q :<C-u>Thetto jq --filters=interactive --filters=substring --filters=-substring<CR>

" custom source
nnoremap [finder]p :<C-u>Thetto plugin<CR>
nnoremap [finder]b :<C-u>Thetto url/bookmark --action=browser_open<CR>
nnoremap [finder]e :<C-u>Thetto emoji --action=append --xx-key=emoji<CR>
nnoremap [finder]gp :<C-u>Thetto go/package<CR>

" custom action
nnoremap [finder]; :<C-u>Thetto vim/filetype --sorters=length --action=open_proto<CR>
