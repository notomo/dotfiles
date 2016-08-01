
nnoremap [tab] <Nop>
nmap <Leader>t [tab]
nnoremap <silent> [tab]t  :<C-u>call <SID>new_tab()<CR>
nnoremap <silent> [tab]b  :<C-u>tabe #<CR>
nnoremap <silent> [tab]s :<C-u>tabr<CR>
nnoremap <silent> [tab]e :<C-u>tabl<CR>
nnoremap <silent> [tab]o :<C-u>tabo<CR>
nnoremap <silent> [tab]p :<C-u>TabRecent<CR>
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
nnoremap <silent> <C-w> :<C-u>call <SID>close_tab()<CR>
nnoremap <silent> [tab]q :<C-u>call <SID>close_tab()<CR>
inoremap <silent> <C-w> <ESC>:<C-u>call <SID>close_tab()<CR>
nnoremap <silent> [tab]da :<C-u>call <SID>close_left_tab()<CR>
nnoremap <silent> [tab]dl :<C-u>call <SID>close_right_tab()<CR>
" a
function! s:new_tab() abort
    tabe
    setlocal buftype=nofile noswapfile
endfunction

function! s:close_tab() abort
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

function! s:close_left_tab() abort
	let current_tab_number = tabpagenr()
	for i in range(2,current_tab_number)
		execute "1tabclose"
	endfor
endfunction

function! s:close_right_tab() abort
	let current_tab_number = tabpagenr()
	let last_tab_number = tabpagenr("$")
	for i in range(current_tab_number,last_tab_number-1)
		execute "$tabclose"
	endfor
endfunction
