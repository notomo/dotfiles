nnoremap <silent> [exec]d :<C-u>Defx `expand('%:p:h')` -search=`expand('%:p')` -split=vertical<CR>

autocmd MyAuGroup FileType defx call s:settings()
function! s:settings() abort
    nnoremap <silent> <buffer> <expr> <CR> defx#do_action('open')
    nnoremap <silent> <buffer> <expr> o defx#do_action('open')
    nnoremap <silent> <buffer> <expr> yf defx#do_action('copy')
    nnoremap <silent> <buffer> <expr> xf defx#do_action('move')
    nnoremap <silent> <buffer> <expr> p defx#do_action('paste')
    nnoremap <silent> <buffer> <expr> l defx#do_action('open')
    nnoremap <silent> <buffer> <expr> sh defx#do_action('open', 'botright split')
    nnoremap <silent> <buffer> <expr> sv defx#do_action('open', 'botright vsplit')
    nnoremap <silent> <buffer> <expr> P defx#do_action('open', 'pedit')
    nnoremap <silent> <buffer> <expr> nd defx#do_action('new_directory')
    nnoremap <silent> <buffer> <expr> nf defx#do_action('new_file')
    nnoremap <silent> <buffer> <expr> df defx#do_action('remove')
    nnoremap <silent> <buffer> <expr> rn defx#do_action('rename')
    nnoremap <silent> <buffer> <expr> X defx#do_action('execute_system')
    nnoremap <silent> <buffer> <expr> . defx#do_action('toggle_ignored_files')
    nnoremap <silent> <buffer> <expr> h defx#do_action('cd', ['..'])
    nnoremap <silent> <buffer> <expr> <Space>h defx#do_action('cd')
    nnoremap <silent> <buffer> <expr> q defx#do_action('quit')
    nnoremap <silent> <buffer> <expr> sm defx#do_action('toggle_select') . 'j'
    nnoremap <silent> <buffer> <expr> sa defx#do_action('toggle_select_all')
    nnoremap <silent> <buffer> <expr> j line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent> <buffer> <expr> k line('.') == 1 ? 'G' : 'k'
    nnoremap <silent> <buffer> <expr> <Space>rl defx#do_action('redraw')
    nnoremap <silent> <buffer> <expr> [exec]d defx#do_action('quit')
endfunction
