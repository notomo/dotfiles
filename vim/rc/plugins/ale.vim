
let g:ale_open_list = 1
let g:ale_lint_on_filetype_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'never'

let g:ale_linters = {}
let g:ale_linters['python'] = ['flake8', 'mypy']
let g:ale_linters['vim'] = ['vint']
let g:ale_linters['php'] = ['phpmd', 'php']
" let g:ale_linters['php'] = ['phpcs', 'phpmd', 'php']
let g:ale_linters['sh'] = ['shellcheck']
let g:ale_linters['go'] = ['govet', 'gofmt', 'golint']
let g:ale_linters['sql'] = []
let g:ale_linters['c'] = ['clang']
let g:ale_linters['cs'] = ['mcs']
let g:ale_linters['xml'] = []

let g:ale_fixers = {}
let g:ale_fixers['python'] = ['autopep8', 'isort']
" let g:ale_fixers['php'] = ['phpcbf']
" let g:ale_fixers['help'] = ['align_help_tags']

let g:ale_php_phpcs_standard = '~/dotfiles/lint/php/phpcs/my_psr2.xml'
" let g:ale_php_phpcbf_standard = g:ale_php_phpcs_standard
let g:ale_php_phpmd_ruleset = 'unusedcode'
let g:ale_python_mypy_options = '--ignore-missing-imports'
let g:ale_python_flake8_executable = 'python3.5'
let g:ale_python_flake8_options = '-m flake8'
let g:ale_go_gometalinter_options = '--fast'
