
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
