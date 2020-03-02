
function! notomo#github#view_issue(target) abort
    let id = substitute(a:target, '[^[:digit:]]', '', 'g')
    let cmd = ['gh', 'issue', 'view', id]
    let repo = getbufvar('%', 'notomo_gh_repo', '')
    if !empty(repo)
        call add(cmd, '--repo=' . repo)
    endif
    call notomo#vimrc#job(cmd)
endfunction

function! notomo#github#view_pr() abort
    let target = expand('<cword>')
    let id = substitute(target, '[^[:digit:]]', '', 'g')
    let cmd = ['gh', 'pr', 'view']
    if !empty(id)
        call add(cmd, id)
    endif
    call notomo#vimrc#job(cmd)
endfunction

function! notomo#github#create_pr() abort
    let title = input('pr title: ')
    if empty(title)
        echomsg 'Canceled' | return
    endif
    let cmd = ['gh', 'pr', 'create', '--web', '--title', title]
    call notomo#vimrc#job(cmd)
endfunction
