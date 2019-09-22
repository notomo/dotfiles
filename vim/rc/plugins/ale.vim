
let g:ale_open_list = 1
let g:ale_lint_on_filetype_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_prefix = ' '
let g:ale_lint_on_insert_leave = 0

let g:ale_linters = {}
let g:ale_linters['python'] = ['flake8', 'mypy']
let g:ale_linters['vim'] = ['vint']
let g:ale_linters['php'] = ['phpmd', 'php']
let g:ale_linters['sh'] = ['shellcheck']
let g:ale_linters['go'] = ['govet', 'gofmt', 'golint', 'staticcheck']
let g:ale_linters['sql'] = []
let g:ale_linters['c'] = ['clang']
let g:ale_linters['cs'] = ['mcs']
let g:ale_linters['xml'] = []
let g:ale_linters['ruby'] = ['rubocop']
let g:ale_linters['lua'] = ['luacheck']
let g:ale_linters['rust'] = ['rls', 'cargo']
let g:ale_linters['dockerfile'] = ['hadolint']
let g:ale_linters['html'] = ['htmlhint']
let g:ale_linters['javascript'] = []
let g:ale_linters['typescript'] = ['tsserver']
let g:ale_linters['css'] = []
let g:ale_linters['scss'] = g:ale_linters['css']
let g:ale_linters['vue'] = []
let g:ale_pattern_options = {'\.vue$': {'ale_enabled': 0}, '\.sql$': {'ale_fix_on_save': 0}}

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
" let g:ale_fixers['help'] = ['align_help_tags']

let g:ale_php_phpmd_ruleset = 'unusedcode'
let g:ale_python_mypy_options = '--ignore-missing-imports'
let g:ale_python_flake8_executable = 'python3'
let g:ale_python_flake8_options = '-m flake8'
let g:ale_go_gometalinter_options = '--config=' . expand('~/dotfiles/lint/go/.gometalinter.json')
let g:ale_go_staticcheck_lint_package = 1
let g:ale_sql_sqlfmt_options = '-u'
let g:ale_rust_rls_toolchain = 'nightly-2019-09-04'
autocmd MyAuGroup FileType vue let g:ale_javascript_prettier_options = '--parser vue'
autocmd MyAuGroup WinEnter,WinLeave *.vue let g:ale_javascript_prettier_options = ''
autocmd MyAuGroup FileType javascript,typescript,css,html,scss let g:ale_javascript_prettier_options = ''

function! s:toggle_fix_on_save() abort
    let current_value = get(g:, 'ale_fix_on_save', 0)
    let g:ale_fix_on_save = !current_value
endfunction

nnoremap [exec]T :<C-u>call <SID>toggle_fix_on_save()<CR>
nnoremap [exec]<C-f> :<C-u>ALEFix<CR>
