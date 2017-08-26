nnoremap [unite] <Nop>
nmap <Space>u [unite]

nnoremap <silent> [unite]n :<C-u>UniteNext<CR>
nnoremap <silent> [unite]N :<C-u>UnitePrevious<CR>
nnoremap [unite]F :<C-u>UniteWithBufferDir -buffer-name=files file -input=
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir file_rec<CR>
nnoremap <silent> [unite]p :<C-u>Unite bookmark<CR>
nnoremap <silent> [unite]<Space> :<C-u>UniteBookmarkAdd<CR>
nnoremap <silent> [unite]ta :<C-u>Unite tab:no-current<CR>
nnoremap <silent> [unite]mp :<C-u>Unite mapping<CR>
nnoremap <silent> [unite]R :<C-u>Unite runtimepath<CR>
nnoremap <silent> [unite]<CR> :<C-u>UniteResume<CR>
nnoremap <silent> [unite]gg  :<C-u>call <SID>unite_grep()<CR>
function! s:unite_grep() abort
    let pattern = input('Pattern : ')
    if pattern ==? ''
        echomsg 'Canceled'
        return
    endif
    execute "normal! :Unite -tab -no-quit grep:. -buffer-name=GREP\<CR>" . pattern . "\<CR>"
endfunction

" tab_drop
let s:tab_drop = {
\   'description' : 'tab drop',
\   'is_selectable' : 1,
\ }
function! s:tab_drop.func(candidates)
    for l:candidate in a:candidates
        call unite#util#smart_execute_command('tab drop', l:candidate.action__path)
    endfor
endfunction
call unite#custom_action('openable', 'tab_drop', s:tab_drop)
unlet s:tab_drop

" parent_file
let s:parent_file = {'is_selectable' : 0}
function! s:parent_file.func(candidate)
    execute 'Unite file:' . fnamemodify(a:candidate['action__path'], ':h:h')
endfunction
call unite#custom_action('openable', 'parent_file', s:parent_file)
unlet s:parent_file

call unite#custom#profile('default', 'context', {
\   'no_split' : 1,
\   'start_insert' : 1
\ })

let g:unite_no_default_keymappings = 1
let g:unite_enable_auto_select = 0

let g:unite_source_grep_encoding = 'utf-8'
let g:unite_source_file_async_command = 'ls -ar'
if executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --smart-case'
  let g:unite_source_grep_recursive_opt = ''
endif

call unite#custom#source('file_mru', 'ignore_pattern', '\v^(gina|gita)')

call unite#custom#source('file', 'matchers', 'matcher_default')

call unite#custom#source('directory_mru', 'sorters', ['sorter_length'])

function! s:change_source(source_name) abort
    execute 'Unite ' . a:source_name . ' -no-start-insert -input=' . join(split(getline(1), ' '), '\ ')
endfunction

autocmd MyAuGroup FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
    imap <buffer> jq <Plug>(unite_exit)
    imap <buffer> jj <Plug>(unite_insert_leave)
    nnoremap <silent> <buffer> <expr> o unite#do_action('open')
    nnoremap <silent> <buffer> <expr> T unite#do_action('tab_drop')
    nnoremap <silent> <buffer> <expr> t<Space> unite#do_action('tabopen')
    vmap <buffer> sm <Plug>(unite_toggle_mark_selected_candidates)
    nmap <buffer> sm <Plug>(unite_toggle_mark_current_candidate)

    nnoremap <silent> <buffer> <expr> sh unite#do_action('split')
    nnoremap <silent> <buffer> <expr> sv unite#do_action('vsplit')
    nnoremap <silent> <buffer> <expr> fl unite#do_action('tabvimfiler')
    nnoremap <silent> <buffer> <expr> fo unite#do_action('vimfiler')
    nnoremap <silent> <buffer> <expr> ff unite#do_action('file')
    nnoremap <silent> <buffer> <expr> fp unite#do_action('parent_file')
    nnoremap <silent> <buffer> <expr> <Leader>rp unite#do_action('replace')
    nnoremap <silent> <buffer> <expr> <Leader>rn unite#do_action('exrename')
    nnoremap <silent> <buffer> uf :call <SID>change_source('file')<CR>
    nnoremap <silent> <buffer> ub :call <SID>change_source('buffer')<CR>
    nnoremap <silent> <buffer> ur :call <SID>change_source('neomru/file')<CR>
    nnoremap <silent> <buffer> ud :call <SID>change_source('neomru/directory')<CR>
    nnoremap <silent> <buffer> ut :call <SID>change_source('tab')<CR>

    nmap <buffer> i <Plug>(unite_insert_enter)
    nmap <buffer> a gg<Plug>(unite_insert_enter)
    nmap <buffer> I <Plug>(unite_insert_head)
    nmap <buffer> A <Plug>(unite_append_end)
    nmap <buffer> q <Plug>(unite_exit)
    nmap <buffer> <C-r> <Plug>(unite_restart)
    nmap <buffer> * <Plug>(unite_toggle_mark_all_candidates)
    nmap <buffer> <Tab> <Plug>(unite_choose_action)
    nmap <buffer> <C-l> <Plug>(unite_redraw)
    nmap <buffer> j <Plug>(unite_loop_cursor_down)
    nmap <buffer> k <Plug>(unite_loop_cursor_up)
    nmap <buffer> <2-LeftMouse> <Plug>(unite_do_default_action)
    nmap <buffer> <RightMouse> <Plug>(unite_exit)
    nmap <buffer> p <Plug>(unite_smart_preview)
    nmap <buffer> <CR> <Plug>(unite_do_default_action)
    nmap <buffer> gg <Plug>(unite_cursor_top)
    nmap <buffer> G <Plug>(unite_cursor_bottom)

    imap <buffer> <C-u> <Plug>(unite_delete_backward_line)
    imap <buffer> <CR> <Plug>(unite_do_default_action)
    imap <buffer> <C-n> <Plug>(unite_select_next_page)
    imap <buffer> <C-p> <Plug>(unite_select_previous_page)
    imap <buffer> <2-LeftMouse> <Plug>(unite_do_default_action)
    imap <buffer> <RightMouse> <Plug>(unite_exit)
    imap <buffer> <C-b> <Plug>(unite_delete_backward_char)
    imap <buffer> <C-N> <Plug>(unite_narrowing_input_history)
endfunction

