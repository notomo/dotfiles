
function! s:fzf() abort
    let fzf_buffers = filter(range(1, bufnr('$')), "bufname(v:val) =~# ';#FZF'")
    if len(fzf_buffers) > 0
        execute 'bdelete!' . join(fzf_buffers, ' ')
    endif
    call fzf#vim#grep('rg --line-number --no-heading ' . expand('%:h'), 0, fzf#vim#with_preview({'options': '--exact --reverse --delimiter : --nth 3..'}, 'right:50%:wrap'))
endfunction
nnoremap FF :<C-u>call <SID>fzf()<CR>

let g:fzf_action = {'ctrl-o': 'tabnew'}
let g:fzf_layout = {'window': '-tabnew'}

