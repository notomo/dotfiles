setlocal noexpandtab
setlocal matchpairs+==:;
setlocal completeopt-=preview
setlocal dictionary=~/dotfiles/vim/dict/php.dict
if match(fnamemodify(expand('%'), ':t'), '^\k\+Test.php$') != -1
    setlocal dictionary+=~/dotfiles/vim/dict/phpunit.dict
    setlocal dictionary+=~/dotfiles/vim/dict/mockery.dict
else
    setlocal dictionary-=~/dotfiles/vim/dict/phpunit.dict
    setlocal dictionary-=~/dotfiles/vim/dict/mockery.dict
endif

if exists('loaded_matchit')
    call notomo#matchit#sql()
endif

let b:textobj_function_select = function('textobj#function#java#select')

nnoremap <buffer> [keyword]T :<C-u>ALEGoToDefinitionInTab<CR>
