
set tabline=%!MakeTabLine()

function! MakeTabLine() "{{{
  let titles = map(range(1, tabpagenr("$")), "s:tabpage_label(v:val)")
  let tabline_str = join(titles, "") . "%#TabLineFill#%T"
  return tabline_str
endfunction "}}}

function! s:tabpage_label(tab_num) "{{{
    let tab_bufs = tabpagebuflist(a:tab_num)
    let curbuf_num = tab_bufs[tabpagewinnr(a:tab_num) - 1]
    let buf_cnt = len(tab_bufs)

    let file_nm = fnamemodify(bufname(curbuf_num), ":t")
    if file_nm ==# "[Command Line]"
        let file_nm = expand("#")
        let buf_cnt -= 1
    endif
    let file_nm = file_nm == "" ? "NONE" : file_nm

    if getbufvar(curbuf_num, "&modified")
        let is_mod_str = "+"
    elseif buf_cnt == 1
        let is_mod_str = ""
        let buf_cnt = ""
    else
        let is_mod_tab = len(filter(copy(tab_bufs), "getbufvar(v:val, '&modified')"))
        let is_mod_str = is_mod_tab ? "(+)" : ""
    endif

    let option_str = buf_cnt . is_mod_str
    let label = option_str == "" ? file_nm : file_nm . "[" . option_str . "]"

    let hi_type = a:tab_num == tabpagenr() ? "%#TabLineSel#" : "%#TabLine#"

    return "%" . a:tab_num . "T" . join([hi_type, label, "%T%#TabLineFill#"], " ")
endfunction "}}}
