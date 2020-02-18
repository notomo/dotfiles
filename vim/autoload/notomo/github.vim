
function! notomo#github#view_issue(target) abort
    let id = substitute(a:target, '[^[:digit:]]', '', 'g')
    let cmd = ['gh', 'issue', 'view', id]
    let repo = getbufvar('%', 'notomo_gh_repo', '')
    if !empty(repo)
        call add(cmd, '--repo=' . repo)
    endif
    call notomo#vimrc#job(cmd)
endfunction
