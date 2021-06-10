autocmd MyAuGroup User ThettoSourceLoad lua dofile(vim.fn.expand('~/dotfiles/vim/lua/notomo/thetto.lua'))

ThettoSetup file/mru

autocmd MyAuGroup FileType thetto call s:thetto_settings()
function! s:thetto_settings() abort
    nnoremap <buffer> <CR> <Cmd>ThettoDo<CR>
    nnoremap <buffer> dd <Cmd>ThettoDo move_to_input<CR><Esc><Cmd>silent delete _<CR>
    nnoremap <buffer> cc <Cmd>ThettoDo move_to_input<CR><Esc><Cmd>silent delete _<CR><Cmd>ThettoDo move_to_input<CR>
    nnoremap <buffer> i <Cmd>ThettoDo move_to_input --x-behavior=a<CR>
    nnoremap <buffer> I <Cmd>ThettoDo move_to_input<CR><Home>
    nnoremap <buffer> a <Cmd>ThettoDo move_to_input --x-behavior=a<CR>
    nnoremap <buffer> A <Cmd>ThettoDo move_to_input<CR><End>
    nnoremap <nowait> <buffer> q <Cmd>ThettoDo quit<CR>
    nnoremap <buffer> o <Cmd>ThettoDo open<CR>
    nnoremap <buffer> sv <Cmd>ThettoDo vsplit_open<CR>
    nnoremap <buffer> D <Cmd>ThettoDo debug_print<CR>
    nnoremap <buffer> t<Space> <Cmd>ThettoDo tab_open<CR>
    nnoremap <silent> <buffer> <expr> j line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent> <buffer> <expr> k line('.') == 1 ? 'G' : 'k'
    nnoremap <silent> <buffer> <2-LeftMouse> <Cmd>ThettoDo<CR>
    inoremap <silent> <buffer> <2-LeftMouse> <Cmd>ThettoDo<CR><ESC>
    nnoremap <buffer> <Tab> :<C-u>ThettoDo<Space>
    nnoremap <buffer> sm <Cmd>ThettoDo toggle_selection<CR><Down>
    xnoremap <buffer> sm :ThettoDo toggle_selection<CR>
    nnoremap <buffer> sa <Cmd>ThettoDo toggle_all_selection<CR>
    nnoremap <buffer> fo <Cmd>ThettoDo directory_open<CR>
    nnoremap <buffer> fl <Cmd>ThettoDo directory_tab_open<CR>
    nnoremap <buffer> ff <Cmd>ThettoDo directory_enter<CR>
    nnoremap <buffer> yy <Cmd>ThettoDo yank<CR>
    nnoremap <buffer> tsl <Cmd>ThettoDo toggle_sorter --x-name=length<CR>
    nnoremap <buffer> p <Cmd>ThettoDo toggle_preview<CR>
    nnoremap <buffer> P <Cmd>ThettoDo dry_run<CR>

    " custom
    nnoremap <buffer> <Leader>rp <Cmd>ThettoDo qfreplace<CR>
endfunction

autocmd MyAuGroup FileType thetto-input call s:thetto_input_settings()
function! s:thetto_input_settings() abort
    nnoremap <buffer> <CR> <Cmd>ThettoDo<CR>
    inoremap <buffer> <CR> <Esc>:ThettoDo<CR>
    inoremap <silent> <buffer> jq <Cmd>ThettoDo quit<CR><ESC>
    nnoremap <buffer> j <Cmd>ThettoDo move_to_list<CR>
    nnoremap <silent> <buffer> <expr> J line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent> <buffer> <expr> k line('.') == 1 ? 'G' : 'k'
    nnoremap <silent> <buffer> <expr> K line('.') == 1 ? 'G' : 'k'
    nnoremap <buffer> q <Cmd>ThettoDo quit<CR>
    nnoremap <buffer> o <Cmd>ThettoDo open<CR>
    nnoremap <buffer> sv <Cmd>ThettoDo vsplit_open<CR>
    nnoremap <buffer> t<Space> <Cmd>ThettoDo tab_open<CR>
    nnoremap <buffer> fan <Cmd>ThettoDo add_filter --x-name=-substring<CR>Gi
    nnoremap <buffer> fd <Cmd>ThettoDo remove_filter<CR>
    nnoremap <buffer> fi <Cmd>ThettoDo inverse_filter<CR>
    nnoremap <buffer> sr <Cmd>ThettoDo reverse_sorter<CR>

    " custom
    inoremap <buffer> <C-u> <Cmd>lua require('notomo/insert').delete_prev()<CR>
endfunction

nnoremap [finder]R <Cmd>Thetto vim/runtimepath<CR>
nnoremap <Space>ur <Cmd>Thetto file/mru --auto=preview --target=project<CR>
nnoremap [finder]<CR> <Cmd>Thetto --resume<CR>
nnoremap <Space>usf <Cmd>Thetto file/recursive --auto=preview<CR>
nnoremap <Space>usg <Cmd>Thetto file/recursive --target=project --auto=preview<CR>
nnoremap [finder]f <Cmd>Thetto file/in_dir<CR>
nnoremap [finder]h <Cmd>Thetto vim/help --sorters=length<CR>
nnoremap [finder]l <Cmd>Thetto line --auto=preview --filters=regex --filters=-regex --filters=substring --filters=-substring<CR>
nnoremap [finder]r <Cmd>Thetto directory/recursive --target=project --sorters=length<CR>
nnoremap <Space>usd <Cmd>Thetto directory/recursive --sorters=length<CR>
nnoremap [finder]v <Cmd>Thetto file/recursive --cwd=~/dotfiles --auto=preview<CR>
nnoremap [finder]O <Cmd>Thetto vim/option<CR>
nnoremap [finder]H <Cmd>Thetto vim/highlight_group<CR>
nnoremap [finder]B <Cmd>Thetto vim/buffer --auto=preview<CR>
nnoremap [finder]y <Cmd>Thetto file/bookmark<CR>
nnoremap [finder]ga <Cmd>Thetto git/branch<CR>
nnoremap [finder]gA <Cmd>Thetto git/branch --x-all --xx-track<CR>
nnoremap [finder]gt <Cmd>Thetto git/tag<CR>
nnoremap [finder]gT <Cmd>Thetto git/tag --x-merged<CR>
nnoremap [finder]go <Cmd>Thetto directory/recursive --cwd=$GOPATH/src --x-max-depth=3<CR>
nnoremap [keyword]gg <Cmd>Thetto file/grep --target=project --pattern-type=word --auto=preview<CR>
nnoremap <silent> [finder]gl <Cmd>Thetto file/grep --auto=preview<CR>
nnoremap <silent> [finder]gg <Cmd>Thetto file/grep --target=project --auto=preview<CR>
nnoremap [finder]P <Cmd>Thetto process<CR>
nnoremap [finder]a <Cmd>Thetto vim/autocmd<CR>
nnoremap [finder]s <Cmd>Thetto source<CR>
nnoremap [finder]n <Cmd>ThettoDo --resume --offset=1<CR>
nnoremap [finder]N <Cmd>ThettoDo --resume --offset=-1<CR>
nnoremap [finder]m <Cmd>Thetto vim/keymap<CR>
nnoremap [finder]o <Cmd>Thetto outline --filters=regex --filters=-regex --auto=preview<CR>
nnoremap [finder], <Cmd>Thetto make/target --target=project --auto=preview<CR>
nnoremap [exec], <Cmd>Thetto make/target --target=upward --target-patterns=Makefile --auto=preview --no-insert<CR>
nnoremap [finder]S <Cmd>Thetto vim/substitute --auto=preview<CR>
xnoremap [finder]s :Thetto vim/substitute --auto=preview<CR>
nnoremap [finder]gd <Cmd>Thetto git/diff --auto=preview --target=project<CR>
nnoremap [finder]gr <Cmd>Thetto git/diff --auto=preview --target=project --x-expr=%:p<CR>
nnoremap [finder]G <Cmd>Thetto file/grep --auto=preview --target=project --filters=interactive --filters=substring --filters=-substring --filters=substring:path:relative --filters=-substring:path:relative --debounce-ms=100<CR>
nnoremap [finder]gL <Cmd>Thetto file/grep --auto=preview --filters=interactive --filters=substring --filters=-substring --filters=substring:path:relative --filters=-substring:path:relative --debounce-ms=100<CR>
nnoremap [file]f <Cmd>Thetto file/alter --auto=preview --immediately --no-insert<CR>
nnoremap [file]l <Cmd>Thetto file/alter --auto=preview --immediately --no-insert --action=tab_open<CR>
nnoremap [file]t <Cmd>Thetto file/alter --auto=preview --x-allow-new  --immediately --no-insert<CR>
nnoremap [finder]T <Cmd>Thetto vim/buffer --x-buftype=terminal --auto=preview<CR>
nnoremap [exec]cm <Cmd>Thetto vim/execute --x-cmd=messages --display-limit=1000 --no-insert --offset=1000<CR>
nnoremap [exec]cv <Cmd>Thetto vim/execute --x-cmd=version --no-insert<CR>
nnoremap [finder]J <Cmd>Thetto vim/jump --auto=preview<CR>
nnoremap [finder]c <Cmd>Thetto vim/command<CR>
nnoremap [finder]M <Cmd>Thetto manual --sorters=length<CR>
nnoremap [finder]q <Cmd>Thetto jq --filters=interactive --filters=substring --filters=-substring<CR>
nnoremap [finder]gR <Cmd>Thetto gron --filters=substring --filters=-substring<CR>

" custom source
nnoremap [finder]p <Cmd>Thetto plugin<CR>
nnoremap [finder]b <Cmd>Thetto url/bookmark --action=browser_open<CR>
nnoremap [finder]e <Cmd>Thetto emoji --action=append --xx-key=emoji<CR>
nnoremap [finder]gp <Cmd>Thetto go/package<CR>

" custom action
nnoremap [finder]; <Cmd>Thetto vim/filetype --sorters=length --action=open_proto<CR>
