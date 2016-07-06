nnoremap <buffer> <expr> <CR> expand(":cc ".line(".")."<CR>")

noremap <buffer> p  <CR>zz<C-w>p

setlocal statusline+=\ %L

nnoremap <silent> <buffer> dd :call <SID>del_entry()<CR>
nnoremap <silent> <buffer> gd :call <SID>diff_entry()<CR>
nnoremap <silent> <buffer> x :call <SID>del_entry()<CR>
vnoremap <silent> <buffer> d :call <SID>del_entry()<CR>
vnoremap <silent> <buffer> x :call <SID>del_entry()<CR>
nnoremap <silent> <buffer> u :<C-u>call <SID>undo_entry()<CR>

if exists('*s:undo_entry')
  finish
endif

function! s:undo_entry()
  let history = get(w:, 'qf_history', [])
  if !empty(history)
    call setqflist(remove(history, -1), 'r')
  endif
endfunction

function! s:del_entry() range
  let qf = getqflist()
  let history = get(w:, 'qf_history', [])
  call add(history, copy(qf))
  let w:qf_history = history
  unlet! qf[a:firstline - 1 : a:lastline - 1]
  call setqflist(qf, 'r')
  execute a:firstline
endfunction

function! s:diff_entry() abort
    let line = getline(".")
    let revision_candidate = matchstr(line, '\.git\\\\[a-zA-Z0-9]*')
    if revision_candidate != ""
        let revision = revision_candidate[6:]
        echomsg string(revision)
        execute "normal :Gdiff ".revision."\<CR>"
    else
        echomsg "Not revision"
    endif
endfunction
