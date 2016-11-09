
"uniteを開いている間のキーマッピング
autocmd MyAuGroup FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
    imap <buffer> jq <Plug>(unite_exit)
    "入力モードのときjjでノーマルモードに移動
    imap <buffer> jj <Plug>(unite_insert_leave)
    "ctrl+hで縦に分割して開く
    nnoremap <silent> <buffer> <expr> <C-h> unite#do_action('split')
    inoremap <silent> <buffer> <expr> <C-h> unite#do_action('split')
    "ctrl+vで横に分割して開く
    nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
    inoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
    "ctrl+oでその場所に開く
    nnoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
    nnoremap <silent> <buffer> <expr> o unite#do_action('open')
    inoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
    "ctrl+tでタブで開く
    nnoremap <silent> <buffer> <expr> <C-t> unite#do_action('tabopen')
    inoremap <silent> <buffer> <expr> <C-t> unite#do_action('tabopen')

    nnoremap <silent> <buffer> <expr> v unite#do_action('persist_open')

    " nnoremap <silent> <buffer> <expr> ga unite#do_action('add')
    " nnoremap <silent> <buffer> <expr> gu unite#do_action('unstage')
    " nnoremap <silent> <buffer> <expr> gi unite#do_action('ignore')
    " nnoremap <silent> <buffer> <expr> gm unite#do_action('merge')
    " nnoremap <silent> <buffer> <expr> gC unite#do_action('commit')
    " nnoremap <silent> <buffer> <expr> gs unite#do_action('switch')
    " nnoremap <silent> <buffer> <expr> gA unite#do_action('amend')
    " nnoremap <silent> <buffer> <expr> gR unite#do_action('revert')

    nnoremap <silent> <buffer> <expr> yr unite#do_action('yank_rgb')
    nnoremap <silent> <buffer> <expr> yh unite#do_action('yank_hex')
    nnoremap <silent> <buffer> <expr> nr unite#do_action('insert_rgb')
    nnoremap <silent> <buffer> <expr> nh unite#do_action('insert_hex')

    inoremap <buffer> <C-b> <BS>
    inoremap <buffer> <C-d> <Del>
    inoremap <buffer> <C-h> <Left>
    inoremap <buffer> <C-l> <Right>

    nnoremap <buffer> b <C-^>

    vmap <buffer> sm <Plug>(unite_toggle_mark_selected_candidates)
    nmap <buffer> sm <Plug>(unite_toggle_mark_current_candidate)
endfunction"}}}

