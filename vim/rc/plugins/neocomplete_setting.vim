
" 起動時に有効化
let g:neocomplete#enable_at_startup = 1
" 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplete#enable_smart_case = 1
" _(アンダースコア)区切りの補完を有効化
let g:neocomplete#enable_underbar_completion = 1
let g:neocomplete#enable_camel_case_completion  =  1
" ポップアップメニューで表示される候補の数
let g:neocomplete#max_list = 8
" シンタックスをキャッシュするときの最小文字長
let g:neocomplete#sources#syntax#min_keyword_length = 2
" 補完を表示する最小文字数
let g:neocomplete#auto_completion_start_length = 2
let g:neocomplete#enable_complete_select = 1
let g:neocomplete#enable_auto_select = 0

let g:neocomplete#enable_auto_close_preview = 3
let g:neocomplete#enable_auto_delimiter = 1

let g:neocomplete#delimiter_patterns = {'php': ['->', '::', '\'],'python':['.',',']}
let g:neocomplete#max_keyword_width = 30
let g:neocomplete#sources = {'_': ['file','neosnippet','dictionary','buffer', 'tag', 'syntax']}
let g:neocomplete#sources.vim = ['file', 'neosnippet', 'dictionary', 'buffer', 'tag', 'vim']

" ユーザー定義スニペット保存ディレクトリ
let g:neocomplete#snippets_dir ='~/.vim/snippets'

let g:neocomplete#sources#buffer#cache_limit_size  = 50000
let g:neocomplete#sources#buffer#max_keyword_width = 30
let g:neocomplete#sources#dictionary#dictionaries  = {'_': '', 'php': '~/.vim/dict/php.dict'}
let g:neocomplete#use_vimproc                      = 1

if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
endif

if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif

" let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'
let g:neocomplete#force_omni_input_patterns.python =
                \ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \),\?\w*'

" let g:neocomplete#force_omni_input_patterns.php = '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'

let g:neocomplete#sources#omni#input_patterns.php =
\ '\h\w*\|[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'

let g:neocomplete#force_overwrite_completefunc = 1

inoremap <expr> j<Space>o neocomplete#start_manual_complete('omni')
inoremap <expr> j<Space>; neocomplete#undo_completion()
inoremap <expr> j<Space>. neocomplete#complete_common_string()

let g:neocomplete#sources#omni#input_patterns.javascript = '\h\w*\|[^. \t]\.\w*'
let g:neocomplete#force_omni_input_patterns.javascript = '[^. \t]\.\w*'

if !exists('g:necovim#complete_functions')
    let g:necovim#complete_functions = {}
endif
let g:necovim#complete_functions.Ref =
\ 'ref#complete'

" let g:neocomplete#text_mode_filetypes = { "_" : 1 }
