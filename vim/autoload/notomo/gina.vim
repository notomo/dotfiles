
function! s:get_revision() abort
    let tmp = @+
    call gina#action#call('yank:rev')
    let revision = @+
    let @+ = tmp
    return revision
endfunction

function! notomo#gina#changes_of()
    let revision = s:get_revision()
    execute 'Gina changes ' . revision . '^..' . revision
endfunction

function! notomo#gina#tag_push_command()
    let revision = s:get_revision()
    return ':Gina! push origin ' . revision
endfunction

function! notomo#gina#yank_rev_with_echo()
    call gina#action#call('yank:rev')
    echomsg @+
endfunction
