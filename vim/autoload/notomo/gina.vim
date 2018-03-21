
function! s:get_revision() abort
    let tmp = @+
    call gina#action#call('yank:rev')
    let revision = @+
    let @+ = tmp
    return revision
endfunction

function! s:get_path() abort
    let tmp = @+
    call gina#action#call('yank:path')
    let path = @+
    let @+ = tmp
    return path
endfunction

function! notomo#gina#tag_push_command()
    let revision = s:get_revision()
    return ':Gina! push origin ' . revision
endfunction

function! notomo#gina#yank_rev_with_echo()
    call gina#action#call('yank:rev')
    echomsg @+
endfunction

function! notomo#gina#get_remote_name()
    let branch = gina#component#repo#branch()
    let tracking_branch = gina#component#repo#track()
    let remote_name = tracking_branch[:-(len(branch) + 2)]
    return empty(remote_name) ? 'origin' : remote_name
endfunction

function! notomo#gina#stash_file()
    let path = s:get_path()
    execute 'Gina stash push -- ' . path
endfunction

function! notomo#gina#fixup()
    let revision = s:get_revision()
    execute 'Gina! commit --fixup=' . revision
endfunction

function! notomo#gina#rebase_i()
    let revision = s:get_revision()
    terminal
    call jobsend(b:terminal_job_id, 'git rebase -i --autosquash ' . revision . '~' . "\<CR>")
endfunction
