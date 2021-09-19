
let g:ale_open_list = 0
let g:ale_lint_on_filetype_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 0
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_prefix = ' '
let g:ale_lint_on_insert_leave = 0
let g:ale_hover_cursor = 0
let g:ale_disable_lsp = 1

let g:ale_linters = {}

let g:ale_fixers = {}
let g:ale_fixers['sh'] = ['shfmt']
let g:ale_fixers['python'] = ['black', 'isort']
let g:ale_fixers['go'] = ['goimports']
let g:ale_fixers['rust'] = ['rustfmt']
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fixers['typescript'] = ['prettier']
let g:ale_fixers['css'] = ['prettier']
let g:ale_fixers['html'] = ['prettier']
let g:ale_fixers['scss'] = g:ale_fixers['css']
let g:ale_fixers['vue'] = ['prettier']
let g:ale_fixers['json'] = ['fixjson']
let g:ale_fixers['sql'] = ['sqlfmt']
let g:ale_fixers['terraform'] = ['terraform']
let g:ale_fixers['lua'] = ['lua-format']
let g:ale_fixers['dart'] = ['dart-format']

let g:ale_lua_lua_format_options = '-c ' .. expand('~/dotfiles/tool/.lua-format')
let g:ale_sql_sqlfmt_options = '-u'
