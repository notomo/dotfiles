
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

function! notomo#gina#toggle_buffer(command, file_type)
    let current_ft = &filetype
    if current_ft ==? a:file_type
        if len(tabpagebuflist(tabpagenr())) == 1
            edit #
        else
            quit
        endif
        return
    endif
    execute 'Gina ' . a:command
endfunction

function! notomo#gina#edit(action)
    let splitted = split(getline(line('.')), ' ')
    if len(splitted) == 0
        return
    endif
    let file_part = splitted[-1]

    let git = gina#core#get_or_fail()
    let abspath = gina#core#repo#abspath(git, '')

    let path = abspath . substitute(file_part, '\v(\t\e[31m|\e\[m)', '', 'g')

    if isdirectory(path)
        if a:action ==? 'edit:tab'
            tabnew
        endif
        execute 'cd ' . path
        Kiview -create
        return
    endif

    call gina#action#call(a:action)
endfunction
