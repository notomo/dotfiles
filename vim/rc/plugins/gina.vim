nnoremap <silent> [git]s :<C-u>call notomo#gina#toggle_buffer('status', 'gina-status')<CR>
nnoremap [git]D :<C-u>Gina diff<CR>
nnoremap <silent> [git]b :<C-u>call notomo#gina#toggle_buffer('branch', 'gina-branch')<CR>
nnoremap [git]L :<C-u>Gina log master...HEAD<CR>
nnoremap [git]ll :<C-u>Gina log<CR>
nnoremap [git]rl :<C-u>Gina reflog<CR>
nnoremap [git]ls :<C-u>Gina ls<CR>
nnoremap [git]T :<C-u>Gina tag<CR>
nnoremap [git]c :<C-u>Gina commit<CR>
nnoremap [git]xl :<C-u>call notomo#gina#toggle_buffer('stash_for_list list', 'gina-stash-list')<CR>
nnoremap [git]xs :<C-u>Gina stash save ""<Left>
nnoremap [git]xc :<C-u>Gina stash show<CR>
nnoremap <expr> [git]P ':<C-u>Gina! push ' . notomo#gina#get_remote_name() . ' ' . gina#component#repo#branch()
nnoremap <expr> [git]H ':<C-u>Gina! pull ' . notomo#gina#get_remote_name() . ' ' . gina#component#repo#branch()
nnoremap [git]M :<C-u>Gina! merge<Space>
nnoremap <expr> [git]F ':<C-u>Gina! fetch ' . notomo#gina#get_remote_name() . ' --prune'
nnoremap [git]ma :<C-u>Gina! merge --abort
nnoremap [git]ca :<C-u>Gina! cherry-pick --abort
nnoremap [git]ra :<C-u>Gina! rebase --abort
nnoremap [git]R :<C-u>Gina! rebase<Space>

function! s:get_current_relpath() abort
    let git = gina#core#get_or_fail()
    let abspath = gina#core#repo#abspath(git, '')
    let curpath = substitute(expand('%:p'), '\', '/', 'g')
    let relpath = substitute(curpath, abspath, '', '')
    return relpath
endfunction
nnoremap [git]B :<C-u>execute 'Gina blame :' . <SID>get_current_relpath()<CR>
nnoremap [git]fl :<C-u>execute 'Gina log :' . <SID>get_current_relpath()<CR>
nnoremap [git]dd :<C-u>execute 'Gina compare :' . <SID>get_current_relpath()<CR>
nnoremap [git]df :<C-u>execute 'Gina diff :' . <SID>get_current_relpath()<CR>

let s:silent = {'silent': 1}
let s:noremap_silent = {'noremap':1, 'silent': 1}
for s:mode_char in ['n', 'v']
    let s:mode_silent = {'mode': s:mode_char, 'silent': 1}
    let s:noremap_mode_silent = {'noremap': 1, 'mode': s:mode_char, 'silent': 1}

    " status
    call gina#custom#mapping#map('status', '[git]a', '<Plug>(gina-index-toggle)', s:mode_silent)
    call gina#custom#mapping#map('status', '[git]u', '<Plug>(gina-index-unstage)', s:mode_silent)
    call gina#custom#mapping#map('status', 'U', '<Plug>(gina-index-discard)', s:mode_silent)

    " stash
    call gina#custom#mapping#map('stash', 'dr', '<Plug>(gina-stash-drop)', s:mode_silent)

    " patch
    call gina#custom#mapping#map('patch', '[diff]p', '<Plug>(gina-diffput)', s:mode_silent)
    call gina#custom#mapping#map('patch', '[diff]G', '<Plug>(gina-diffget)', s:mode_silent)
    call gina#custom#mapping#map('patch', '[diff]gl', '<Plug>(gina-diffget-r)', s:mode_silent)
    call gina#custom#mapping#map('patch', '[diff]ga', '<Plug>(gina-diffget-l)', s:mode_silent)

    " mark
    call gina#custom#mapping#map('/\%(status\|stash\|branch\)', 'sm', '<Plug>(gina-builtin-mark)', s:mode_silent)
    call gina#custom#mapping#map('/\%(status\|stash\|branch\)', 'su', '<Plug>(gina-builtin-mark-unset)', s:mode_silent)

endfor

let g:gina#command#blame#use_default_aliases = 0
let g:gina#command#branch#use_default_aliases = 0
let g:gina#command#changes#use_default_aliases = 0
let g:gina#command#grep#use_default_aliases = 0
let g:gina#command#log#use_default_aliases = 0
let g:gina#command#ls#use_default_aliases = 0
let g:gina#command#reflog#use_default_aliases = 0
let g:gina#command#stash#use_default_aliases = 0
let g:gina#command#stash#show#use_default_aliases = 0
let g:gina#command#status#use_default_aliases = 0
let g:gina#command#tag#use_default_aliases = 0

" status
let g:gina#command#status#use_default_mappings = 0
call gina#custom#mapping#nmap('status', 'cc', ':<C-u>Gina commit<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('status', 'ca', ':<C-u>Gina commit --amend<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('status', 'cs', ':call gina#action#call(''chaperon:tab'')<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('status', 'pp', ':call gina#action#call("patch:tab")<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('status', 'S', ':call notomo#gina#stash_file()<CR>', s:noremap_silent)

" commit
call gina#custom#command#option('commit', '-v|--verbose')

" stash
call gina#custom#mapping#nmap('stash', 'AP', '<Plug>(gina-stash-apply)', s:silent)
call gina#custom#mapping#nmap('stash', 'pop', '<Plug>(gina-stash-pop)', s:silent)
call gina#custom#mapping#nmap('stash', 'o', ':call gina#action#call("stash:show")<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('stash', 't<Space>', ':call gina#action#call("stash:show:tab")<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('stash', 'sv', ':call gina#action#call("stash:show:rightest")<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('stash', 'sh', ':call gina#action#call("stash:show:bottom")<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('stash', '<CR>', ':call gina#action#call("stash:show:tab")<CR>', s:noremap_silent)

" branch
call gina#custom#mapping#nmap('branch', 'rn', '<Plug>(gina-branch-move)', s:silent)
" call gina#custom#mapping#nmap('branch', 'dl', '<Plug>(gina-branch-delete)', s:silent)
call gina#custom#mapping#nmap('branch', 'rf', '<Plug>(gina-branch-reflesh)', s:silent)
call gina#custom#mapping#nmap('branch', 'C', '<Plug>(gina-branch-new)', s:silent)
call gina#custom#command#option('branch', '-v', 'v')
call gina#custom#mapping#nmap('branch', 'MA', ':call gina#action#call(''commit:merge'')<CR>', s:noremap_silent)

" group
call gina#custom#command#option('show', '--group', 'show')
call gina#custom#command#option('changes', '--group', 'changes')
call gina#custom#command#option('status', '--group', 'short')
call gina#custom#command#option('commit', '--group', 'short')

" opener
call gina#custom#command#option('/\%(status\|changes\|ls\|commit\)', '--opener', 'botright split')
call gina#custom#command#alias('stash', 'stash_for_list')
call gina#custom#command#option('/\%(stash_for_list\|branch\)', '--opener', 'topleft split')
call gina#custom#command#option('/\%(diff\|blame\|compare\|patch\|log\)', '--opener', 'tabedit')

" open
call gina#custom#mapping#nmap('/\%(log\|ls\|blame\|changes\|tag\|branch\)', 'o', ':call gina#action#call("show")<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('/\%(log\|ls\|blame\|changes\|tag\|branch\)', 't<Space>', ':call gina#action#call("show:tab")<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('/\%(log\|ls\|blame\|changes\|tag\|branch\)', 'sv', ':call gina#action#call("show:rightest")<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('/\%(log\|ls\|blame\|changes\|tag\|branch\)', 'sh', ':call gina#action#call("show:bottom")<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('/\%(ls\|blame\|changes\|status\|tag\)', '<CR>', ':call gina#action#call("show:tab")<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('status', 'o', ':call notomo#gina#edit("edit")<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('status', 't<Space>', ':call notomo#gina#edit("edit:tab")<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('status', '<CR>', ':call notomo#gina#edit("edit:tab")<CR>', s:noremap_silent)

" yank
call gina#custom#mapping#nmap('/\%(log\|branch\|blame\)', 'yr', ':call notomo#gina#yank_rev_with_echo()<CR>', s:noremap_silent)

" show changes, compare
call gina#custom#mapping#nmap('/\%(log\|blame\|branch\|tag\)', 'cb', ':call gina#action#call("changes:between:rightest")<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('/\%(log\|blame\|branch\|tag\)', 'cf', ':call gina#action#call("changes:from:rightest")<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('/\%(log\|blame\|branch\|tag\)', 'cc', ':call gina#action#call("changes:of:rightest")<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('status', 'dd', ':call gina#action#call("patch:oneside:tab")<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('/\%(blame\|stash\|log\|compare\)', 'dd', ':call gina#action#call("compare")<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('/\%(status\|blame\|stash\|log\|compare\)', 'D', ':call gina#action#call("diff")<CR>', s:noremap_silent)

" commit
call gina#custom#mapping#nmap('/\%(branch\|log\)', 'cp', ':call gina#action#call("commit:cherry-pick")<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('commit', '[file]w', ':wq<CR>', {'noremap':1})

" blame
let g:gina#command#blame#formatter#format = '%su%=on %ti by %au %ma%in'
let g:gina#command#blame#formatter#timestamp_format1 = '%Y-%m-%d'
let g:gina#command#blame#formatter#timestamp_format2 = '%Y-%m-%d'
let g:gina#command#blame#formatter#timestamp_months = 0
call gina#custom#command#option('blame', '--width', '90')
call gina#custom#mapping#nmap('blame', 'j', 'j<Plug>(gina-blame-echo)')
call gina#custom#mapping#nmap('blame', 'k', 'k<Plug>(gina-blame-echo)')
call gina#custom#mapping#nmap('blame', '<CR>', ':call gina#action#call(''show:commit:tab'')<CR>', s:noremap_silent)

" diff
call gina#custom#mapping#nmap('/\%(diff\|commit\)', 'sgj', ':call notomo#vimrc#to_next_syntax(''diffLine'', 1, 1)<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('/\%(diff\|commit\)', 'sgk', ':call notomo#vimrc#to_previous_syntax(''diffLine'', 1, -1)<CR>', s:noremap_silent)

" status
call gina#custom#mapping#nmap('status', 'j', ':call notomo#vimrc#to_next_syntax(''\vAnsi+'', 10, 0)<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('status', 'k', ':call notomo#vimrc#to_previous_syntax(''\vAnsi+'', 10, 0)<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('status', 'gg', 'gg:call notomo#vimrc#to_next_syntax(''\vAnsi+'', 10, 0)<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('status', 'G', 'G:call notomo#vimrc#to_previous_syntax(''\vAnsi+'', 10, 0)<CR>', s:noremap_silent)

" log
let g:gina#command#log#use_default_mappings = 0
call gina#custom#mapping#nmap('log', '<CR>', ':call gina#action#call(''show:commit:right'')<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('log', 'RS', '<Plug>(gina-commit-reset)', s:silent)
" call gina#custom#mapping#nmap('log', 'RESET', ':call gina#action#call(''commit:reset:hard'')<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('log', 'ch', ':call gina#action#call(''commit:checkout'')<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('log', 'T', ':call gina#action#call(''commit:tag:lightweight'')<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('log', 'I', ':call notomo#gina#rebase_i()<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('log', 'F', ':call notomo#gina#fixup()<CR>', s:noremap_silent)

" tag
call gina#custom#mapping#nmap('tag', 'DD', ':call gina#action#call(''tag:delete'')<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('tag', 'C', ':call gina#action#call(''tag:new:lightweight'')<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('tag', 'P', 'notomo#gina#tag_push_command()', {'noremap':1, 'expr': 1})

let g:gina#core#console#enable_message_history = 1
