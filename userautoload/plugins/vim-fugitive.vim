
nnoremap [git] <Nop>
nmap <Leader>g [git]

nnoremap [git]d :<C-u>Gdiff<CR>
nnoremap [git]s :<C-u>Gstatus<CR>
nnoremap [git]l :<C-u>Glog<CR>
nnoremap [git]a :<C-u>Gwrite<CR>
nnoremap [git]A :<C-u>Git add .<CR>
nnoremap [git]x :<C-u>Git<Space>
nnoremap [git]c :<C-u>Gcommit<CR>
nnoremap [git]C :<C-u>Git commit --amend<CR>
nnoremap [git]P :<C-u>Gpush<Space>
nnoremap [git]bl :<C-u>Gblame<CR>
nnoremap [git]rn :<C-u>Gmove<Space>
nnoremap [git]rm :<C-u>Gremove<CR>
nnoremap [git]cd :<C-u>Gcd<CR>
nnoremap [git]g :<C-u>Ggrep  \| copen<Left><Left><Left><Left><Left><Left><Left><Left>

set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''}
