nnoremap <Leader>gd :<C-u>Gdiff<CR>
nnoremap <Leader>gs :<C-u>Gstatus<CR>
nnoremap <Leader>gl :<C-u>Glog<CR>
nnoremap <Leader>ga :<C-u>Gwrite<CR>
nnoremap <Leader>gA :<C-u>Git add .<CR>
nnoremap <Leader>gx :<C-u>Git<Space>
nnoremap <Leader>gc :<C-u>Gcommit<CR>
nnoremap <Leader>gC :<C-u>Git commit --amend<CR>
nnoremap <Leader>gP :<C-u>Gpush<Space>
nnoremap <Leader>gbl :<C-u>Gblame<CR>
nnoremap <Leader>grn :<C-u>Gmove<Space>
nnoremap <Leader>grm :<C-u>Gremove<CR>
nnoremap <Leader>gcd :<C-u>Gcd<CR>
set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''}
