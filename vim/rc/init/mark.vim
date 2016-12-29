" mark"{{{
nnoremap [mark] <Nop>
vnoremap [mark] <Nop>
nmap <Leader>m [mark]
vmap <Leader>m [mark]

" マーク関連の初期化"{{{
if !exists('g:mark_chars')
    let g:mark_chars = split("abcdefghijklmnopqrstuvwxyz", "\\zs")
endif
"}}}

" マークの情報"{{{
let s:START_LINE_KEY = "sl"
let s:START_CHAR_KEY = "sc"
let s:END_LINE_KEY = "el"
let s:END_CHAR_KEY = "ec"
function! s:mark_info() abort
    let start_pos = line("$")
    let end_pos = 1
    let start_char = ""
    let end_char = ""
    for c in g:mark_chars
        let line_num = line("'" . c)
        if line_num == 0
            continue
        endif
        if line_num <= start_pos
            let start_pos = line_num
            let start_char = c
        endif
        if line_num >= end_pos
            let end_pos = line_num
            let end_char = c
        endif
    endfor
    return {s:START_LINE_KEY : start_pos, s:START_CHAR_KEY : start_char, s:END_LINE_KEY : end_pos, s:END_CHAR_KEY : end_char}
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
    if info[s:END_CHAR_KEY] != "" && line(".") >= info[s:END_LINE_KEY]
        return "\'" . info[s:START_CHAR_KEY]
    elseif info[s:END_CHAR_KEY] != ""
        return "]\'"
    endif
endfunction
"}}}

" 前のマークへ移動する"{{{
nnoremap <expr> <silent> [mark]r <SID>jump_to_previous_mark()
vnoremap <expr> <silent> [mark]r <SID>jump_to_previous_mark()
function! s:jump_to_previous_mark() abort
    let info = s:mark_info()
    if info[s:START_CHAR_KEY] != "" && line(".") <= info[s:START_LINE_KEY]
        return "\'" . info[s:END_CHAR_KEY]
    elseif info[s:START_CHAR_KEY] != ""
        return "[\'"
    endif
endfunction
"}}}

" 全てのマークを削除する"{{{
nnoremap <silent> [mark]d :<C-u>call <SID>delete_all_mark()<CR>
function! s:delete_all_mark() abort
    delmark!
    let b:mark_index = -1
    echomsg "deleted all marks"
endfunction
"}}}

" 指定のマークへジャンプする
nnoremap [mark]g '
vnoremap [mark]g '
"}}}
