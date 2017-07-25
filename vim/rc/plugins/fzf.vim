
function! s:fzf_git() abort
    let git = gina#core#get_or_fail()
    let git_root = gina#core#repo#abspath(git, '')
    call s:fzf(git_root)
endfunction

function! s:fzf(path) abort
    let fzf_buffers = filter(range(1, bufnr('$')), "bufname(v:val) =~# ';#FZF'")
    if len(fzf_buffers) > 0
        execute 'bdelete!' . join(fzf_buffers, ' ')
    endif
    let current_path = getcwd()
    execute 'cd ' . a:path
    call fzf#vim#grep('rg --line-number --no-heading .', 0, fzf#vim#with_preview({'options': '--exact --reverse --delimiter : --nth 3..'}, 'right:50%:wrap'))
    execute 'cd ' . current_path
endfunction
nnoremap [unite]ss :<C-u>call <SID>fzf('.')<CR>
nnoremap [unite]sl :<C-u>call <SID>fzf_git()<CR>

let g:fzf_action = {'ctrl-o': 'tabnew'}
let g:fzf_layout = {'window': '-tabnew'}

