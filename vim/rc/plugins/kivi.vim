
nnoremap [exec]f <Cmd>lua require("kivi").open({layout = "vertical", new = true})<CR>

autocmd MyAuGroup FileType kivi-* call s:kivi()
function! s:kivi() abort
    nnoremap <buffer> t<Space> <Cmd>lua require("kivi").execute("tab_open", {quit = not require("kivi").is_parent()})<CR>
    nnoremap <buffer> sv <Cmd>lua require("kivi").execute("vsplit_open", {quit = not require("kivi").is_parent()})<CR>
    nnoremap <buffer> D <Cmd>lua require("kivi").execute("debug_print")<CR>
    nnoremap <buffer> yr <Cmd>lua require("kivi").execute("yank")<CR>
    nnoremap <buffer> B <Cmd>lua require("kivi").execute("back")<CR>
    nnoremap <buffer> rn <Cmd>lua require("kivi").execute("rename")<CR>
    nnoremap <buffer> o <Cmd>lua require("kivi").execute("toggle_tree")<CR>
    nnoremap <buffer> <2-LeftMouse> <Cmd>lua require("kivi").execute("child")<CR>
    nnoremap <buffer> sm <Cmd>lua require("kivi").execute("toggle_selection")<CR>j
    xnoremap <buffer> sm <Cmd>lua require("kivi").execute("toggle_selection")<CR>

lua << EOF
local gesture = require('gesture')
gesture.register({
    name = "go to the parent",
    buffer = "%",
    inputs = { gesture.left() },
    action = "lua require('kivi').execute('parent')"
})
EOF
endfunction

autocmd MyAuGroup FileType kivi-file call s:kivi_file()
function! s:kivi_file() abort
    nnoremap <buffer> <Space>g <Cmd>lua require("kivi").open({source_opts = {target = "project"}})<CR>
    nnoremap <buffer> <Space>h <Cmd>lua require("kivi").open({path = "~"})<CR>
    nnoremap <nowait> <buffer> <Space>r <Cmd>lua require("kivi").open({path = "/tmp"})<CR>
    nnoremap <buffer> df <Cmd>lua require("kivi").execute("delete")<CR>
    nnoremap <buffer> xf <Cmd>lua require("kivi").execute("cut")<CR>
    nnoremap <buffer> yf <Cmd>lua require("kivi").execute("copy")<CR>
    nnoremap <buffer> p <Cmd>lua require("kivi").execute("paste")<CR>
    nnoremap <buffer> i <Cmd>lua require("kivi").execute("create")<CR>
endfunction

autocmd MyAuGroup BufRead */kivi-renamer,*/kivi-creator call s:kivi_input()
function! s:kivi_input() abort
    nnoremap <nowait> <buffer> q <Cmd>quit!<CR>
    inoremap <buffer> jq <ESC><Cmd>quit!<CR>
endfunction
