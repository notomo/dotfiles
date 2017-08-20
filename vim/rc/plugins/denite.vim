nnoremap [denite] <Nop>
nmap <Space>d [denite]

nnoremap <silent> [unite]r :<C-u>Denite file_mru directory_mru dir_file<CR>
nnoremap <silent> [denite]l :<C-u>Denite line -auto-preview<CR>
nnoremap <silent> [denite]d :<C-u>Denite directory_mru<CR>
nnoremap <silent> [denite]b :<C-u>Denite buffer<CR>
nnoremap <silent> [denite]sf :<C-u>DeniteBufferDir -auto-preview file_rec<CR>
nnoremap <silent> [denite]sg :<C-u>DeniteProjectDir -auto-preview file_rec<CR>
nnoremap <silent> [denite]f :<C-u>DeniteBufferDir dir_file -no-empty<CR>
nnoremap <silent> [denite]o :<C-u>Denite outline -auto-preview -no-empty<CR>
nnoremap <silent> [denite]c :<C-u>Denite change -auto-preview -no-empty<CR>
nnoremap <silent> [denite]J :<C-u>Denite jump -auto-preview -no-empty<CR>
nnoremap <silent> [denite]ta :<C-u>Denite tag -auto-preview -no-empty<CR>
nnoremap <silent> [denite]tk :<C-u>DeniteCursorWord tag -auto-preview -no-empty -immediately-1<CR>
nnoremap <silent> [denite]k :<C-u>DeniteCursorWord tag -immediately -no-empty<CR>
nnoremap <silent> [denite]n :<C-u>Denite -resume -cursor-pos=+1 -immediately<CR>
nnoremap <silent> [denite]N :<C-u>Denite -resume -cursor-pos=-1 -immediately<CR>
nnoremap <silent> [denite]<CR> :<C-u>Denite -resume<CR>
nnoremap <silent> [denite]gl :<C-u>Denite grep -auto-preview -no-empty -immediately-1<CR>
nnoremap <silent> [denite]gg :<C-u>DeniteProjectDir grep -auto-preview -no-empty -immediately-1<CR>
nnoremap <silent> [denite]to :<C-u>DeniteCursorWord outline -auto-preview -no-empty -immediately-1<CR>
nnoremap <silent> [denite]h :<C-u>Denite help<CR>
nnoremap <silent> [denite]th :<C-u>DeniteCursorWord help -no-empty -immediately-1<CR>
nnoremap <silent> [denite]u :<C-u>Denite file_mru -immediately<CR>

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
call denite#custom#source('_', 'matchers', ['matcher_substring'])
call denite#custom#source('directory_mru', 'sorters', ['sorter_length'])
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs', ['.git/', '__pycache__/'])
call denite#custom#source('file_rec', 'matchers', ['matcher_substring', 'matcher_ignore_globs'])

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
call denite#custom#map('normal', 'ss', '<denite:toggle_select_all>', 'noremap')
call denite#custom#map('normal', 'yy', '<denite:yank_to_default_register>', 'noremap')
call denite#custom#map('normal', 'p', '<denite:paste_from_default_register>', 'noremap')
call denite#custom#map('normal', 'v', '<denite:do_action:preview>', 'noremap')
call denite#custom#map('normal', 'o', '<denite:do_action:open>', 'noremap')
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
call denite#custom#map('normal', 'tmip', '<denite:toggle_matchers:matcher_ignore_path>', 'noremap')
call denite#custom#map('normal', 'tmiw', '<denite:toggle_matchers:matcher_ignore_word>', 'noremap')
call denite#custom#map('normal', 'tsr', '<denite:toggle_sorters:sorter_reverse>', 'noremap')
call denite#custom#map('normal', 'tsl', '<denite:toggle_sorters:sorter_length>', 'noremap')
call denite#custom#map('normal', 'mh', '<denite:wincmd:h>', 'noremap')
call denite#custom#map('normal', 'ml', '<denite:wincmd:l>', 'noremap')

call denite#custom#var('grep', 'command', ['pt'])
call denite#custom#var('grep', 'default_opts', ['--nogroup', '--nocolor', '--smart-case', '--ignore=tags'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

call denite#custom#action('command', 'open', {context -> denite#do_action(context, 'execute', context['targets'])})
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
