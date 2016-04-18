
" 起動時に有効化
let g:neocomplete#enable_at_startup = 1
" 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplete#enable_smart_case = 1
" _(アンダースコア)区切りの補完を有効化
let g:neocomplete#enable_underbar_completion = 1
let g:neocomplete#enable_camel_case_completion  =  1
" ポップアップメニューで表示される候補の数
let g:neocomplete#max_list = 20
" シンタックスをキャッシュするときの最小文字長
let g:neocomplete#sources#syntax#min_keyword_length = 3
" 補完を表示する最小文字数
let g:neocomplete#auto_completion_start_length = 2
let g:neocomplete#enable_complete_select = 1
let g:neocomplete#enable_auto_select = 0


if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'
