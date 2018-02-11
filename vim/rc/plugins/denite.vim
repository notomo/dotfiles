nnoremap [denite] <Nop>
nmap <Space>d [denite]

if has('win32')
    nnoremap <silent> [unite]r :<C-u>Denite file_mru<CR>
    xnoremap <silent> [unite]r :<C-u>Denite file_mru<CR>
else
    nnoremap <silent> [unite]r :<C-u>Denite file_mru dir_file<CR>
    xnoremap <silent> [unite]r :<C-u>Denite file_mru dir_file<CR>
endif
nnoremap <silent> [denite]l :<C-u>Denite line<CR>
nnoremap <silent> [denite]d :<C-u>Denite directory_mru<CR>
nnoremap <silent> [denite]b :<C-u>Denite buffer<CR>
nnoremap <silent> [unite]sf :<C-u>Denite file_rec<CR>
nnoremap <silent> [unite]sg :<C-u>DeniteProjectDir file_rec<CR>
nnoremap <silent> [denite]f :<C-u>Denite dir_file -no-empty<CR>
nnoremap <silent> [denite]o :<C-u>Denite outline -auto-preview -no-empty<CR>
nnoremap <silent> [denite]c :<C-u>Denite change -auto-preview -no-empty<CR>
nnoremap <silent> [denite]; :<C-u>Denite command -no-empty<CR>
nnoremap <silent> [denite]q :<C-u>Denite command_history<CR>
nnoremap <silent> [denite]J :<C-u>Denite jump -auto-preview -no-empty<CR>
nnoremap <silent> [denite]ta :<C-u>Denite tag -no-empty<CR>
nnoremap <silent> [keyword]O :<C-u>DeniteCursorWord tag -auto-preview -no-empty -immediately-1<CR>
nnoremap <silent> [keyword]V :<C-u>DeniteCursorWord tag -default-action=vsplit -auto-preview -no-empty -immediately-1<CR>
nnoremap <silent> [keyword]H :<C-u>DeniteCursorWord tag -default-action=split -auto-preview -no-empty -immediately-1<CR>
nnoremap <silent> [keyword]T :<C-u>DeniteCursorWord tag -default-action=tabopen -auto-preview -no-empty -immediately-1<CR>
nnoremap <silent> [denite]k :<C-u>DeniteCursorWord tag -immediately -no-empty<CR>
nnoremap <silent> [denite]n :<C-u>Denite -resume -cursor-pos=+1 -immediately<CR>
nnoremap <silent> [denite]N :<C-u>Denite -resume -cursor-pos=-1 -immediately<CR>
nnoremap <silent> [denite]<CR> :<C-u>Denite -resume<CR>
nnoremap <silent> [denite]gl :<C-u>Denite grep -no-empty -immediately-1<CR>
nnoremap <silent> [denite]gg :<C-u>DeniteProjectDir grep -no-empty -immediately-1<CR>
nnoremap <silent> [denite]to :<C-u>DeniteCursorWord outline -auto-preview -no-empty -immediately-1<CR>
nnoremap <silent> [denite]h :<C-u>Denite help -default-action=open<CR>
nnoremap <silent> [denite]th :<C-u>DeniteCursorWord help -no-empty -immediately-1<CR>
nnoremap <silent> [denite]u :<C-u>Denite file_mru -immediately<CR>
nnoremap <silent> [unite]d :<C-u>Denite file_mru -immediately<CR>
nnoremap <silent> [denite]v :<C-u>cd ~/dotfiles<CR>:<C-u>DeniteProjectDir file_rec<CR>
nnoremap <silent> [denite]D :<C-u>Denite grep:~/dotfiles::!<CR>
nnoremap <silent> [denite]F :<C-u>Denite grep:::!<CR>
nnoremap <silent> [denite]G :<C-u>DeniteProjectDir grep:::!<CR>
nnoremap <silent> [denite]p :<C-u>Denite dein<CR>
nnoremap <silent> [denite]tb :<C-u>Denite tabwin<CR>
nnoremap <silent> [denite]U :<C-u>Denite namespace<CR>
nnoremap <silent> [denite]P :<C-u>call notomo#denite#add_php_use_statement()<CR>
nnoremap <expr> <silent> [denite]M notomo#denite#get_php_method_command()
nnoremap <silent> [denite]O :<C-u>Denite option<CR>
nnoremap <silent> [denite]L :<C-u>Denite dein_log<CR>
nnoremap <silent> [denite]A :<C-u>Denite alias<CR>
nnoremap <silent> [denite]B :<C-u>Denite url_bookmark<CR>
nnoremap <expr> <silent> [keyword]sg ":\<C-u>DeniteProjectDir file_rec -no-empty -immediately-1 -input=" . expand('<cword>') . "\<CR>"
nnoremap <expr> <silent> [keyword]sf ":\<C-u>DeniteBufferDir file_rec -no-empty -immediately-1 -input=" . expand('<cword>') . "\<CR>"
nnoremap <expr> <silent> [keyword]so ":\<C-u>DeniteBufferDir outline -no-empty -immediately-1 -input=" . expand('<cword>') . "\<CR>"
nnoremap <expr> <silent> [keyword]gg ":\<C-u>DeniteProjectDir grep -no-empty -immediately-1 -input=" . expand('<cword>') . "\<CR>"
nnoremap <expr> <silent> [keyword]gl ":\<C-u>DeniteBufferDir grep -no-empty -immediately-1 -input=" . expand('<cword>') . "\<CR>"
nnoremap <silent> [denite]c :<C-u>Denite completion<CR>
nnoremap <silent> [denite]s :<C-u>Denite denite_source<CR>

call denite#custom#option('default', 'use_default_mappings', 'false')

highlight myDeniteMatchText cterm=NONE guifg=#f6a3a3 guibg=NONE
highlight myDeniteInsert cterm=NONE guifg=NONE guibg=#3d5066
highlight myDeniteNormal cterm=NONE guifg=White guibg=#7b6980

call denite#custom#option('default', 'highlight_matched_char', 'myDeniteMatchText')
call denite#custom#option('default', 'highlight_mode_insert', 'myDeniteInsert')
call denite#custom#option('default', 'highlight_mode_normal', 'myDeniteNormal')
call denite#custom#option('default', 'highlight_matched_range', 'myDeniteMatchText')
call denite#custom#option('default', 'split', 'tab')
call denite#custom#option('default', 'no_empty', v:true)
call denite#custom#option('default', 'vertical_preview', v:true)
call denite#custom#option('default', 'highlight_preview_line', 'Search')
call denite#custom#option('default', 'smartcase', v:true)
call denite#custom#option('default', 'statusline', v:false)
call denite#custom#source('_', 'matchers', ['matcher_substring'])
call denite#custom#source('completion', 'matchers', [])
call denite#custom#source('directory_mru', 'sorters', ['sorter_length'])
call denite#custom#source('decls', 'sorters', ['sorter_line_number', 'sorter_file_path'])
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs', ['.git/', '__pycache__/'])
call denite#custom#source('file_rec', 'matchers', ['matcher_substring', 'matcher_ignore_globs'])
call denite#custom#source('grep', 'matchers', ['matcher_substring', 'matcher_ignore_globs'])

call denite#custom#map('_', '<CR>', '<denite:do_action:default>', 'noremap')
call denite#custom#map('_', '<Tab>', '<denite:choose_action>', 'noremap')

let s:LHS_KEY = notomo#mapping#get_lhs_key()
let s:RHS_KEY = notomo#mapping#get_rhs_key()
for s:info in notomo#mapping#main_input()
    call denite#custom#map('insert', s:info[s:LHS_KEY], s:info[s:RHS_KEY], 'noremap')
endfor
for s:info in notomo#mapping#sub_input()
    call denite#custom#map('insert', s:info[s:LHS_KEY], s:info[s:RHS_KEY], 'noremap')
endfor

call denite#custom#map('insert', '<BS>', '<denite:move_caret_to_left>', 'noremap')
call denite#custom#map('insert', '<C-h>', '<denite:move_caret_to_left>', 'noremap')
call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<C-l>', '<denite:move_caret_to_right>', 'noremap')
call denite#custom#map('insert', '<C-b>', '<denite:delete_char_before_caret>', 'noremap')
call denite#custom#map('insert', '<C-d>', '<denite:delete_char_after_caret>', 'noremap')
call denite#custom#map('insert', 'jj', '<denite:enter_mode:normal>', 'noremap')
call denite#custom#map('insert', 'jq', '<denite:quit>', 'noremap')
call denite#custom#map('insert', '<C-u>', '<denite:delete_text_before_caret>', 'noremap')
call denite#custom#map('insert', '<C-n>', '<denite:assign_next_matched_text>', 'noremap')
call denite#custom#map('insert', '<C-p>', '<denite:assign_previous_matched_text>', 'noremap')
call denite#custom#map('insert', 'j<Space>h', '<denite:paste_from_default_register>', 'noremap')
call denite#custom#map('insert', 'j<Space>v', '<denite:insert_special>', 'noremap')

call denite#custom#map('normal', 'q', '<denite:quit>', 'noremap')
call denite#custom#map('normal', 'gg', '<denite:move_to_first_line>', 'noremap')
call denite#custom#map('normal', 'G', '<denite:move_to_last_line>', 'noremap')
call denite#custom#map('normal', 'i', '<denite:enter_mode:insert>', 'noremap')
call denite#custom#map('normal', 'I', '<denite:insert_to_head>', 'noremap')
call denite#custom#map('normal', 'a', '<denite:append>', 'noremap')
call denite#custom#map('normal', 'A', '<denite:append_to_line>', 'noremap')
call denite#custom#map('normal', 'h', '<denite:move_caret_to_left>', 'noremap')
call denite#custom#map('normal', 'j', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('normal', 'k', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('normal', 'l', '<denite:move_caret_to_right>', 'noremap')
call denite#custom#map('normal', 'b', '<denite:move_caret_to_one_word_left>', 'noremap')
call denite#custom#map('normal', 'w', '<denite:move_caret_to_next_word>', 'noremap')
call denite#custom#map('normal', 'e', '<denite:move_caret_to_end_of_word>', 'noremap')
call denite#custom#map('normal', 'ga', '<denite:move_caret_to_head>', 'noremap')
call denite#custom#map('normal', 'ge', '<denite:move_caret_to_tail>', 'noremap')
call denite#custom#map('normal', 'cc', '<denite:change_line>', 'noremap')
call denite#custom#map('normal', 'dd', '<denite:delete_entire_text>', 'noremap')
call denite#custom#map('normal', 'D', '<denite:delete_text_after_caret>', 'noremap')
call denite#custom#map('normal', 'x', '<denite:delete_char_under_caret>', 'noremap')
call denite#custom#map('normal', 'sm', '<denite:toggle_select_down>', 'noremap')
call denite#custom#map('normal', 'sa', '<denite:toggle_select_all>', 'noremap')
call denite#custom#map('normal', 'yy', '<denite:do_action:yank>', 'noremap')
call denite#custom#map('normal', 'p', '<denite:paste_from_default_register>', 'noremap')
call denite#custom#map('normal', 'v', '<denite:do_action:preview>', 'noremap')
call denite#custom#map('normal', 'o', '<denite:do_action:open>', 'noremap')
call denite#custom#map('normal', 'uo', '<denite:do_action:outline>', 'noremap')
call denite#custom#map('normal', 'sv', '<denite:do_action:vsplit>', 'noremap')
call denite#custom#map('normal', 'sh', '<denite:do_action:split>', 'noremap')
call denite#custom#map('normal', 'fo', '<denite:do_action:vimfiler>', 'noremap')
call denite#custom#map('normal', 'fl', '<denite:do_action:tabvimfiler>', 'noremap')
call denite#custom#map('normal', '<Leader>rn', '<denite:do_action:exrename>', 'noremap')
call denite#custom#map('normal', '<Leader>rp', '<denite:do_action:qfreplace>', 'noremap')
call denite#custom#map('normal', 't<Space>', '<denite:do_action:tabopen>', 'noremap')
call denite#custom#map('normal', '<C-l>', '<denite:redraw>', 'noremap')
call denite#custom#map('normal', 'rr', '<denite:restart>', 'noremap')
call denite#custom#map('normal', 'ff', '<denite:do_action:dir_file>', 'noremap')
call denite#custom#map('normal', 'fa', '<denite:do_action:parent_dir_file>', 'noremap')
call denite#custom#map('normal', 'tmp', '<denite:toggle_matchers:matcher_path>', 'noremap')
call denite#custom#map('normal', 'tmip', '<denite:toggle_matchers:matcher_ignore_path>', 'noremap')
call denite#custom#map('normal', 'tmiw', '<denite:toggle_matchers:matcher_ignore_word>', 'noremap')
call denite#custom#map('normal', 'tsr', '<denite:toggle_sorters:sorter_reverse>', 'noremap')
call denite#custom#map('normal', 'tsl', '<denite:toggle_sorters:sorter_length>', 'noremap')
call denite#custom#map('normal', 'mh', '<denite:wincmd:h>', 'noremap')
call denite#custom#map('normal', 'ml', '<denite:wincmd:l>', 'noremap')
call denite#custom#map('normal', 'ud', '<denite:do_action:source_directory_mru>', 'noremap')
call denite#custom#map('normal', 'ur', '<denite:do_action:source_file_mru>', 'noremap')
call denite#custom#map('normal', 'uf', '<denite:do_action:source_dir_file>', 'noremap')
call denite#custom#map('normal', 'uv', '<denite:do_action:dotfiles>', 'noremap')
call denite#custom#map('normal', 'ug', '<denite:do_action:project_dir>', 'noremap')
call denite#custom#map('normal', '<C-j>', '<denite:scroll_page_forwards>', 'noremap')
call denite#custom#map('normal', '<C-k>', '<denite:scroll_page_backwards>', 'noremap')
call denite#custom#map('normal', 'J', '<denite:jump_to_next_source>', 'noremap')
call denite#custom#map('normal', 'K', '<denite:jump_to_previous_source>', 'noremap')
call denite#custom#map('normal', 'dll', '<denite:do_action:delete_line>', 'noremap')
call denite#custom#map('normal', 'dlL', '<denite:do_action:delete_others_line>', 'noremap')
call denite#custom#map('normal', 'sg', '<denite:do_action:project_dir_file_rec>', 'noremap')
call denite#custom#map('normal', 'sf', '<denite:do_action:dir_file_rec>', 'noremap')
call denite#custom#map('normal', 'sG', '<denite:do_action:project_dir_grep>', 'noremap')
call denite#custom#map('normal', 'sF', '<denite:do_action:dir_file_grep>', 'noremap')
call denite#custom#map('normal', '<Space>d', '<denite:do_action:grep_plugin_setting>', 'noremap')
call denite#custom#map('normal', '<Space>m', '<denite:quick_move>', 'noremap')
call denite#custom#map('normal', 'un', '<denite:do_action:unmap>', 'noremap')
call denite#custom#map('normal', '<Space>D', '<denite:do_action:debug_targets>', 'noremap')

call denite#custom#var('grep', 'command', ['pt'])
call denite#custom#var('grep', 'default_opts', ['--nogroup', '--nocolor', '--smart-case', '--ignore=tags', '--hidden'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

call denite#custom#var('file_rec', 'command', ['pt', '--follow', '--nocolor', '--nogroup', '--hidden', '--ignore=.git', (has('win32') ? '-g:' : '-g='), ''])

call denite#custom#var('outline', 'ignore_types', ['v'])

call denite#custom#action('command', 'open', {context -> notomo#denite#open_command(context)})
call denite#custom#action('unite', 'open', {context -> notomo#denite#execute_unite_action(context, 'open')})
call denite#custom#action('unite', 'vimfiler', {context -> notomo#denite#execute_unite_action(context, 'vimfiler')})
call denite#custom#action('unite', 'tabvimfiler', {context -> notomo#denite#execute_unite_action(context, 'tabvimfiler')})
call denite#custom#action('unite', 'exrename', {context -> notomo#denite#execute_unite_action(context, 'exrename')})
call denite#custom#action('unite', 'qfreplace', {context -> notomo#denite#execute_unite_action(context, 'replace')})

call denite#custom#action('directory', 'dir_file', {context -> notomo#denite#dir_file_on_directory(context)})
call denite#custom#action('file', 'dir_file', {context -> notomo#denite#dir_file_on_file(context)})
call denite#custom#action('file,directory', 'parent_dir_file', {context -> notomo#denite#parent_dir_file(context)})

call denite#custom#action('directory', 'tabopen', {context ->  notomo#denite#open('tabnew', context)})
call denite#custom#action('directory', 'vsplit', {context ->  notomo#denite#open('vsplit', context)})
call denite#custom#action('directory', 'split', {context ->  notomo#denite#open('split', context)})

call denite#custom#action('file', 'qfreplace', {context ->  notomo#denite#qfreplace(context)})
call denite#custom#action('file,directory', 'exrename', {context ->  notomo#denite#exrename(context)})

call denite#custom#action('file,directory', 'vimfiler', {context ->  notomo#denite#directory_open('', context)})
call denite#custom#action('file,directory', 'tabvimfiler', {context ->  notomo#denite#directory_open('tabnew', context)})

call denite#custom#action('file', 'outline', {context ->  notomo#denite#outline(context)})

call denite#custom#action('file,directory', 'source_directory_mru', {context ->  notomo#denite#change_source('directory_mru', context)})
call denite#custom#action('file,directory', 'source_file_mru', {context ->  notomo#denite#change_source('file_mru', context)})
call denite#custom#action('file,directory', 'source_dir_file', {context ->  notomo#denite#change_source('dir_file', context)})

call denite#custom#action('file', 'delete_line', {context ->  notomo#denite#delete_line(context)})
call denite#custom#action('file', 'delete_others_line', {context ->  notomo#denite#delete_others_line(context)})

call denite#custom#action('file', 'project_dir_file_rec', {context ->  notomo#denite#project_dir_file_rec_on_file(context)})
call denite#custom#action('directory', 'project_dir_file_rec', {context ->  notomo#denite#project_dir_file_rec(context)})

call denite#custom#action('file', 'dir_file_rec', {context ->  notomo#denite#dir_file_rec_on_file(context)})
call denite#custom#action('directory', 'dir_file_rec', {context ->  notomo#denite#dir_file_rec(context)})

call denite#custom#action('file', 'project_dir_grep', {context ->  notomo#denite#project_dir_grep_on_file(context)})
call denite#custom#action('directory', 'project_dir_grep', {context ->  notomo#denite#project_dir_grep(context)})

call denite#custom#action('file', 'dir_file_grep', {context ->  notomo#denite#dir_file_grep_on_file(context)})
call denite#custom#action('directory', 'dir_file_grep', {context ->  notomo#denite#dir_file_grep(context)})

call denite#custom#action('file', 'dotfiles', {context ->  notomo#denite#project_dir_by_path('~/dotfiles', context)})

call denite#custom#action('directory', 'grep_plugin_setting', {context ->  notomo#denite#grep_plugin_setting(context)})

call denite#custom#action('keymap', 'open', {context ->  denite#do_action(context, 'execute', context['targets'])})

call denite#custom#action('buffer,command,directory,file,openable,word,namespace', 'debug_targets', {context ->  notomo#denite#debug_targets(context)})

call denite#custom#action('namespace', 'use', {context ->  notomo#denite#append_with(context, 'use ', ';')})

call denite#custom#action('tabwin', 'open', {context ->  denite#do_action(context, 'switch', context['targets'])})

call denite#custom#action('file', 'project_dir', {context ->  notomo#denite#project_dir(context)})

call denite#custom#action('completion', 'open', {context ->  denite#do_action(context, 'append_and_execute', context['targets'])})
