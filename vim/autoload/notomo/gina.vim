
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
