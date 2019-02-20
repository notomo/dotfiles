nnoremap <silent> [exec]f :<C-u>Defx `expand('%:p:h')` -toggle -search=`expand('%:p')` -split=vertical -winwidth=38<CR>

call defx#custom#option('_', {
    \ 'show_ignored_files' : v:true,
    \ 'auto_cd' : v:true,
\ })

autocmd MyAuGroup FileType defx call s:settings()
function! s:settings() abort
    setlocal nonumber
    setlocal sidescrolloff=0
    nnoremap <silent> <buffer> <expr> <CR> defx#do_action('open')
    nnoremap <silent> <buffer> <expr> t<Space> defx#do_action('call', "<SID>tabopen")
    nnoremap <silent> <buffer> <expr> o defx#do_action('open')
    nnoremap <silent> <buffer> <expr> yf defx#do_action('copy')
    nnoremap <silent> <buffer> <expr> xf defx#do_action('move')
    nnoremap <silent> <buffer> <expr> p defx#do_action('paste')
    nnoremap <silent> <buffer> <expr> l defx#do_action('drop')
    nnoremap <silent> <buffer> <expr> sh defx#do_action('call', "<SID>hsplit")
    nnoremap <silent> <buffer> <expr> sv defx#do_action('call', "<SID>vsplit")
    nnoremap <silent> <buffer> <expr> P defx#do_action('open', 'pedit')
    nnoremap <silent> <buffer> <expr> nd defx#do_action('new_directory')
    nnoremap <silent> <buffer> <expr> nf defx#do_action('new_file')
    nnoremap <silent> <buffer> <expr> df defx#do_action('remove')
    nnoremap <silent> <buffer> <expr> rn defx#do_action('call', "<SID>rename")
    nnoremap <silent> <buffer> <expr> X defx#do_action('execute_system')
    nnoremap <silent> <buffer> <expr> . defx#do_action('toggle_ignored_files')
    nnoremap <silent> <buffer> <expr> h defx#do_action('cd', ['..'])
    nnoremap <silent> <buffer> <expr> <Space>h defx#do_action('cd')
    nnoremap <silent> <buffer> <expr> <Space>g defx#do_action('cd', [fnamemodify(notomo#vimrc#search_parent_recursive('.git', getcwd()), ':h:h')])
    nnoremap <silent> <buffer> <expr> q defx#do_action('quit')
    nnoremap <silent> <buffer> <expr> sm defx#do_action('toggle_select') . 'j'
    nnoremap <silent> <buffer> <expr> sa defx#do_action('toggle_select_all')
    nnoremap <silent> <buffer> <expr> j line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent> <buffer> <expr> k line('.') == 1 ? 'G' : 'k'
    nnoremap <silent> <buffer> <expr> <Space>rl defx#do_action('redraw')
    nnoremap <silent> <buffer> <expr> <2-LeftMouse> defx#do_action('call', "<SID>smart_open")
endfunction

function! s:smart_open(context) abort
    let line_num = line('.')
    let line = trim(getline(line_num))
    let path = expand(split(line, ' ')[-1])
    if line_num == 1
        let path = fnamemodify(path, ':h:h')
    endif

    if !isdirectory(path) && !filereadable(path)
        return
    endif

    if isdirectory(path)
        call defx#call_action('cd', [path])
        return
    endif

    call defx#call_action('drop')
endfunction

function! s:vsplit(context) abort
    quit
    for path in a:context['targets']
        execute 'vsplit ' . path
    endfor
endfunction

function! s:hsplit(context) abort
    quit
    for path in a:context['targets']
        execute 'split ' . path
    endfor
endfunction

function! s:tabopen(context) abort
    quit
    for path in a:context['targets']
        if isdirectory(expand(path))
            call s:defx_open('tabnew', path)
            continue
        endif
        execute 'tabedit ' . path
    endfor
endfunction

function! s:defx_open(cmd, path) abort
    execute a:cmd
    execute 'cd ' . a:path
    Defx -new
endfunction

function! s:rename(context) abort
    let candidates = []
    for path in a:context['targets']
        call add(candidates, {'action__path': path})
    endfor
    tabnew
    call defx#exrename#create_buffer(candidates)
    only
endfunction
