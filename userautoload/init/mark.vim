
nnoremap [mark] <Nop>
nmap <Leader>m [mark]

" マーク関連の初期化"{{{
if !exists('g:mark_chars')
    let g:mark_chars = [
    \     'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
    \     'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
    \ ]
endif

function! s:initialize_loop_mark() abort
    if !exists('b:mark_start_pos')
        let mark_start_pos = line("$")
        let mark_end_pos = 1
        let mark_start_char = ""
        let mark_end_char = ""
        for c in g:mark_chars
            let line_num = line("'" . c)
            if line_num != 0 && line_num <= mark_start_pos
                let mark_start_pos = line_num
                let mark_start_char = c
            endif
            if line_num >= mark_end_pos
                let mark_end_pos = line_num
                let mark_end_char = c
            endif
        endfor
        let b:mark_start_pos = mark_start_pos
        let b:mark_start_char = mark_start_char
        let b:mark_end_pos = mark_end_pos
        let b:mark_end_char = mark_end_char
    endif
endfunction
"}}}

" マークをセットする"{{{
nnoremap [mark]s :<C-u>call <SID>set_mark()<CR>
function! s:set_mark()
    if !exists('b:mark_index')
        let b:mark_index = 0
    else
        let b:mark_index = (b:mark_index + 1) % len(g:mark_chars)
    endif
    let line_num = line(".")
    let mark_char = g:mark_chars[b:mark_index]
    execute 'mark' mark_char
    call s:initialize_loop_mark()
    if line_num <= b:mark_start_pos
        let b:mark_start_pos = line_num
        let b:mark_start_char = mark_char
    endif
    if line_num >= b:mark_end_pos
        let b:mark_end_pos = line_num
        let b:mark_end_char = mark_char
    endif
    echomsg 'marked' mark_char
endfunction
"}}}

" 次のマークへ移動する"{{{
nnoremap <silent> [mark]x :<C-u>call <SID>jump_to_next_mark()<CR>
function! s:jump_to_next_mark() abort
    call s:initialize_loop_mark()
    let line_num = line(".")
    if b:mark_end_char != "" && line_num >= b:mark_end_pos
        execute "normal " . b:mark_start_pos . "gg"
    elseif b:mark_end_char != ""
        normal ]'
    endif
endfunction
"}}}

" 前のマークへ移動する"{{{
nnoremap <silent> [mark]r :<C-u>call <SID>jump_to_previous_mark()<CR>
function! s:jump_to_previous_mark() abort
    call s:initialize_loop_mark()
    let line_num = line(".")
    if b:mark_start_char != "" && line_num <= b:mark_start_pos
        execute "normal " . b:mark_end_pos . "gg"
    elseif b:mark_start_char != ""
        normal ['
    endif
endfunction
"}}}

" 全てのマークを削除する"{{{
nnoremap [mark]d :<C-u>call <SID>delete_all_mark()<CR>
function! s:delete_all_mark() abort
    let b:mark_start_pos = line("$")
    let b:mark_end_pos = 1
    let b:mark_start_char = ""
    let b:mark_end_char = ""
    delmark!
endfunction
"}}}

" 指定のマークへジャンプする
nnoremap [mark]g '
