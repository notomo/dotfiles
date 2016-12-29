
set tabline=%!MakeTabLine()

function! MakeTabLine() "{{{
  let titles = map(range(1, tabpagenr("$")), "s:tabpage_label(v:val)")
  let tab_pages = join(titles, "") . "%#TabLineFill#%T"
  return tab_pages
endfunction "}}}

function! s:tabpage_label(current_tab_num) "{{{
    let title = gettabvar(a:current_tab_num, "title")
    if title isnot ""
        return title
    endif

    let current_tab_buffers = tabpagebuflist(a:current_tab_num)
    let current_buffer_num = current_tab_buffers[tabpagewinnr(a:current_tab_num) - 1]

    let current_tab_buffer_count = len(current_tab_buffers)
    let is_modified_current_buffer = getbufvar(current_buffer_num, "&modified")
    if is_modified_current_buffer
        let is_modified_string = "+"
    elseif current_tab_buffer_count is 1
        let is_modified_string = ""
        let current_tab_buffer_count = "" " タブ内バッファ数が1なら表示しない
    else
        let is_modified_current_tab = len(filter(copy(current_tab_buffers), "getbufvar(v:val, '&modified')"))
        if is_modified_current_tab
            let is_modified_string = "(+)"
        else
            let is_modified_string = ""
        endif
    endif

    let count_and_modified_label = current_tab_buffer_count . is_modified_string
    let count_and_modified_label = count_and_modified_label is "" ? "" : "[" . count_and_modified_label . "]"
    let file_name = fnamemodify(bufname(current_buffer_num), ":t")
    let file_name = file_name is "" ? "NONE" : file_name
    let label = file_name . count_and_modified_label

    let hightlight_type = a:current_tab_num is tabpagenr() ? "%#TabLineSel#" : "%#TabLine#"

    return "%" . a:current_tab_num . "T" . join([hightlight_type, label, "%T%#TabLineFill#"], " ")
endfunction "}}}
