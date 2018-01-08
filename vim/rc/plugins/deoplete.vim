
let g:deoplete#sources = {}
let g:deoplete#sources._ = ['buffer', 'file', 'around', 'neosnippet']
" let g:deoplete#sources.php = ['buffer', 'neosnippet', 'LanguageClient', 'dictionary', 'around', 'file']
let g:deoplete#sources.php = ['buffer', 'neosnippet', 'tag', 'dictionary', 'around', 'file']
" let g:deoplete#sources.php = ['buffer', 'neosnippet', 'tag', 'dictionary', 'around', 'file', 'padawan']
let g:deoplete#sources.markdown = ['buffer', 'neosnippet', 'file', 'around', 'emoji', 'look']
let g:deoplete#sources.vim = ['vim', 'file', 'buffer', 'around', 'neosnippet']
let g:deoplete#sources.python = ['jedi', 'file', 'buffer', 'around', 'neosnippet']
let g:deoplete#sources.go = ['go', 'file', 'buffer', 'around', 'neosnippet']
let g:deoplete#sources.c = ['clang', 'file', 'buffer', 'around', 'neosnippet']
let g:deoplete#sources.cs = ['cs', 'file', 'buffer', 'around', 'neosnippet']
" let g:deoplete#sources.javascript = ['LanguageClient', 'file', 'buffer', 'around', 'neosnippet']
let g:deoplete#sources['gina-commit'] = ['look', 'buffer', 'file', 'around', 'neosnippet']
" let g:deoplete#sources['rust'] = ['buffer', 'file', 'around', 'neosnippet', 'LanguageClient']

call deoplete#custom#source('neosnippet', 'rank', 10000)
call deoplete#custom#source('tag', 'rank', 700)
let g:deoplete#tag#cache_limit_size = 5000000

call deoplete#custom#source('vim', 'converters', ['converter_remove_paren', 'converter_remove_overlap', 'converter_truncate_abbr', 'converter_truncate_menu'])

inoremap <expr> j<Space>u deoplete#undo_completion()
inoremap <expr> j<Space>; deoplete#complete_common_string()
