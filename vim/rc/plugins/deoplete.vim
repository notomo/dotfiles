
let g:deoplete#sources = {}
let g:deoplete#sources._ = ['buffer', 'file', 'around', 'neosnippet']
" let g:deoplete#sources.php = ['buffer', 'neosnippet', 'LanguageClient', 'dictionary', 'around', 'file']
" let g:deoplete#sources.php = ['buffer', 'neosnippet', 'tag', 'dictionary', 'around', 'file']
let g:deoplete#sources.php = ['buffer', 'neosnippet', 'tag', 'dictionary', 'around', 'file', 'padawan']
let g:deoplete#sources.markdown = ['buffer', 'neosnippet', 'file', 'around', 'emoji', 'look']
let g:deoplete#sources.vim = ['vim', 'file', 'buffer', 'around', 'neosnippet']
let g:deoplete#sources.python = ['jedi', 'file', 'buffer', 'around', 'neosnippet']
let g:deoplete#sources.go = ['go', 'file', 'buffer', 'around', 'neosnippet']
let g:deoplete#sources.c = ['clang', 'file', 'buffer', 'around', 'neosnippet']
let g:deoplete#sources.cs = ['cs', 'file', 'buffer', 'around', 'neosnippet']
" let g:deoplete#sources.javascript = ['LanguageClient', 'file', 'buffer', 'around', 'neosnippet']
