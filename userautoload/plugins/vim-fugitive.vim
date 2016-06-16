
nnoremap [git] <Nop>
nmap <Leader>g [git]

nnoremap [git]d :<C-u>Gdiff<CR>
nnoremap [git]s :<C-u>Gstatus<CR>:only<CR>
nnoremap [git]l :<C-u>Glog<CR>
nnoremap [git]a :<C-u>Gwrite<CR>
nnoremap [git]A :<C-u>Git add .<CR>
nnoremap [git]x :<C-u>Git<Space>
nnoremap [git]c :<C-u>Gcommit<CR>
nnoremap [git]C :<C-u>Git commit --amend<CR>
nnoremap [git]P :<C-u>Gpush<Space>
nnoremap [git]F :!git fetch<CR>
nnoremap [git]m :!git merge origin/
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

autocmd MyAuGroup FileType gitcommit call s:gitcommit_my_settings()
function! s:gitcommit_my_settings()"{{{
    nmap <buffer> ga -
	nmap <buffer> dd D
	nmap <buffer> o O
	nmap <buffer> j <C-N>
	nmap <buffer> k <C-P>
    vmap <buffer> ga -
    nmap <buffer> gm /modified<CR>
    nmap <buffer> gn /new file<CR>
endfunction"}}}

