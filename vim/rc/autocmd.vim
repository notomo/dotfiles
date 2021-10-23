augroup MyAuGroup
    autocmd!
augroup END

autocmd MyAuGroup BufEnter * call s:auto_cd()
function! s:auto_cd() abort
    try
        lcd `=expand('%:p:h')`
    catch
    endtry
endfunction

autocmd MyAuGroup VimEnter * if @% == '' && s:get_buf_byte() == 0 | setlocal buftype=nofile noswapfile fileformat=unix | endif
function! s:get_buf_byte()
    let byte = line2byte(line('$') + 1)
    return byte == -1 ? 0 : byte - 1
endfunction

autocmd MyAuGroup ColorScheme * call s:define_highlight()
function! s:define_highlight() abort
    highlight Search cterm=NONE guifg=#000000 guibg=#aaccaa
    highlight incSearch cterm=NONE guifg=#fffeeb guibg=#fb8965
    highlight Flashy term=bold ctermbg=0 guifg=#333333 guibg=#a8d2eb
    highlight ParenMatch term=underline cterm=underline guibg=#5f8770
    highlight TabLine guifg=#fff5ee guibg=#536273 gui=none
    highlight YankRoundRegion guifg=#333333 guibg=#fedf81
    highlight def link sqlStatement sqlKeyword
    highlight ZenSpace term=underline ctermbg=DarkGreen guibg=#ab6560
    highlight NormalFloat guibg=#213243

    " for gina status
    highlight AnsiColor1 ctermfg=1 guifg=#ffaaaa
    highlight AnsiColor2 ctermfg=2 guifg=#aaddaa

    highlight clear SpellCap
    highlight def link SpellCap NONE
    highlight clear SpellBad
    highlight SpellBad guifg=#ff5555
    highlight clear SpellRare
    highlight SpellRare guifg=#ff5555
    highlight clear SpellLocal
    highlight SpellLocal guifg=#ff5555

    if has('mac')
        highlight Cursor guibg=#bbbbba
    endif
endfunction

autocmd MyAuGroup BufNewFile,BufRead * set iminsert=0
autocmd MyAuGroup InsertEnter * setlocal nocursorline
autocmd MyAuGroup InsertLeave * setlocal cursorline
autocmd MyAuGroup WinEnter * setlocal cursorline
autocmd MyAuGroup WinLeave * setlocal nocursorline
autocmd MyAuGroup BufRead,BufNewFile */roles/*.yml set filetype=yaml.ansible
autocmd MyAuGroup BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible
autocmd MyAuGroup FileType typescriptreact set filetype=typescript.tsx
autocmd MyAuGroup OptionSet diff setlocal nocursorline
autocmd MyAuGroup WinEnter,InsertLeave * if &diff == 1 | setlocal nocursorline | endif
autocmd MyAuGroup TextYankPost * silent! lua vim.highlight.on_yank({higroup = "Flashy", timeout = 200, on_macro = true, on_visual = true})
