" window"{{{
" move"{{{
let s:NNOREMAP = 'nnoremap'
let s:NMAP = 'nmap'
function! s:set_pfx(pfx, key) abort
    silent execute join([s:NNOREMAP, a:key, '<Nop>'])
    silent execute join([s:NMAP, a:pfx, a:key])
endfunction
let s:WINMV_PFX = 'm'
let s:WINMV_KEY = '[winmv]'
call s:set_pfx(s:WINMV_PFX, s:WINMV_KEY)
function! s:winmv_map(lhs, rhs) abort
    silent execute join([s:NNOREMAP, s:WINMV_KEY . a:lhs, a:rhs])
endfunction

call s:winmv_map('a', '<C-w>h') " left
call s:winmv_map('j', '<C-w>j') " down
call s:winmv_map('x', '<C-w>j') " down
call s:winmv_map('k', '<C-w>k') " up
call s:winmv_map('w', '<C-w>k') " up
call s:winmv_map('l', '<C-w>l') " right
call s:winmv_map('n', '<C-w><C-w>') " next
call s:winmv_map('p', '<C-w>p') " previous
call s:winmv_map('s', '<C-w>r') " swap
"}}}

" split"{{{
let s:WIN_PFX = '<Space>w'
let s:WIN_KEY = '[win]'
call s:set_pfx(s:WIN_PFX, s:WIN_KEY)
function! s:win_map(lhs, rhs) abort
    silent execute join([s:NNOREMAP, s:WIN_KEY . a:lhs, a:rhs])
endfunction

function! s:xonly(directions_str) abort
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
function! s:vonly() abort
    call s:xonly('jk')
endfunction
function! s:ronly() abort
    call s:xonly('l')
endfunction
function! s:lonly() abort
    call s:xonly('h')
endfunction

function! s:vsplit_from_tab(tab_num) abort
    if tabpagenr() == a:tab_num || tabpagenr('$') < a:tab_num || 1 > a:tab_num
        return
    endif
    let tab_bufs = tabpagebuflist(a:tab_num)
    vsplit
    execute 'buffer ' . tab_bufs[0]
    for tb in tab_bufs[1:]
        split
        execute 'buffer ' . tb
    endfor
    execute a:tab_num . 'tabclose'
    execute 'normal! <C-w>='
endfunction
function! s:vs_from_left() abort
    call s:vsplit_from_tab(tabpagenr() - 1)
endfunction
function! s:vs_from_right() abort
    call s:vsplit_from_tab(tabpagenr() + 1)
endfunction

function! s:h_to_vsplit() abort
    let curbuf = bufnr('%')
    let tab_bufs = uniq(tabpagebuflist())
    only
    for b in tab_bufs
        if b != curbuf
            execute 'buffer ' . b
            vsplit
        endif
    endfor
    execute 'buffer ' . curbuf
    execute 'normal! <C-w>='
endfunction

function! s:extract_tabopen() abort
    let tab_bufs = tabpagebuflist()
    if len(tab_bufs) < 2
        return
    endif
    let curbuf_num = bufnr('%')
    noautocmd q
    tabnew
    execute 'buffer ' . curbuf_num
endfunction

call s:win_map('h', ':<C-u>split<CR>') " split horizontally
call s:win_map('v', ':<C-u>vsplit<CR>') " split vertically
call s:win_map('o', ':<C-u>only<CR>') " close others
call s:win_map('j', ':<C-u>call <SID>vonly()<CR>') " close others vertically
call s:win_map(';', ':<C-u>call <SID>ronly()<CR>') " close right vertically
call s:win_map('a', ':<C-u>call <SID>lonly()<CR>') " close left windows
call s:win_map('p', '<C-w>z') " close preview
call s:win_map('q', ':<C-u>q<CR>') " close
call s:win_map('H', ':<C-u>call <SID>vs_from_left()<CR>') " open left tab's buffers vertically
call s:win_map('L', ':<C-u>call <SID>vs_from_right()<CR>') " open right tab's buffers vertically
call s:win_map('V', ':<C-u>call <SID>h_to_vsplit()<CR>') " reopen windows vertically
call s:win_map('l', ':<C-u>call <SID>extract_tabopen()<CR>') " close window and open tab
"}}}

" winsize"{{{
let s:winsize_enter = 'i'
silent execute join([s:NNOREMAP, s:WIN_KEY . s:winsize_enter, ":<C-u>call tmno3#window#setup_submode('" . s:WIN_KEY . "','" . s:winsize_enter . "')<CR>"])

" equalize
nnoremap [win]e <C-w>=
" maximize
nnoremap [win]m :<C-u>SM 4<CR>
"}}}
"}}}
