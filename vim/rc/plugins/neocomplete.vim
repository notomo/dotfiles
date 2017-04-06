
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_underbar_completion = 1
let g:neocomplete#enable_camel_case_completion  =  1
let g:neocomplete#max_list = 10
let g:neocomplete#sources#syntax#min_keyword_length = 2
let g:neocomplete#auto_completion_start_length = 2
let g:neocomplete#enable_complete_select = 1
let g:neocomplete#enable_auto_select = 1
let g:neocomplete#enable_auto_close_preview = 1
let g:neocomplete#enable_auto_delimiter = 1
let g:neocomplete#max_keyword_width = 30
let g:neocomplete#sources#buffer#cache_limit_size  = 50000
let g:neocomplete#sources#buffer#max_keyword_width = 50
let g:neocomplete#use_vimproc = 1
let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#snippets_dir ='~/.vim/snippets'
let g:neocomplete#sources#dictionary#dictionaries  = {'_' : '', 'php' : '~/.vim/dict/php.dict'}
let g:neocomplete#delimiter_patterns = {'php' : ['->', '::', '\'], 'python' : ['.',',']}

let s:base_sources = ['neosnippet', 'dictionary', 'buffer', 'file']
let g:neocomplete#sources = {'_' : s:base_sources}
let g:neocomplete#sources.vim = insert(copy(s:base_sources), 'vim', 0)
let g:neocomplete#sources.php = add(copy(s:base_sources), 'tag')

if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \),\?\w*'

let g:neocomplete#sources#omni#input_patterns.php = '\h\w*\|[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'

let g:neocomplete#sources#omni#input_patterns.javascript = '\h\w*\|[^. \t]\.\w*'
let g:neocomplete#force_omni_input_patterns.javascript = '[^. \t]\.\w*'

if !exists('g:necovim#complete_functions')
    let g:necovim#complete_functions = {}
endif
let g:necovim#complete_functions.Ref = 'ref#complete'

inoremap <expr> j<Space>O neocomplete#start_manual_complete('omni')
inoremap <expr> j<Space>u neocomplete#undo_completion()
inoremap <expr> j<Space>; neocomplete#complete_common_string()

