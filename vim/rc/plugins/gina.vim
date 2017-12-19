nnoremap [git]s :<C-u>Gina status<CR>
nnoremap [git]D :<C-u>Gina diff<CR>
nnoremap [git]b :<C-u>Gina branch<CR>
nnoremap [git]L :<C-u>Gina log master...HEAD<CR>
nnoremap [git]ll :<C-u>Gina log<CR>
nnoremap [git]rl :<C-u>Gina reflog<CR>
nnoremap [git]ls :<C-u>Gina ls<CR>
nnoremap [git]c :<C-u>Gina commit<CR>
nnoremap [git]xl :<C-u>Gina stash list<CR>
nnoremap [git]xs :<C-u>Gina stash save ""<Left>
nnoremap [git]xc :<C-u>Gina stash show<CR>
nnoremap <expr> [git]P ':<C-u>Gina! push origin ' . gina#component#repo#branch()
nnoremap <expr> [git]H ':<C-u>Gina! pull origin ' . gina#component#repo#branch()
nnoremap [git]M :<C-u>Gina! merge<Space>
nnoremap [git]F :<C-u>Gina! fetch<Space>
nnoremap [git]ma :<C-u>Gina! merge --abort
nnoremap [git]ca :<C-u>Gina! cherry-pick --abort

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
    call gina#custom#mapping#map('status', 't<Space>', ':call gina#action#call(''edit:tab'')<CR>', s:noremap_mode_silent)
    call gina#custom#mapping#map('status', 'o', ':call gina#action#call(''edit:rightest'')<CR>', s:noremap_mode_silent)

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
call gina#custom#mapping#nmap('status', 'P', ':call gina#action#call(''patch:tab'')<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('status', 'pp', ':call gina#action#call(''patch:oneside:tab'')<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('status', '<CR>', ':call gina#action#call(''edit:tab'')<CR>', s:noremap_silent)

" commit
call gina#custom#command#option('commit', '-v|--verbose')

" compare diff
call gina#custom#mapping#nmap('/\%(status\|stash\)', 'dd', '<Plug>(gina-compare)', s:silent)
call gina#custom#mapping#nmap('/\%(status\|stash\|compare\)', 'D', '<Plug>(gina-diff)', s:silent)

" stash
call gina#custom#mapping#nmap('stash', 'ap', '<Plug>(gina-stash-apply)', s:silent)
call gina#custom#mapping#nmap('stash', 'pop', '<Plug>(gina-stash-pop)', s:silent)
call gina#custom#mapping#nmap('stash', '<CR>', ':call gina#action#call(''stash:show'')<CR>', s:noremap_silent)

" branch
call gina#custom#mapping#nmap('branch', 'rn', '<Plug>(gina-branch-move)', s:silent)
" call gina#custom#mapping#nmap('branch', 'dl', '<Plug>(gina-branch-delete)', s:silent)
call gina#custom#mapping#nmap('branch', 'rf', '<Plug>(gina-branch-reflesh)', s:silent)
call gina#custom#mapping#nmap('branch', 'C', '<Plug>(gina-branch-new)', s:silent)
call gina#custom#command#option('branch', '-v', 'v')
call gina#custom#mapping#nmap('branch', 'yn', '<Plug>(gina-yank-rev)', s:silent)
call gina#custom#mapping#nmap('branch', 'co', ':call gina#action#call(''show:commit:tab'')<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('branch', 'MA', ':call gina#action#call(''commit:merge'')<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('branch', 'cp', ':call gina#action#call(''commit:cherry-pick'')<CR>', s:noremap_silent)

" group
call gina#custom#command#option('show', '--group', 'show')

" opener
call gina#custom#command#option('/\%(status\|changes\|ls\|commit\)', '--opener', 'botright split')
call gina#custom#command#option('/\%(diff\|blame\|compare\|patch\|log\)', '--opener', 'tabedit')

" blame
let g:gina#command#blame#timestamper#format1 = '%Y-%m-%d'
let g:gina#command#blame#timestamper#format2 = '%Y-%m-%d'
call gina#custom#command#option('blame', '--width', '90')
call gina#custom#mapping#nmap('blame', 'j', 'j<Plug>(gina-blame-echo)')
call gina#custom#mapping#nmap('blame', 'k', 'k<Plug>(gina-blame-echo)')

" diff
call gina#custom#mapping#nmap('diff', 'sgj', ':call notomo#vimrc#to_next_syntax(''diffLine'', 1)<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('diff', 'sgk', ':call notomo#vimrc#to_previous_syntax(''diffLine'', -1)<CR>', s:noremap_silent)

" log
let g:gina#command#log#use_default_mappings = 0
call gina#custom#mapping#nmap('log', '<CR>', ':call gina#action#call(''show:commit:right'')<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('log', 'o', ':call gina#action#call(''show'')<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('log', 't<Space>', ':call gina#action#call(''show:tab'')<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('log', 'cc', '<Plug>(gina-changes-of)', s:silent)
call gina#custom#mapping#nmap('log', 'cf', '<Plug>(gina-changes-from)', s:silent)
call gina#custom#mapping#nmap('log', 'cb', '<Plug>(gina-changes-between)', s:silent)
call gina#custom#mapping#nmap('log', 'RS', '<Plug>(gina-commit-reset)', s:silent)
call gina#custom#mapping#nmap('log', 'yr', '<Plug>(gina-yank-rev)', s:silent)
call gina#custom#mapping#nmap('log', 'dd', ':call gina#action#call(''compare'')<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('log', 'RESET', ':call gina#action#call(''commit:reset:hard'')<CR>', s:noremap_silent)
call gina#custom#mapping#nmap('log', 'cp', ':call gina#action#call(''commit:cherry-pick'')<CR>', s:noremap_silent)
