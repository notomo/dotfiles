
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

call unite#custom_default_action('file', 'tab_drop')
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
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
endif

call unite#custom#source('file_mru', 'ignore_pattern', '\v^(gina|gita)')

call unite#custom#source('file', 'matchers', 'matcher_default')

call unite#custom#source('file', 'sorters', ['sorter_length'])
call unite#custom#source('file_mru', 'sorters', ['sorter_length'])
call unite#custom#source('directory_mru', 'sorters', ['sorter_length'])
