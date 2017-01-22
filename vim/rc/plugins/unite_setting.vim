
" tab drop
let action = {
\   'description' : 'tab drop',
\   'is_selectable' : 1,
\ }
function! action.func(candidates)
    for l:candidate in a:candidates
        call unite#util#smart_execute_command('tab drop', l:candidate.action__path)
    endfor
endfunction
call unite#custom_action('openable', 'tab-drop', action)
unlet action

call unite#custom_default_action('file', 'tab-drop')
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

