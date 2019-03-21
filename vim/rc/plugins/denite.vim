nnoremap [denite] <Nop>
nmap <Space>d [denite]

if has('win32')
    nnoremap <silent> <Space>ur :<C-u>Denite file_mru<CR>
    xnoremap <silent> <Space>ur :<C-u>Denite file_mru<CR>
else
    nnoremap <silent> <Space>ur :<C-u>DeniteProjectDir file_mru file/rec<CR>
    xnoremap <silent> <Space>ur :<C-u>DeniteProjectDir file_mru file/rec<CR>
endif
nnoremap <silent> [denite]y :<C-u>Denite file_bookmark<CR>
nnoremap <silent> [denite]l :<C-u>Denite line<CR>
nnoremap <silent> [denite]d :<C-u>Denite directory_mru<CR>
nnoremap <silent> [denite]r :<C-u>DeniteProjectDir directory_rec<CR>
nnoremap <silent> [denite]B :<C-u>Denite buffer<CR>
nnoremap <silent> <Space>usf :<C-u>Denite file/rec<CR>
nnoremap <silent> <Space>usg :<C-u>DeniteProjectDir file/rec<CR>
nnoremap <silent> [denite]f :<C-u>Denite dir_file -no-empty<CR>
nnoremap <silent> [denite]o :<C-u>Denite outline -no-empty<CR>
nnoremap <silent> [denite]; :<C-u>Denite command -no-empty<CR>
nnoremap <silent> [denite]n :<C-u>Denite -resume -cursor-pos=+1 -immediately<CR>
nnoremap <silent> [denite]N :<C-u>Denite -resume -cursor-pos=-1 -immediately<CR>
nnoremap <silent> [denite]<CR> :<C-u>Denite -resume<CR>
nnoremap <silent> [denite]gl :<C-u>Denite grep -no-empty -immediately-1<CR>
nnoremap <silent> [denite]gg :<C-u>DeniteProjectDir grep -no-empty -immediately-1<CR>

if has('nvim')
    nnoremap <silent> [denite]h :<C-u>Denite curstr/altr/help -default-action=open<CR>
else
    nnoremap <silent> [denite]h :<C-u>Denite help<CR>
endif

nnoremap <silent> [denite]u :<C-u>Denite file_mru -immediately<CR>
nnoremap <silent> <Space>ud :<C-u>Denite file_mru -immediately<CR>
nnoremap <silent> [denite]v :<C-u>cd ~/dotfiles<CR>:<C-u>DeniteProjectDir file/rec<CR>
nnoremap <silent> [denite]F :<C-u>Denite grep:::!<CR>
nnoremap <silent> [denite]G :<C-u>DeniteProjectDir grep:::!<CR>
nnoremap <silent> [denite]p :<C-u>Denite plugin<CR>
nnoremap <silent> [denite]O :<C-u>Denite option<CR>
nnoremap <silent> [denite]A :<C-u>Denite alias<CR>
nnoremap <silent> [denite]b :<C-u>Denite url_bookmark<CR>
nnoremap <silent> [denite]s :<C-u>Denite source<CR>
nnoremap <expr> <silent> [keyword]gg ":\<C-u>DeniteProjectDir grep:::" . expand('<cword>') . " -no-empty -immediately-1 \<CR>"
nnoremap <expr> <silent> [keyword]gl ":\<C-u>DeniteBufferDir grep:::" . expand('<cword>') . " -no-empty -immediately-1 \<CR>"
nnoremap <expr> <silent> [denite]M ':<C-u>Denite url_substitute_pattern:' . escape(expand('<cWORD>'), ':') . ' -no-empty <CR>'
nnoremap <silent> [denite]go :<C-u>Denite go/src<CR>
nnoremap <silent> [denite]gp :<C-u>Denite go/package<CR>
nnoremap <silent> [denite]gO :<C-u>call notomo#denite#go_project_decls()<CR>
nnoremap <silent> [denite]to :<C-u>Denite todo -immediately -default-action=tabopen<CR>
nnoremap <silent> [denite]ts :<C-u>Denite proto_dir:filetype -default-action=tabfiler -immediately-1<CR>
nnoremap <silent> [denite]tm :<C-u>Denite file/rec:~/workspace/memo<CR>
nnoremap <silent> [denite]ga :<C-u>Denite git/branch<CR>
nnoremap <silent> [denite]gA :<C-u>Denite git/branch:all<CR>

call denite#custom#option('default', 'use_default_mappings', 'false')

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
call denite#custom#source('_', 'matchers', ['matcher/regexp'])
call denite#custom#source('ctrlb/history/search', 'matchers', [])
call denite#custom#source('directory_mru', 'sorters', ['sorter_length'])
call denite#custom#source('decls', 'sorters', ['sorter_line_number', 'sorter_file_path'])
call denite#custom#filter('matcher/ignore_globs', 'ignore_globs', ['.git', '.mypy_cache/', '__pycache__/*', '__pycache__', '.mypy_cache', '.pytest_cache/', '.pytest_cache', '.DS_Store'])
call denite#custom#source('file/rec', 'matchers', ['matcher/regexp', 'matcher/ignore_globs'])
call denite#custom#source('directory_rec', 'matchers', ['matcher/regexp', 'matcher/ignore_globs'])
call denite#custom#source('grep', 'matchers', ['matcher/regexp', 'matcher/ignore_globs'])

call denite#custom#map('_', '<CR>', '<denite:do_action:default>', 'noremap')
call denite#custom#map('_', '<Tab>', '<denite:choose_action>', 'noremap')

let s:LHS_KEY = notomo#mapping#get_lhs_key()
let s:RHS_KEY = notomo#mapping#get_rhs_key()
for s:info in notomo#mapping#main_input()
    let s:rhs = substitute(s:info[s:RHS_KEY], '\v(..)\<Left\>', '<denite:multiple_mappings:denite:insert_word:\1,denite:move_caret_to_left>', '')
    call denite#custom#map('insert', s:info[s:LHS_KEY], s:rhs, 'noremap')
endfor
for s:info in notomo#mapping#sub_input()
    call denite#custom#map('insert', s:info[s:LHS_KEY], s:info[s:RHS_KEY], 'noremap')
endfor

call denite#custom#map('insert', '<BS>', '<denite:delete_char_before_caret>', 'noremap')
call denite#custom#map('insert', '<C-h>', '<denite:delete_char_before_caret>', 'noremap')
call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<C-f>', '<denite:move_caret_to_right>', 'noremap')
call denite#custom#map('insert', '<C-b>', '<denite:move_caret_to_left>', 'noremap')
call denite#custom#map('insert', '<C-d>', '<denite:delete_char_after_caret>', 'noremap')
call denite#custom#map('insert', 'jj', '<denite:enter_mode:normal>', 'noremap')
call denite#custom#map('insert', 'jq', '<denite:quit>', 'noremap')
call denite#custom#map('insert', '<C-u>', '<denite:delete_text_before_caret>', 'noremap')
call denite#custom#map('insert', '<C-n>', '<denite:assign_next_matched_text>', 'noremap')
call denite#custom#map('insert', '<C-p>', '<denite:assign_previous_matched_text>', 'noremap')
call denite#custom#map('insert', 'j<Space>h', '<denite:paste_from_default_register>', 'noremap')
call denite#custom#map('insert', 'j<Space>v', '<denite:insert_special>', 'noremap')
call denite#custom#map('insert', '<C-a>', '<denite:move_caret_to_head>', 'noremap')
call denite#custom#map('insert', '<C-e>', '<denite:move_caret_to_tail>', 'noremap')

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
call denite#custom#map('normal', 'sv', '<denite:do_action:vsplit>', 'noremap')
call denite#custom#map('normal', 'sh', '<denite:do_action:split>', 'noremap')
call denite#custom#map('normal', 'fo', '<denite:do_action:filer>', 'noremap')
call denite#custom#map('normal', 'fl', '<denite:do_action:tabfiler>', 'noremap')
call denite#custom#map('normal', '<Leader>rn', '<denite:do_action:exrename>', 'noremap')
call denite#custom#map('normal', '<Leader>rp', '<denite:do_action:qfreplace>', 'noremap')
call denite#custom#map('normal', 't<Space>', '<denite:do_action:tabopen>', 'noremap')
call denite#custom#map('normal', '<C-l>', '<denite:redraw>', 'noremap')
call denite#custom#map('normal', 'rr', '<denite:restart>', 'noremap')
call denite#custom#map('normal', 'ff', '<denite:do_action:dir_file>', 'noremap')
call denite#custom#map('normal', 'fa', '<denite:do_action:parent_dir_file>', 'noremap')
call denite#custom#map('normal', 'tmp', '<denite:toggle_matchers:matcher_path>', 'noremap')
call denite#custom#map('normal', 'tmip', '<denite:toggle_matchers:matcher_ignore_path>', 'noremap')
call denite#custom#map('normal', 'tsl', '<denite:change_sorters:sorter_length>', 'noremap')
call denite#custom#map('normal', 'mh', '<denite:wincmd:h>', 'noremap')
call denite#custom#map('normal', 'ml', '<denite:wincmd:l>', 'noremap')
call denite#custom#map('normal', 'M', '<denite:do_action:convert>', 'noremap')
call denite#custom#map('normal', '<C-j>', '<denite:scroll_page_forwards>', 'noremap')
call denite#custom#map('normal', '<C-k>', '<denite:scroll_page_backwards>', 'noremap')
call denite#custom#map('normal', 'J', '<denite:jump_to_next_source>', 'noremap')
call denite#custom#map('normal', 'K', '<denite:jump_to_previous_source>', 'noremap')
call denite#custom#map('normal', 'sg', '<denite:do_action:project_dir_file_rec>', 'noremap')
call denite#custom#map('normal', 'sf', '<denite:do_action:dir_file_rec>', 'noremap')
call denite#custom#map('normal', '<Space>d', '<denite:do_action:grep_plugin_setting>', 'noremap')
call denite#custom#map('normal', '<Space>m', '<denite:quick_move>', 'noremap')
call denite#custom#map('normal', '<Space>D', '<denite:do_action:debug_targets>', 'noremap')
call denite#custom#map('normal', 't<CR>', '<denite:do_action:activate>', 'noremap')
call denite#custom#map('normal', 'u', '<denite:restore_sources>', 'noremap')

call denite#custom#var('grep', 'command', ['pt'])
call denite#custom#var('grep', 'default_opts', ['--nogroup', '--nocolor', '--smart-case', '--ignore=.git', '--ignore=tags', '--hidden'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])
call denite#custom#var('file/rec', 'command', ['pt', '--follow', '--nocolor', '--nogroup', '--hidden', '--ignore=.git', (has('win32') ? '-g:' : '-g='), ''])
call denite#custom#var('outline', 'ignore_types', ['v'])

call denite#custom#action('directory,go/package', 'dir_file', {context -> notomo#denite#dir_file_on_directory(context)})
call denite#custom#action('file', 'dir_file', {context -> notomo#denite#dir_file_on_file(context)})
call denite#custom#action('file,directory,go/package', 'parent_dir_file', {context -> notomo#denite#parent_dir_file(context)})

call denite#custom#action('file', 'tabopen', {context ->  notomo#denite#open('tabnew', context)})
call denite#custom#action('directory,go/package', 'open', {context ->  notomo#denite#directory_open('', context)})
call denite#custom#action('directory,go/package', 'tabopen', {context ->  notomo#denite#directory_open('tabnew', context)})

call denite#custom#action('file', 'qfreplace', {context ->  notomo#denite#qfreplace(context)})
call denite#custom#action('file,directory,go/package', 'exrename', {context ->  notomo#denite#exrename(context)})

call denite#custom#action('file,directory,go/package', 'filer', {context ->  notomo#denite#directory_open('', context)})
call denite#custom#action('file,directory,go/package', 'tabfiler', {context ->  notomo#denite#directory_open('tabnew', context)})

call denite#custom#action('file', 'project_dir_file_rec', {context ->  notomo#denite#project_dir_file_rec_on_file(context)})
call denite#custom#action('directory,go/package', 'project_dir_file_rec', {context ->  notomo#denite#project_dir_file_rec(context)})

call denite#custom#action('file', 'dir_file_rec', {context ->  notomo#denite#dir_file_rec_on_file(context)})
call denite#custom#action('directory,go/package', 'dir_file_rec', {context ->  notomo#denite#dir_file_rec(context)})

call denite#custom#action('file', 'dotfiles', {context ->  notomo#denite#project_dir_by_path('~/dotfiles', context)})

call denite#custom#action('directory', 'grep_plugin_setting', {context ->  notomo#denite#grep_plugin_setting(context)})

call denite#custom#action('buffer,command,directory,file,openable,word', 'debug_targets', {context ->  notomo#denite#debug_targets(context)})

call denite#custom#action('url_bookmark', 'convert', {context ->  notomo#denite#convert(context)})

call denite#custom#action('go/package', 'decls', {context ->  notomo#denite#decls(context)})
