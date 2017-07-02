
let g:deoplete#sources = {}
let g:deoplete#sources._ = ['buffer', 'file', 'around', 'neosnippet']
" let g:deoplete#sources.php = ['buffer', 'neosnippet', 'LanguageClient', 'dictionary', 'around', 'file']
let g:deoplete#sources.php = ['buffer', 'neosnippet', 'dictionary', 'around', 'file']
let g:deoplete#sources.markdown = ['buffer', 'neosnippet', 'file', 'around', 'emoji']
let g:deoplete#sources.vim = ['vim', 'file', 'buffer', 'around', 'neosnippet']
let g:deoplete#sources.python = ['jedi', 'file', 'buffer', 'around', 'neosnippet']
let g:deoplete#sources.go = ['go', 'file', 'buffer', 'around', 'neosnippet']
