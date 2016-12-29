" window"{{{
" move"{{{
let s:NNOREMAP = "nnoremap"
let s:NMAP = "nmap"
function! s:set_pfx(pfx, key) abort
    silent execute join([s:NNOREMAP, a:key, "<Nop>"])
    silent execute join([s:NMAP, a:pfx, a:key])
endfunction
let s:WINMV_PFX = "m"
let s:WINMV_KEY = "[winmv]"
call s:set_pfx(s:WINMV_PFX, s:WINMV_KEY)
function! s:winmv_map(lhs, rhs) abort
    silent execute join([s:NNOREMAP, s:WINMV_KEY . a:lhs, a:rhs])
endfunction

call s:winmv_map("a", "<C-w>h") " left
call s:winmv_map("j", "<C-w>j") " down
call s:winmv_map("x", "<C-w>j") " down
call s:winmv_map("k", "<C-w>k") " up
call s:winmv_map("w", "<C-w>k") " up
call s:winmv_map("l", "<C-w>l") " right
call s:winmv_map("n", "<C-w><C-w>") " next
call s:winmv_map("p", "<C-w>p") " previous
call s:winmv_map("s", "<C-w>r") " swap
"}}}

" split"{{{
let s:WIN_PFX = "<Space>s"
let s:WIN_KEY = "[win]"
call s:set_pfx(s:WIN_PFX, s:WIN_KEY)
function! s:win_map(lhs, rhs) abort
    silent execute join([s:NNOREMAP, s:WIN_KEY . a:lhs, a:rhs])
endfunction

call s:win_map("h", ":<C-u>split<CR>") " split horizontally
call s:win_map("v", ":<C-u>vsplit<CR>") " split vertically
call s:win_map("o", ":<C-u>only<CR>") " close others
call s:win_map("p", "<C-w>z") " close preview
"}}}

" change size"{{{
let s:WINSIZE_PFX = s:WINMV_PFX . "m"
let s:WINSIZE_MODE_NM = "winsize"
let s:WINSIZE_KEY = "[" . s:WINSIZE_MODE_NM . "]"
nnoremap [winsize] <Nop>
silent execute join(["nmap", s:WINSIZE_PFX, s:WINSIZE_KEY])

try
    call submode#current()
    let s:submode_enable = 1
catch
    let s:submode_enable = 0
endtry
if s:submode_enable
    function! s:winsize_map(lhs, rhs) abort
        call submode#enter_with(s:WINSIZE_MODE_NM, "n", "", s:WINSIZE_PFX . a:lhs, a:rhs)
        call submode#map(s:WINSIZE_MODE_NM, "n", "", a:lhs, a:rhs)
    endfunction
    call submode#leave_with(s:WINSIZE_MODE_NM, "n", "", "j")
else
    function! s:winsize_map(lhs, rhs) abort
        silent execute join([s:NNOREMAP, s:WINSIZE_KEY . a:lhs, a:rhs])
    endfunction
endif
call s:winsize_map("a", "<C-w>>") " increace width
call s:winsize_map("z", "<C-w><") " decreace width
call s:winsize_map("h", "<C-w>+") " increace height
call s:winsize_map("l", "<C-w>-") " decreace height

" equalize
nnoremap [winsize]e <C-w>=
" maximize
nnoremap [winsize]m :<C-u>SM 4<CR>
"}}}
"}}}
