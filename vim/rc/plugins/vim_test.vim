
autocmd MyAuGroup BufEnter * call notomo#vim_test#set_project_root()
let test#strategy = 'neovim'
let g:test#custom_transformations = {'notomo': function('notomo#vim_test#transform')}
let g:test#transformation = 'notomo'
