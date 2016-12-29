
nnoremap [git] <Nop>
nmap <Leader>g [git]

nnoremap [git]d :<C-u>Gvdiff<CR>
nnoremap [git]s :<C-u>Gstatus<CR>:only<CR>
nnoremap [git]l :<C-u>tabe %<CR>:Glog \| copen<CR>
nnoremap [git]x :<C-u>Git<Space>
nnoremap [git]c :<C-u>Gcommit<CR>
nnoremap [git]P :<C-u>Gpush<Space>
nnoremap [git]bl :<C-u>Gblame<CR>
nnoremap [git]rn :<C-u>Gmove<Space>
nnoremap [git]rm :<C-u>Gremove<CR>
nnoremap [git]cd :<C-u>Gcd<CR>
nnoremap [git]g :<C-u>Ggrep  \| copen<Left><Left><Left><Left><Left><Left><Left><Left>

