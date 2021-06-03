nnoremap [exec] <Nop>
nmap <Space>x [exec]
nnoremap [exec]r <Cmd>source ~/dotfiles/vscode/neovim.vim<CR><Cmd>echomsg 'reloaded'<CR>
nnoremap [exec]R <Cmd>call VSCodeNotify("workbench.action.reloadWindow")<CR>
nnoremap [exec]f <Cmd>call VSCodeNotify("workbench.action.toggleSidebarVisibility")<CR>
nnoremap [exec]m <Cmd>call VSCodeNotify("markdown.showPreviewToSide")<CR>

nnoremap k gk
nnoremap j gj
xnoremap k gk
xnoremap j gj

nnoremap ge $
xnoremap ge $
onoremap ge $
nnoremap ga ^
xnoremap ga ^
onoremap ga ^
nnoremap gh 0
xnoremap gh 0
onoremap gh 0
nnoremap gz G
xnoremap gz G
onoremap gz G

onoremap gp ])
xnoremap gp ])h
onoremap gd ]}
xnoremap gd ]}h
onoremap gl t]
onoremap gs t"
onoremap gb t`
onoremap gq t'
onoremap gx t*
onoremap gt t>
onoremap g; t;
onoremap g, t,
onoremap g. t.
onoremap gc t:
onoremap gP t(

nnoremap go <Cmd>call VSCodeNotify("workbench.action.navigateBack")<CR>
nnoremap gi <Cmd>call VSCodeNotify("workbench.action.navigateForward")<CR>

xnoremap <S-j> }
xnoremap <S-k> {
" remap for matchit
xmap <S-l> %
nnoremap <silent> <S-l> <Cmd>keepjumps normal %<CR>

nnoremap <silent> <S-j> <Cmd>keepjumps normal! }<CR>
nnoremap <silent> <S-k> <Cmd>keepjumps normal! {<CR>

nnoremap [newline] <Nop>
nmap o [newline]
nnoremap <silent> [newline]o <Cmd>for i in range(v:count1) \| call append(line('.'), '') \| endfor<CR>
nnoremap <silent> [newline]j <Cmd>for i in range(v:count1) \| call append(line('.'), '') \| execute 'normal! j' \| endfor<CR>


nnoremap [arith] <Nop>
xnoremap [arith] <Nop>
nmap <Space>a [arith]
xmap <Space>a [arith]

function! s:inc_or_dec(is_inc) abort
    let key = a:is_inc ? "\<C-a>" : "\<C-x>"
    let line = getline('.')
    let col = col('.')
    let pattern = '\v\d+\ze[^[:digit:]]*$'
    if matchend(line[col - 1:], pattern) == -1
        let idx = matchend(line[:col - 1], pattern)
        if idx != -1
            return printf('%dh%s', col - idx, key)
        endif
    endif
    return key
endfunction
nnoremap <expr> [arith]j <SID>inc_or_dec(v:false)
nnoremap <expr> [arith]k <SID>inc_or_dec(v:true)
xnoremap [arith]j <C-x>gv
xnoremap [arith]k <C-a>gv
xnoremap [arith]d g<C-x>gv
xnoremap [arith]u g<C-a>gv

nnoremap [file] <Nop>
nmap <Space>f [file]
nnoremap [file]w <Cmd>call VSCodeNotify("workbench.action.files.save")<CR>

nnoremap x "_x
xnoremap x "_x

nnoremap [operator] <Nop>
nmap <Space><Leader> [operator]
xnoremap [operator] <Nop>
xmap <Space><Leader> [operator]
nnoremap [operator]x "_d
xnoremap [operator]x "_d

nnoremap ;  :
nnoremap :  ;
xnoremap ;  :
xnoremap :  ;

function! s:ia_vonoremap(lhs, rhs) abort
    let inner_lhs = 'i' . a:lhs
    let inner_rhs = 'i' . a:rhs
    let around_lhs = 'a' . a:lhs
    let around_rhs = 'a' . a:rhs
    silent execute join(['xnoremap', inner_lhs, inner_rhs])
    silent execute join(['onoremap', inner_lhs, inner_rhs])
    silent execute join(['xnoremap', around_lhs, around_rhs])
    silent execute join(['onoremap', around_lhs, around_rhs])
endfunction
call s:ia_vonoremap('o', 'p')
call s:ia_vonoremap(';', 'w')
call s:ia_vonoremap('<Space>', 'W')
call s:ia_vonoremap('t', '>')
call s:ia_vonoremap('T', 't')
call s:ia_vonoremap('p', ')')
call s:ia_vonoremap('l', ']')
call s:ia_vonoremap('w', '"')
call s:ia_vonoremap('q', "'")
call s:ia_vonoremap('d', '}')
call s:ia_vonoremap('b', '`')

nnoremap [winmv] <Nop>
nmap m [winmv]

nnoremap [winmv]a <Cmd>call VSCodeNotify("workbench.action.navigateLeft")<CR>
nnoremap [winmv]x <Cmd>call VSCodeNotify("workbench.action.navigateDown")<CR>
nnoremap [winmv]w <Cmd>call VSCodeNotify("workbench.action.navigateUp")<CR>
nnoremap [winmv]l <Cmd>call VSCodeNotify("workbench.action.navigateRight")<CR>

nnoremap [win] <Nop>
nmap <Space>w [win]

nnoremap [win]v <Cmd>call VSCodeNotify("workbench.action.splitEditorLeft")<CR>
nnoremap [win]o <Cmd>only<CR>

nnoremap [term] <Nop>
nmap <Space>t [term]

nnoremap [term]o <Cmd>call VSCodeCall("terminal.focus")<CR>
nnoremap [term]v <Cmd>call VSCodeCall("terminal.focus")<CR><Cmd>call VSCodeNotify("workbench.action.positionPanelLeft")<CR><Cmd>call VSCodeCall("terminal.focus")<CR>
nnoremap [term]V <Cmd>call VSCodeCall("terminal.focus")<CR><Cmd>call VSCodeNotify("workbench.action.positionPanelLeft")<CR><Cmd>call VSCodeCall("terminal.focus")<CR><Cmd>call VSCodeNotify("workbench.action.terminal.sendSequence", {'text': "nvim\n"})<CR>

nnoremap T <Cmd>call VSCodeNotify("workbench.action.toggleMaximizedPanel")<CR>

nnoremap [tab] <Nop>
nmap t [tab]

nnoremap [tab]q <Cmd>call VSCodeNotify("workbench.action.closeActiveEditor")<CR>
nnoremap [tab]o <Cmd>call VSCodeNotify("workbench.action.closeOtherEditors")<CR>
nnoremap [tab]l <Cmd>call VSCodeNotify("workbench.action.nextEditorInGroup")<CR>
nnoremap [tab]a <Cmd>call VSCodeNotify("workbench.action.previousEditorInGroup")<CR>

nnoremap [keyword] <Nop>
nmap <Space>k [keyword]

nnoremap [keyword]o <Cmd>call VSCodeNotify("editor.action.revealDefinition")<CR>
nnoremap [keyword]k <Cmd>call VSCodeNotify("editor.action.showHover")<CR>

" TODO
" escape
" search
" substitute
" jump to next/prev problem
" live share
" plugin
