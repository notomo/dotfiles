
function! s:get_revision() abort
    let tmp = @+
    call gina#action#call('yank:rev')
    let revision = @+
    let @+ = tmp
    return revision
endfunction

function! notomo#gina#changes_of()
    let revision = s:get_revision()
    execute 'Gina changes --opener="botright vsplit" ' . revision . '^..' . revision
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
    return tracking_branch[:-(len(branch) + 2)]
endfunction
