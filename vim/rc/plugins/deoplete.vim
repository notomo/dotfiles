
let s:sources = {}

let s:sources._ = ['buffer', 'file', 'around', 'neosnippet']
let s:sources.haskell = ['buffer', 'neosnippet', 'LanguageClient', 'dictionary', 'around', 'file']
" let s:sources.php = ['buffer', 'neosnippet', 'LanguageClient', 'dictionary', 'around', 'file']
let s:sources.php = ['buffer', 'neosnippet', 'tag', 'dictionary', 'around', 'file']
" let s:sources.php = ['buffer', 'neosnippet', 'tag', 'dictionary', 'around', 'file', 'padawan']
let s:sources.markdown = ['buffer', 'neosnippet', 'file', 'around', 'emoji', 'look']
let s:sources.vim = ['vim', 'file', 'buffer', 'around', 'neosnippet']
let s:sources.python = ['jedi', 'file', 'buffer', 'around', 'neosnippet']
let s:sources.go = ['go', 'file', 'buffer', 'around', 'neosnippet']
let s:sources.c = ['clang', 'file', 'buffer', 'around', 'neosnippet']
let s:sources.cs = ['cs', 'file', 'buffer', 'around', 'neosnippet']
" let s:sources.javascript = ['LanguageClient', 'file', 'buffer', 'around', 'neosnippet']
let s:sources['gina-commit'] = ['look', 'buffer', 'file', 'around', 'neosnippet']
" let s:sources['rust'] = ['buffer', 'file', 'around', 'neosnippet', 'LanguageClient']
let s:sources.javascript = ['tern', 'file', 'buffer', 'around', 'neosnippet']
let s:sources.typescript = ['typescript', 'file', 'buffer', 'around', 'neosnippet']
let s:sources.vue = ['LanguageClient', 'buffer', 'file', 'around', 'neosnippet']
let s:sources.css = ['omni', 'buffer', 'file', 'around', 'neosnippet']
let s:sources.scss = s:sources.css
let s:sources.html = ['omni', 'buffer', 'file', 'around', 'neosnippet']
let s:sources.blade = ['buffer', 'neosnippet', 'tag', 'around', 'file']

call deoplete#custom#option('sources', s:sources)

call deoplete#custom#source('neosnippet', 'rank', 10000)
call deoplete#custom#source('tag', 'rank', 700)

call deoplete#custom#source('vim', 'converters', ['converter_remove_paren', 'converter_remove_overlap', 'converter_truncate_abbr', 'converter_truncate_menu'])

call deoplete#custom#var('file', 'force_completion_length', 1)

inoremap <expr> j<Space>u deoplete#undo_completion()
inoremap <expr> j<Space>; deoplete#complete_common_string()

autocmd MyAuGroup FileType css,sass,scss setlocal omnifunc=csscomplete#CompleteCSS
autocmd MyAuGroup FileType html,blade setlocal omnifunc=emmet#completeTag
