" tab"{{{
let s:TAB_MODE_NM = 'tab'
let s:TAB_KEY = '[' . s:TAB_MODE_NM . ']'
let s:TAB_PFX = 't'
let s:TABMV_PFX = 'm'
let s:NNOREMAP = 'nnoremap'
let s:NMAP = 'nmap'
silent execute join([s:NNOREMAP, s:TAB_KEY, '<Nop>'])
silent execute join([s:NMAP, s:TAB_PFX, s:TAB_KEY])

" close others
silent execute join([s:NNOREMAP, '<silent>', s:TAB_KEY . 'o', ':<C-u>tabonly<CR>'])

" open new tab"{{{
function! s:new_tab() abort
    tabe | setlocal buftype=nofile noswapfile
endfunction
nnoremap <silent> <Plug>(new_tab) :<C-u>call <SID>new_tab()<CR>
"}}}

" for mouse"{{{
nnoremap <C-Tab> gt
nnoremap <C-S-Tab> gT
inoremap <C-Tab> <Esc>gt
inoremap <C-S-Tab> <Esc>gT
nnoremap <silent> <C-w> :<C-u>call <SID>tabclose_c()<CR>
inoremap <silent> <C-w> <ESC>:<C-u>call <SID>tabclose_c()<CR>
"}}}

" close tab"{{{
function! s:tabclose_c() abort
    if tabpagenr('$') == 1
        qa
    else
        tabclose
    endif
endfunction
nnoremap <silent> <Plug>(tabclose_c) :<C-u>call <SID>tabclose_c()<CR>
"}}}

" close left tabs"{{{
function! s:tabclose_l() abort
    for i in range(2, tabpagenr())
        execute '1tabclose'
    endfor
endfunction
nnoremap <silent> <Plug>(tabclose_l) :<C-u>call <SID>tabclose_l()<CR>
"}}}

" close right tabs"{{{
function! s:tabclose_r() abort
    for i in range(tabpagenr(),tabpagenr('$') - 1)
        execute '$tabclose'
    endfor
endfunction
nnoremap <silent> <Plug>(tabclose_r) :<C-u>call <SID>tabclose_r()<CR>
"}}}

" tab mode"{{{
try
    call submode#current()
    let s:submode_enable = 1
catch
    let s:submode_enable = 0
endtry
if s:submode_enable
    function! s:tab_map(lhs, rhs, map_only, remap) abort
        let remap = a:remap == 1 ? 'r' : ''
        if a:map_only
            let map_type = a:remap == 1 ? s:NMAP : s:NNOREMAP
            silent execute join([map_type, s:TAB_KEY . a:lhs, a:rhs])
        else
            call submode#enter_with(s:TAB_MODE_NM , 'n', remap, s:TAB_PFX . a:lhs, a:rhs)
        endif
        call submode#map(s:TAB_MODE_NM, 'n', remap, a:lhs, a:rhs)
    endfunction
    call submode#leave_with('tab', 'n', '', 'j')
else
    function! s:tab_map(lhs, rhs, map_only, remap) abort
        let map_type = a:remap == 1 ? s:NMAP : s:NNOREMAP
        silent execute join([map_type, s:TAB_KEY . a:lhs, a:rhs])
    endfunction
endif

call s:tab_map('t', '<Plug>(new_tab)', 0, 1) " open new tab
call s:tab_map('l', 'gt', 0, 0) " move right
call s:tab_map('s', ':<C-u>tabr<CR>', 0, 0) " move right end
call s:tab_map('e', ':<C-u>tabl<CR>', 0, 0) " move left end
call s:tab_map('a', 'gT', 0, 0) " move left
call s:tab_map('h', 'gT', 0, 0) " move left
call s:tab_map('q', '<Plug>(tabclose_c)', 0, 1) " close a tab
call s:tab_map('da', '<Plug>(tabclose_l)', 1, 1) " close left tabs
call s:tab_map('dl', '<Plug>(tabclose_r)', 1, 1) " close right tabs
call s:tab_map(s:TABMV_PFX . 'l', ':<C-u>tabm+1<CR>', 0, 0) " move a tab right
call s:tab_map(s:TABMV_PFX . 's', ':<C-u>tabm 0<CR>', 0, 0) " move a tab right end
call s:tab_map(s:TABMV_PFX . 'e', ':<C-u>tabm<CR>', 0, 0) " move a tab left end
call s:tab_map(s:TABMV_PFX . 'a', ':<C-u>tabm-1<CR>', 0, 0) " move a tab left
"}}}
"}}}

" tabline"{{{
set tabline=%!MakeTabLine()

function! MakeTabLine() "{{{
  let titles = map(range(1, tabpagenr('$')), 's:tabpage_label(v:val)')
  let tabline_str = join(titles, '') . '%#TabLineFill#%T'
  return tabline_str
endfunction "}}}

function! s:tabpage_label(tab_num) "{{{
    let tab_bufs = tabpagebuflist(a:tab_num)
    let curbuf_num = tab_bufs[tabpagewinnr(a:tab_num) - 1]
    let buf_cnt = len(tab_bufs)

    let file_nm = fnamemodify(bufname(curbuf_num), ':t')
    if file_nm ==# '[Command Line]'
        let file_nm = expand('#')
        let buf_cnt -= 1
    endif
    let file_nm = file_nm ==? '' ? 'NONE' : file_nm

    if getbufvar(curbuf_num, '&modified')
        let is_mod_str = '+'
    elseif buf_cnt == 1
        let is_mod_str = ''
        let buf_cnt = ''
    else
        let is_mod_tab = len(filter(copy(tab_bufs), "getbufvar(v:val, '&modified')"))
        let is_mod_str = is_mod_tab ? '(+)' : ''
    endif

    let option_str = buf_cnt . is_mod_str
    let label = option_str ==? '' ? file_nm : file_nm . '[' . option_str . ']'

    let hi_type = a:tab_num == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'

    return '%' . a:tab_num . 'T' . join([hi_type, label, '%T%#TabLineFill#'], ' ')
endfunction "}}}
"}}}
