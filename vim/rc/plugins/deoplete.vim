
let s:sources = {}

let s:sources._ = ['buffer', 'file', 'around', 'neosnippet']
let s:sources.haskell = ['buffer', 'neosnippet', 'around', 'file']
let s:sources.php = ['buffer', 'neosnippet', 'around', 'file']
let s:sources.markdown = ['buffer', 'neosnippet', 'file', 'around', 'emoji', 'look']
let s:sources.vim = ['vim', 'file', 'buffer', 'around', 'neosnippet']
let s:sources.python = ['lsp', 'file', 'buffer', 'around', 'neosnippet']
let s:sources.go = ['lsp', 'file', 'buffer', 'around', 'neosnippet']
" let s:sources.python = ['lsp', 'file', 'buffer', 'around', 'neosnippet']
" let s:sources.go = ['lsp', 'file', 'buffer', 'around', 'neosnippet']
let s:sources.c = ['file', 'buffer', 'around', 'neosnippet']
let s:sources.cs = ['file', 'buffer', 'around', 'neosnippet']
let s:sources['gina-commit'] = ['look', 'buffer', 'file', 'around', 'neosnippet']
let s:sources['rust'] = ['lsp', 'buffer', 'file', 'around', 'neosnippet']
let s:sources['lua'] = ['lsp', 'buffer', 'file', 'around', 'neosnippet']
" let s:sources['rust'] = ['lsp', 'buffer', 'file', 'around', 'neosnippet']
let s:sources.javascript = ['file', 'buffer', 'around', 'neosnippet']
let s:sources.typescript = ['lsp', 'file', 'buffer', 'around', 'neosnippet']
let s:sources['typescript.tsx'] = s:sources.typescript
let s:sources.vue = ['buffer', 'file', 'around', 'neosnippet']
let s:sources.css = ['omni', 'buffer', 'file', 'around', 'neosnippet']
let s:sources.scss = s:sources.css
let s:sources.html = ['omni', 'buffer', 'file', 'around', 'neosnippet']
let s:sources['thetto-input'] = []

call deoplete#custom#option('sources', s:sources)

call deoplete#custom#source('neosnippet', 'rank', 10000)
call deoplete#custom#source('vim', 'converters', ['converter_remove_paren', 'converter_remove_overlap', 'converter_truncate_abbr', 'converter_truncate_menu'])
call deoplete#custom#source('lsp', 'converters', ['converter_lua_lsp', 'converter_remove_paren', 'converter_remove_overlap', 'converter_truncate_abbr', 'converter_truncate_kind', 'converter_truncate_info', 'converter_truncate_menu'])
call deoplete#custom#option('ignore_sources', {'thetto-input': ['around', 'file', 'buffer', 'neosnippet', 'look']})

inoremap <expr> j<Space>u deoplete#manual_complete(['look'])
inoremap j<Space>; <C-x><C-l>

autocmd MyAuGroup FileType css,sass,scss setlocal omnifunc=csscomplete#CompleteCSS
