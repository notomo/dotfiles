

" tab drop
let action = {
\   'description' : 'tab drop',
\   'is_selectable' : 1,
\ }
function! action.func(candidates)"{{{
    for l:candidate in a:candidates
        call unite#util#smart_execute_command('tab drop', l:candidate.action__path)
    endfor
endfunction"}}}
call unite#custom_action('openable', 'tab-drop', action)
unlet action

"unite general settings
call unite#custom_default_action('file', 'tab-drop')

" let g:unite_source_line_enable_highlight = 1
"インサートモードで開始
let g:unite_enable_start_insert = 1

"最近開いたファイル履歴の保存数
let g:unite_source_file_mru_limit = 300

"file_mruの表示フォーマットを指定。空にすると表示スピードが高速化される
let g:unite_source_file_mru_filename_format = ''

" let g:neomru#do_validate=0

let g:unite_source_find_command = 'C:/Program Files/Git/usr/bin/find.exe'
let g:unite_source_file_async_command = 'C:/Program Files/Git/usr/bin/find.exe'
" let g:unite_source_find_command = 'C:/MinGW64/msys/1.0/bin/find.exe'
let g:unite_source_grep_encoding = 'utf-8'
if executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
endif
