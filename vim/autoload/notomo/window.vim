
function! notomo#window#xonly(directions_str) abort
    let curwin_id = win_getid()
    let cnt = len(tabpagebuflist())
    for d in split(a:directions_str, '\zs')
        while cnt > 1
            execute 'noautocmd wincmd ' . d
            if win_getid() == curwin_id
                break
            endif
            q
            let cnt -= 1
        endwhile
    endfor
endfunction
function! notomo#window#vonly() abort
    call notomo#window#xonly('jk')
endfunction
function! notomo#window#ronly() abort
    call notomo#window#xonly('l')
endfunction
function! notomo#window#lonly() abort
    call notomo#window#xonly('h')
endfunction

function! notomo#window#vsplit_from_tab(tab_num) abort
    if tabpagenr() == a:tab_num || tabpagenr('$') < a:tab_num || 1 > a:tab_num
        return
    endif
    let cur_tab = tabpagenr()
    execute 'noautocmd tabnext ' . a:tab_num
    let buf_num = &filetype ==? 'defx' ? bufnr('#') : bufnr('%')
    let curpos = getpos('.')
    execute 'noautocmd tabnext ' . cur_tab
    if buf_num == -1
        return
    endif
    vsplit
    execute "noautocmd normal! \<C-w>l"
    execute 'noautocmd buffer ' . buf_num
    call setpos('.', curpos)
    execute "noautocmd normal! \<C-w>h"
    execute a:tab_num . 'tabclose'
    execute 'normal! <C-w>='
endfunction
function! notomo#window#vs_from_left() abort
    call notomo#window#vsplit_from_tab(tabpagenr() - 1)
endfunction
function! notomo#window#vs_from_right() abort
    call notomo#window#vsplit_from_tab(tabpagenr() + 1)
endfunction

function! notomo#window#extract_tabopen() abort
    let tab_bufs = tabpagebuflist()
    if len(tab_bufs) < 2
        return
    endif
    let curbuf_num = bufnr('%')
    tabnew
    noautocmd tabprevious
    noautocmd q
    noautocmd tabnext
    execute 'buffer ' . curbuf_num
endfunction

function! notomo#window#vsplit_altopen() abort
    let alt_bufnr = bufnr('#')
    if alt_bufnr == -1
        return
    endif
    vsplit
    execute 'buffer ' . alt_bufnr
endfunction

function! notomo#window#duplicate() abort
    vsplit
    call notomo#window#extract_tabopen()
endfunction
