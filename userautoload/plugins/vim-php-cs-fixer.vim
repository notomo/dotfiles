let s:bundle=neobundle#get('vim-php-cs-fixer')
function! s:bundle.hooks.on_source(bundle)
    " If php-cs-fixer is in $PATH, you don't need to define line below
    let g:php_cs_fixer_path = $VIM."\\php-cs-fixer.phar" " define the path to the php-cs-fixer.phar
    let g:php_cs_fixer_level = "symfony"              " which level ?
    let g:php_cs_fixer_config = "default"             " configuration
    "let g:php_cs_fixer_config_file = '.php_cs'       " configuration file
    let g:php_cs_fixer_php_path = "php"               " Path to PHP
    " If you want to define specific fixers:
    "let g:php_cs_fixer_fixers_list = "linefeed,short_tag,indentation"
    " let g:php_cs_fixer_enable_default_mapping = 1     " Enable the mapping by default (<leader>pcd)
    let g:php_cs_fixer_dry_run = 0                    " Call command with dry-run option
    let g:php_cs_fixer_verbose = 0                    " Return the output of command if 1, else an inline information.
endfunction
unlet s:bundle
nnoremap <silent><leader>pcd :call PhpCsFixerFixDirectory()<CR>
nnoremap <silent><leader>pcf :call PhpCsFixerFixFile()<CR>
