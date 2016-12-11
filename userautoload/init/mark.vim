
nnoremap [mark] <Nop>
vnoremap [mark] <Nop>
nmap <Leader>m [mark]
vmap <Leader>m [mark]

" マーク関連の初期化"{{{
if !exists('g:mark_chars')
    let g:mark_chars = [
    \     'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
    \     'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
    \ ]
endif
"}}}

function! s:mark_info() abort
    let mark_start_pos = line("$")
    let mark_end_pos = 1
    let mark_start_char = ""
    let mark_end_char = ""
    for c in g:mark_chars
        let line_num = line("'" . c)
        if line_num == 0
            continue
        endif
        if line_num <= mark_start_pos
            let mark_start_pos = line_num
            let mark_start_char = c
        endif
        if line_num >= mark_end_pos
            let mark_end_pos = line_num
            let mark_end_char = c
        endif
    endfor
    return {"start_line" : mark_start_pos, "start_char" : mark_start_char, "end_line" : mark_end_pos, "end_char" : mark_end_char}
endfunction

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
    echomsg 'marked' mark_char
endfunction
"}}}

" 次のマークへ移動する"{{{
nnoremap <expr> <silent> [mark]x <SID>jump_to_next_mark()
vnoremap <expr> <silent> [mark]x <SID>jump_to_next_mark()
function! s:jump_to_next_mark() abort
    let info = s:mark_info()
    let line_num = line(".")
    if info["end_char"] != "" && line_num >= info["end_line"]
        let jump_to_start_mark = "\'" . info["start_char"]
        return jump_to_start_mark
    elseif info["end_char"] != ""
        return "]\'"
    endif
endfunction
"}}}

" 前のマークへ移動する"{{{
nnoremap <expr> <silent> [mark]r <SID>jump_to_previous_mark()
vnoremap <expr> <silent> [mark]r <SID>jump_to_previous_mark()
function! s:jump_to_previous_mark() abort
    let info = s:mark_info()
    let line_num = line(".")
    if info["start_char"] != "" && line_num <= info["start_line"]
        let jump_to_end_mark = "\'" . info["end_char"]
        return jump_to_end_mark
    elseif info["start_char"] != ""
        return "[\'"
    endif
endfunction
"}}}

" 全てのマークを削除する"{{{
nnoremap <silent> [mark]d :<C-u>call <SID>delete_all_mark()<CR>
function! s:delete_all_mark() abort
    let mark_start_pos = line("$")
    let mark_end_pos = 1
    let mark_start_char = ""
    let mark_end_char = ""
    delmark!
    echomsg "deleted all marks"
endfunction
"}}}

" 指定のマークへジャンプする
nnoremap [mark]g '
vnoremap [mark]g '

