
nnoremap [tab] <Nop>
nmap <Leader>t [tab]
nnoremap <silent> [tab]t  :<C-u>tabe<CR>
nnoremap <silent> [tab]b  :<C-u>tabe #<CR>
nnoremap <silent> [tab]s :<C-u>tabr<CR>
nnoremap <silent> [tab]e :<C-u>tabl<CR>
nnoremap <silent> [tab]o :<C-u>tabo<CR>
nnoremap [tab]n :<C-u>tabe<Space>
nnoremap [tab]me :<C-u>tabm<CR>
nnoremap [tab]ms :<C-u>tabm 0<CR>
nnoremap [tab]ml :<C-u>tabm+1<CR>
nnoremap [tab]ma :<C-u>tabm-1<CR>
nnoremap [tab]l gt
nnoremap [tab]a gT
nnoremap <C-Tab> gt
nnoremap <C-S-Tab> gT
inoremap <C-Tab> <Esc>gt
inoremap <C-S-Tab> <Esc>gT
nnoremap <C-w> :<C-u>CloseTabCommand<CR>
nnoremap [tab]q :<C-u>CloseTabCommand<CR>
inoremap <C-w> <ESC>:<C-u>CloseTabCommand<CR>
nnoremap [tab]da :<C-u>CloseLeftTabCommand<CR>
nnoremap [tab]dl :<C-u>CloseRightTabCommand<CR>

function! CloseTab() abort
    try
        execute "tabclose"
    catch
        if !getbufvar("%","&mod")
            execute "q"
        else
            echomsg "Not saved"
        endif
    endtry
endfunction
command! CloseTabCommand call CloseTab()


function! CloseLeftTab() abort
	let current_tab_number = tabpagenr()
	for i in range(2,current_tab_number)
		execute "1tabclose"
	endfor
endfunction
command! CloseLeftTabCommand call CloseLeftTab()

function! CloseRightTab() abort
	let current_tab_number = tabpagenr()
	let last_tab_number = tabpagenr("$")
	for i in range(current_tab_number,last_tab_number-1)
		execute "$tabclose"
	endfor
endfunction
command! CloseRightTabCommand call CloseRightTab()
