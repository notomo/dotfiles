nmap [git]j <Plug>(signify-next-hunk)zz
nmap [git]k <Plug>(signify-prev-hunk)zz
nnoremap [git]t <Cmd>SignifyToggle<CR>
let g:signify_disable_by_default = 0
let g:signify_skip = {'vcs': {'deny': ['yadm', 'hg', 'svn', 'bzr', 'darcs', 'fossil', 'cvs', 'rcs', 'accurev', 'perforce', 'tfs']}}
