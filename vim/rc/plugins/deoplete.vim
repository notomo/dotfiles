
let s:sources = {}

let s:sources._ = ['buffer', 'file', 'around', 'neosnippet']
let s:sources.haskell = ['buffer', 'neosnippet', 'around', 'file']
let s:sources.php = ['buffer', 'neosnippet', 'around', 'file']
let s:sources.markdown = ['buffer', 'neosnippet', 'file', 'around', 'emoji']
let s:sources['gina-commit'] = ['buffer', 'file', 'around', 'neosnippet']
if !has('win32')
  call add(s:sources.markdown, 'look')
  call add(s:sources['gina-commit'], 'look')
endif
let s:sources.vim = ['lsp', 'file', 'buffer', 'around', 'neosnippet']
let s:sources.python = ['lsp', 'file', 'buffer', 'around', 'neosnippet']
let s:sources.go = ['lsp', 'file', 'buffer', 'around', 'neosnippet']
let s:sources.c = ['lsp', 'file', 'buffer', 'around', 'neosnippet']
let s:sources.cs = ['file', 'buffer', 'around', 'neosnippet']
let s:sources['rust'] = ['lsp', 'buffer', 'file', 'around', 'neosnippet']
let s:sources.dart = ['lsp', 'buffer', 'file', 'around', 'neosnippet']
let s:sources['lua'] = ['lsp', 'buffer', 'file', 'around', 'neosnippet']
let s:sources.javascript = ['file', 'buffer', 'around', 'neosnippet']
let s:sources.typescript = ['lsp', 'file', 'buffer', 'around', 'neosnippet']
let s:sources['typescript.tsx'] = s:sources.typescript
let s:sources.vue = ['buffer', 'file', 'around', 'neosnippet']
let s:sources.css = ['lsp', 'buffer', 'file', 'around', 'neosnippet']
let s:sources.scss = s:sources.css
let s:sources.html = ['omni', 'buffer', 'file', 'around', 'neosnippet']
let s:sources['thetto-input'] = []

call deoplete#custom#option('sources', s:sources)

call deoplete#custom#source('neosnippet', 'rank', 10000)
call deoplete#custom#source('vim', 'converters', ['converter_remove_paren', 'converter_remove_overlap', 'converter_truncate_abbr', 'converter_truncate_menu'])
call deoplete#custom#source('lsp', 'converters', ['converter_lua_lsp', 'converter_remove_paren', 'converter_remove_overlap', 'converter_truncate_abbr', 'converter_truncate_kind', 'converter_truncate_info', 'converter_truncate_menu'])
call deoplete#custom#option('ignore_sources', {'thetto-input': ['around', 'file', 'buffer', 'neosnippet', 'look', 'lsp'], 'reacher': ['around', 'file', 'buffer', 'neosnippet', 'look', 'lsp']})

inoremap <expr> j<Space>u deoplete#manual_complete(['look'])
inoremap j<Space>; <C-x><C-l>
