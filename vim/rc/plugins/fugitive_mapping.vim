
nnoremap [fugit] <Nop>
nmap <Leader>g [fugit]

nnoremap [fugit]d :<C-u>Gvdiff<CR>
nnoremap [fugit]s :<C-u>Gstatus<CR>:only<CR>
nnoremap [fugit]l :<C-u>tabe %<CR>:Glog \| copen<CR>
nnoremap [fugit]x :<C-u>Git<Space>
nnoremap [fugit]c :<C-u>Gcommit<CR>
nnoremap [fugit]P :<C-u>Gpush<Space>
nnoremap [fugit]bl :<C-u>Gblame<CR>
nnoremap [fugit]rn :<C-u>Gmove<Space>
nnoremap [fugit]rm :<C-u>Gremove<CR>
nnoremap [fugit]cd :<C-u>Gcd<CR>
nnoremap [fugit]g :<C-u>Ggrep  \| copen<Left><Left><Left><Left><Left><Left><Left><Left>

