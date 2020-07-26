autocmd MyAuGroup FileType denite call s:denite_settings()
function! s:denite_settings() abort
    nnoremap <silent> <buffer> <expr> <CR> denite#do_map('do_action', 'default')
    nnoremap <silent> <buffer> <expr> <2-LeftMouse> denite#do_map('do_action', 'default')
    inoremap <silent> <buffer> <LeftMouse> <ESC>
    nnoremap <silent> <buffer> <expr> q denite#do_map('quit')
    nnoremap <silent> <buffer> <expr> i denite#do_map('open_filter_buffer')
    nnoremap <silent> <buffer> <expr> I denite#do_map('open_filter_buffer') . '<Home>'
    nnoremap <silent> <buffer> <expr> a denite#do_map('open_filter_buffer') . '<Left>'
    nnoremap <silent> <buffer> <expr> A denite#do_map('open_filter_buffer') . '<End>'
    nnoremap <silent> <buffer> <expr> p denite#do_map('do_action', 'preview')
    nnoremap <silent> <buffer> <expr> o denite#do_map('do_action', 'open')
    nnoremap <silent> <buffer> <expr> t<Space> denite#do_map('do_action', 'tabopen')
    nnoremap <silent> <buffer> <expr> t<CR> denite#do_map('do_action', 'activate')
    nnoremap <silent> <buffer> <expr> sm denite#do_map('toggle_select') . 'j'
    nnoremap <silent> <buffer> <expr> sa denite#do_map('toggle_select_all')
    nnoremap <silent> <buffer> <expr> sf denite#do_map('do_action', 'dir_file_rec')
    nnoremap <silent> <buffer> <expr> sg denite#do_map('do_action', 'project_dir_file_rec')
    nnoremap <silent> <buffer> <expr> D denite#do_map('do_action', 'grep_plugin_setting')
    nnoremap <silent> <buffer> <expr> sv denite#do_map('do_action', 'vsplit')
    nnoremap <silent> <buffer> <expr> sh denite#do_map('do_action', 'split')
    nnoremap <silent> <buffer> <expr> fo denite#do_map('do_action', 'filer')
    nnoremap <silent> <buffer> <expr> fl denite#do_map('do_action', 'tabfiler')
    nnoremap <silent> <buffer> <expr> yy denite#do_map('do_action', 'yank')
    nnoremap <silent> <buffer> <expr> <Leader>rp denite#do_map('do_action', 'qfreplace')
    nnoremap <silent> <buffer> <expr> ff denite#do_map('do_action', 'dir_file')
    nnoremap <silent> <buffer> <expr> fa denite#do_map('do_action', 'parent_dir_file')
    nnoremap <silent> <buffer> <expr> <Space>D denite#do_map('do_action', 'debug_targets')
    nnoremap <silent> <buffer> <expr> tmp denite#do_map('toggle_matchers', 'matcher_path')
    nnoremap <silent> <buffer> <expr> tmip denite#do_map('toggle_matchers', 'matcher_ignore_path')
    nnoremap <silent> <buffer> <expr> tsl denite#do_map('change_sorters', 'sorter_length')
    nnoremap <silent> <buffer> <expr> rr denite#do_map('restart')
    nnoremap <silent> <buffer> <expr> <Tab> denite#do_map('choose_action')
    nnoremap <silent> <buffer> <expr> dd denite#do_map('open_filter_buffer') . '<ESC>:<C-u>silent %delete _<CR>'
    nnoremap <silent> <buffer> <expr> cc denite#do_map('do_action', 'compare')
endfunction

autocmd MyAuGroup FileType denite-filter call s:denite_filter_settings()
function! s:denite_filter_settings() abort
    " HACK: _move_to_parent
    nnoremap <silent> <buffer> j :<C-u>call denite#filter#_move_to_parent(v:false)<CR>
    nnoremap <silent> <buffer> k :<C-u>call denite#filter#_move_to_parent(v:false)<CR>
    nnoremap <silent> <buffer> dd :<C-u>silent %delete _<CR>
    nnoremap <silent> <buffer> <expr> <CR> denite#do_map('do_action', 'default')
    nnoremap <silent> <buffer> <expr> t<Space> denite#do_map('do_action', 'tabopen')
    nnoremap <silent> <buffer> <expr> t<CR> denite#do_map('do_action', 'activate')
    nnoremap <silent> <buffer> <expr> o denite#do_map('do_action', 'open')
    inoremap <silent> <buffer> <expr> jq '<ESC>' . denite#do_map('quit')
    inoremap <silent> <buffer> <expr> <CR> '<ESC>' . denite#do_map('do_action', 'default')
    nnoremap <silent> <buffer> <expr> yy denite#do_map('do_action', 'yank')
    inoremap <silent> <buffer> <LeftMouse> <ESC>
endfunction

nnoremap <silent> [finder]o :<C-u>Denite outline -no-empty<CR>
nnoremap <silent> [finder]Gn :<C-u>Denite -resume -cursor-pos=+1 -immediately<CR>
nnoremap <silent> [finder]GN :<C-u>Denite -resume -cursor-pos=-1 -immediately<CR>
nnoremap <silent> [finder]G<CR> :<C-u>Denite -resume -no-start-filter<CR>
nnoremap <silent> [finder]Gl :<C-u>Denite grep -no-empty<CR>
nnoremap <silent> [finder]Gg :<C-u>DeniteProjectDir grep -no-empty<CR>

nnoremap <expr> <silent> [keyword]G ":\<C-u>DeniteProjectDir grep:::" . expand('<cword>') . " -no-empty\<CR>"
nnoremap <silent> [finder]gp :<C-u>Denite go/package<CR>

call denite#custom#option('default', 'filter_split_direction', 'botright')
call denite#custom#option('default', 'start_filter', 'true')
call denite#custom#option('default', 'split', 'tab')
call denite#custom#option('default', 'no_empty', v:true)
call denite#custom#option('default', 'vertical_preview', v:true)
call denite#custom#option('default', 'highlight_preview_line', 'Search')
call denite#custom#option('default', 'smartcase', v:true)
call denite#custom#option('default', 'statusline', v:false)
call denite#custom#source('_', 'matchers', ['matcher/regexp'])
call denite#custom#source('ctrlb/history/search', 'matchers', [])
call denite#custom#source('decls', 'sorters', ['sorter_line_number', 'sorter_file_path'])
call denite#custom#filter('matcher/ignore_globs', 'ignore_globs', ['.git', '.mypy_cache/', '__pycache__/*', '__pycache__', '.mypy_cache', '.pytest_cache/', '.pytest_cache', '.DS_Store'])
call denite#custom#source('file/rec', 'matchers', ['matcher/regexp', 'matcher/ignore_globs'])
call denite#custom#source('directory_rec', 'matchers', ['matcher/regexp', 'matcher/ignore_globs'])
call denite#custom#source('grep', 'matchers', ['matcher/regexp', 'matcher/ignore_globs'])

call denite#custom#var('grep', 'command', ['pt'])
call denite#custom#var('grep', 'default_opts', ['--nogroup', '--nocolor', '--smart-case', '--ignore=.git', '--ignore=tags', '--hidden'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

call denite#custom#var('file/rec', 'command', ['pt', '--follow', '--nocolor', '--nogroup', '--hidden', '--ignore=.git', (has('win32') ? '-g:' : '-g='), ''])
call denite#custom#var('outline', 'ignore_types', ['v'])

call denite#custom#action('file', 'tabopen', {context ->  notomo#denite#open('tabnew', context)})
call denite#custom#action('directory,go/package,go/src,plugin', 'open', {context ->  notomo#denite#directory_open('', context)})
call denite#custom#action('directory,go/package,go/src,plugin', 'tabopen', {context ->  notomo#denite#directory_open('tabnew', context)})

call denite#custom#action('file', 'qfreplace', {context ->  notomo#denite#qfreplace(context)})

call denite#custom#action('file,directory,go/package,go/src,plugin', 'filer', {context ->  notomo#denite#directory_open('', context)})
call denite#custom#action('file,directory,go/package,go/src,plugin', 'tabfiler', {context ->  notomo#denite#directory_open('tabnew', context)})

call denite#custom#action('file', 'project_dir_file_rec', {context ->  notomo#denite#project_dir_file_rec_on_file(context)})
call denite#custom#action('directory,go/package,go/src,plugin', 'project_dir_file_rec', {context ->  notomo#denite#project_dir_file_rec(context)})

call denite#custom#action('file', 'dir_file_rec', {context ->  notomo#denite#dir_file_rec_on_file(context)})
call denite#custom#action('directory,go/package,go/src,plugin', 'dir_file_rec', {context ->  notomo#denite#dir_file_rec(context)})

call denite#custom#action('file', 'dotfiles', {context ->  notomo#denite#project_dir_by_path('~/dotfiles', context)})

call denite#custom#action('directory,plugin', 'grep_plugin_setting', {context ->  notomo#denite#grep_plugin_setting(context)})

call denite#custom#action('buffer,command,directory,file,openable,word,autocmd', 'debug_targets', {context ->  notomo#denite#debug_targets(context)})

call denite#custom#action('go/package', 'decls', {context ->  notomo#denite#decls(context)})

call denite#custom#action('word', 'append_emoji', {context ->  notomo#denite#append_emoji(context)})

call denite#custom#action('reference', 'open', {context -> notomo#doc#open(context['targets'][0]['word'], 'tabedit')})
call denite#custom#action('reference', 'tabopen', {context -> notomo#doc#open(context['targets'][0]['word'], 'tabedit')})
