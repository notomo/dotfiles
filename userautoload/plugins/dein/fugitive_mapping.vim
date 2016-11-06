

nnoremap [git] <Nop>
nmap <Leader>g [git]

nnoremap [git]d :<C-u>Gvdiff<CR>
nnoremap [git]s :<C-u>Gstatus<CR>:only<CR>
nnoremap [git]l :<C-u>tabe %<CR>:Glog \| copen<CR>
" nnoremap [git]a :<C-u>Gwrite<CR>
" nnoremap [git]A :<C-u>Git add .<CR>
nnoremap [git]x :<C-u>Git<Space>
nnoremap [git]c :<C-u>Gcommit<CR>
" nnoremap [git]C :<C-u>Git commit --amend<CR>
nnoremap [git]P :<C-u>Gpush<Space>
" nnoremap [git]F :!git fetch<CR>
" nnoremap [git]m :!git merge origin/
nnoremap [git]bl :<C-u>Gblame<CR>
nnoremap [git]rn :<C-u>Gmove<Space>
nnoremap [git]rm :<C-u>Gremove<CR>
nnoremap [git]cd :<C-u>Gcd<CR>
nnoremap [git]g :<C-u>Ggrep  \| copen<Left><Left><Left><Left><Left><Left><Left><Left>

set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''}

function! YankTicketNumber() abort
	if !exists('g:loaded_fugitive')
		return
	endif
	let branch_name = fugitive#statusline()[5:-3]
	let number = matchstr(branch_name, '[0-9]*')
	if number != ""
		let @+ = number
		echomsg "yank ".number
	else
		echomsg "Not ticket repogitory"
	endif
endfunction
command! YankTicketNumberCommand call YankTicketNumber()
nnoremap <Space>yt :<C-u>YankTicketNumberCommand<CR>

