
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
let g:ale_linters['go'] = ['govet', 'gofmt', 'golint', 'staticcheck', 'gosimple', 'gometalinter']
let g:ale_linters['sql'] = []
let g:ale_linters['c'] = ['clang']
let g:ale_linters['cs'] = ['mcs']
let g:ale_linters['xml'] = []
let g:ale_linters['ruby'] = ['rubocop']
let g:ale_linters['lua'] = ['luacheck']
let g:ale_linters['rust'] = ['rls', 'rustc']
let g:ale_linters['dockerfile'] = ['hadolint']
let g:ale_linters['html'] = ['htmlhint']
let g:ale_linters['javascript'] = ['eslint']

let g:ale_fixers = {}
let g:ale_fixers['python'] = ['autopep8', 'isort']
let g:ale_fixers['go'] = ['goimports']
let g:ale_fixers['rust'] = ['rustfmt']
let g:ale_fixers['javascript'] = ['prettier']
" let g:ale_fixers['php'] = ['phpcbf']
" let g:ale_fixers['help'] = ['align_help_tags']

let g:ale_php_phpcs_standard = '~/dotfiles/lint/php/phpcs/my_psr2.xml'
" let g:ale_php_phpcbf_standard = g:ale_php_phpcs_standard
let g:ale_php_phpmd_ruleset = 'unusedcode'
let g:ale_python_mypy_options = '--ignore-missing-imports'
let g:ale_python_flake8_executable = 'python3.5'
let g:ale_python_flake8_options = '-m flake8'
let g:ale_go_gometalinter_options = '--config=' . expand('~/dotfiles/lint/go/.gometalinter.json')

function! s:toggle_fix_on_save() abort
    let current_value = get(g:, 'ale_fix_on_save', 0)
    let g:ale_fix_on_save = !current_value
endfunction

nnoremap [exec]tf :<C-u>call <SID>toggle_fix_on_save()<CR>

