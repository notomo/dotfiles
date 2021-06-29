lua << EOF
require("lreload").enable("thetto", {
  post_hook = function()
    dofile(vim.fn.expand("~/dotfiles/vim/lua/notomo/thetto.lua"))
  end,
})
EOF

lua require("thetto").setup_store("file/mru")

autocmd MyAuGroup FileType thetto call s:thetto_settings()
function! s:thetto_settings() abort
    nnoremap <buffer> <CR> <Cmd>lua require("thetto").execute()<CR>
    nnoremap <buffer> dd <Cmd>lua require("thetto").execute("move_to_input")<CR><Esc><Cmd>silent delete _<CR>
    nnoremap <buffer> cc <Cmd>lua require("thetto").execute("move_to_input")<CR><Esc><Cmd>silent delete _<CR><Cmd>lua require("thetto").execute("move_to_input")<CR>
    nnoremap <buffer> i <Cmd>lua require("thetto").execute("move_to_input", {action_opts = {behavior = "a"}})<CR>
    nnoremap <buffer> I <Cmd>lua require("thetto").execute("move_to_input")<CR><Home>
    nnoremap <buffer> a <Cmd>lua require("thetto").execute("move_to_input", {action_opts = {behavior = "a"}})<CR>
    nnoremap <buffer> A <Cmd>lua require("thetto").execute("move_to_input")<CR><End>
    nnoremap <nowait> <buffer> q <Cmd>lua require("thetto").execute("quit")<CR>
    nnoremap <buffer> o <Cmd>lua require("thetto").execute("open")<CR>
    nnoremap <buffer> sv <Cmd>lua require("thetto").execute("vsplit_open")<CR>
    nnoremap <buffer> D <Cmd>lua require("thetto").execute("debug_print")<CR>
    nnoremap <buffer> t<Space> <Cmd>lua require("thetto").execute("tab_open")<CR>
    nnoremap <silent> <buffer> <expr> j line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent> <buffer> <expr> k line('.') == 1 ? 'G' : 'k'
    nnoremap <silent> <buffer> <2-LeftMouse> <Cmd>lua require("thetto").execute()<CR>
    inoremap <silent> <buffer> <2-LeftMouse> <Cmd>lua require("thetto").execute()<CR><ESC>
    nnoremap <buffer> <Tab> <Cmd>lua require("thetto").start("thetto/action")<CR>
    nnoremap <buffer> sm <Cmd>lua require("thetto").execute("toggle_selection")<CR><Down>
    xnoremap <buffer> sm <Cmd>lua require("thetto").execute("toggle_selection")<CR>
    nnoremap <buffer> sa <Cmd>lua require("thetto").execute("toggle_all_selection")<CR>
    nnoremap <buffer> fo <Cmd>lua require("thetto").execute("directory_open")<CR>
    nnoremap <buffer> fl <Cmd>lua require("thetto").execute("directory_tab_open")<CR>
    nnoremap <buffer> ff <Cmd>lua require("thetto").execute("directory_enter")<CR>
    nnoremap <buffer> yy <Cmd>lua require("thetto").execute("yank")<CR>
    nnoremap <buffer> tsl <Cmd>lua require("thetto").execute("toggle_sorter", {action_opts = {name = "length"}})<CR>
    nnoremap <buffer> p <Cmd>lua require("thetto").execute("toggle_preview")<CR>
    nnoremap <buffer> P <Cmd>lua require("thetto").execute("dry_run")<CR>
    nnoremap <buffer> [finder]<CR> <Cmd>lua require("thetto").execute("resume_previous")<CR>
    nnoremap <buffer> [finder]n <Cmd>lua require("thetto").execute("resume_previous")<CR>
    nnoremap <buffer> [finder]N <Cmd>lua require("thetto").execute("resume_next")<CR>

    " custom
    nnoremap <buffer> <Leader>rp <Cmd>lua require("thetto").execute("qfreplace")<CR>
endfunction

autocmd MyAuGroup FileType thetto-input call s:thetto_input_settings()
function! s:thetto_input_settings() abort
    nnoremap <buffer> <CR> <Cmd>lua require("thetto").execute()<CR>
    inoremap <buffer> <CR> <Esc>:lua require("thetto").execute()<CR>
    inoremap <silent> <buffer> jq <Cmd>lua require("thetto").execute("quit")<CR><ESC>
    nnoremap <buffer> j <Cmd>lua require("thetto").execute("move_to_list")<CR>
    nnoremap <silent> <buffer> <expr> J line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent> <buffer> <expr> k line('.') == 1 ? 'G' : 'k'
    nnoremap <silent> <buffer> <expr> K line('.') == 1 ? 'G' : 'k'
    nnoremap <buffer> q <Cmd>lua require("thetto").execute("quit")<CR>
    nnoremap <buffer> o <Cmd>lua require("thetto").execute("open")<CR>
    nnoremap <buffer> sv <Cmd>lua require("thetto").execute("vsplit_open")<CR>
    nnoremap <buffer> t<Space> <Cmd>lua require("thetto").execute("tab_open")<CR>
    nnoremap <buffer> fan <Cmd>lua require("thetto").execute("add_filter", {action_opts = {name = "-substring"}})<CR>Gi
    nnoremap <buffer> fd <Cmd>lua require("thetto").execute("remove_filter")<CR>
    nnoremap <buffer> fi <Cmd>lua require("thetto").execute("inverse_filter")<CR>
    nnoremap <buffer> sr <Cmd>lua require("thetto").execute("reverse_sorter")<CR>
    nnoremap <buffer> [finder]<CR> <Cmd>lua require("thetto").execute("resume_previous")<CR>
    nnoremap <buffer> [finder]n <Cmd>lua require("thetto").execute("resume_previous")<CR>
    nnoremap <buffer> [finder]N <Cmd>lua require("thetto").execute("resume_next")<CR>

    " custom
    inoremap <buffer> <C-u> <Cmd>lua require('notomo/insert').delete_prev()<CR>
endfunction

nnoremap [finder]R <Cmd>lua require("thetto").start("vim/runtimepath")<CR>
nnoremap <Space>ur <Cmd>lua require("thetto").start("file/mru", {opts = {target = "project"}})<CR>
nnoremap [finder]<CR> <Cmd>lua require("thetto").resume()<CR>
nnoremap <Space>usf <Cmd>lua require("thetto").start("file/recursive")<CR>
nnoremap <Space>usg <Cmd>lua require("thetto").start("file/recursive", {opts = {target = "project"}})<CR>
nnoremap [finder]f <Cmd>lua require("thetto").start("file/in_dir")<CR>
nnoremap [finder]h <Cmd>lua require("thetto").start("vim/help")<CR>
nnoremap [finder]l <Cmd>lua require("thetto").start("line")<CR>
nnoremap [finder]r <Cmd>lua require("thetto").start("file/directory/recursive", {opts = {target = "project"}})<CR>
nnoremap <Space>usd <Cmd>lua require("thetto").start("file/directory/recursive")<CR>
nnoremap [finder]v <Cmd>lua require("thetto").start("file/recursive", {opts = {cwd = "~/dotfiles"}})<CR>
nnoremap [finder]O <Cmd>lua require("thetto").start("vim/option")<CR>
nnoremap [finder]H <Cmd>lua require("thetto").start("vim/highlight_group")<CR>
nnoremap [finder]B <Cmd>lua require("thetto").start("vim/buffer")<CR>
nnoremap [finder]y <Cmd>lua require("thetto").start("file/bookmark")<CR>
nnoremap [finder]ga <Cmd>lua require("thetto").start("git/branch")<CR>
nnoremap [finder]gA <Cmd>lua require("thetto").start("git/branch", {source_opts = {all = true}, action_opts = {track = true}})<CR>
nnoremap [finder]gt <Cmd>lua require("thetto").start("git/tag")<CR>
nnoremap [finder]gT <Cmd>lua require("thetto").start("git/tag", {source_opts = {merged = true}})<CR>
nnoremap [finder]go <Cmd>lua require("thetto").start("file/directory/recursive", {opts = {cwd = "$GOPATH/src"}, source_opts = {max_depth = 3}})<CR>
nnoremap [keyword]gg <Cmd>lua require("thetto").start("file/grep", {opts = {target = "project", pattern_type = "word"}})<CR>
nnoremap <silent> [finder]gl <Cmd>lua require("thetto").start("file/grep")<CR>
nnoremap <silent> [finder]gg <Cmd>lua require("thetto").start("file/grep", {opts = {target = "project"}})<CR>
nnoremap [finder]P <Cmd>lua require("thetto").start("env/process")<CR>
nnoremap [finder]a <Cmd>lua require("thetto").start("vim/autocmd")<CR>
nnoremap [finder]s <Cmd>lua require("thetto").start("thetto/source")<CR>
nnoremap [finder]n <Cmd>lua require("thetto").resume_execute({opts = {offset = 1}})<CR>
nnoremap [finder]N <Cmd>lua require("thetto").resume_execute({opts = {offset = -1}})<CR>
nnoremap [finder]m <Cmd>lua require("thetto").start("vim/keymap")<CR>
nnoremap [finder]o <Cmd>lua require("thetto").start("cmd/ctags")<CR>
nnoremap [finder], <Cmd>lua require("thetto").start("cmd/make/target", {opts = {target = "project"}})<CR>
nnoremap [exec], <Cmd>lua require("thetto").start("cmd/make/target", {opts = {target = "upward", target_patterns = {"Makefile"}, insert = false}})<CR>
nnoremap [finder]S <Cmd>lua require("thetto").start("vim/substitute")<CR>
xnoremap [finder]s :lua require("thetto").start("vim/substitute")<CR>
nnoremap [finder]gd <Cmd>lua require("thetto").start("git/diff", {opts = {target = "project"}})<CR>
nnoremap [finder]gr <Cmd>lua require("thetto").start("git/diff", {opts = {target = "project"}, source_opts = {expr = "%:p"}})<CR>
nnoremap [finder]G <Cmd>lua require("thetto").start("file/grep", {opts = {target = "project", debounce_ms = 100, filters = {"interactive", "substring", "-substring", "substring:path:relative", "-substring:path:relative"}}})<CR>
nnoremap [finder]gL <Cmd>lua require("thetto").start("file/grep", {opts = {debounce_ms = 100, filters = {"interactive", "substring", "-substring", "substring:path:relative", "-substring:path:relative"}}})<CR>
nnoremap [file]f <Cmd>lua require("thetto").start("file/alter")<CR>
nnoremap [file]l <Cmd>lua require("thetto").start("file/alter", {opts = {action = "tab_open"}})<CR>
nnoremap [file]t <Cmd>lua require("thetto").start("file/alter", {source_opts = {allow_new = true}})<CR>
nnoremap [finder]T <Cmd>lua require("thetto").start("vim/buffer", {source_opts = {buftype = "terminal"}})<CR>
nnoremap [exec]cm <Cmd>lua require("thetto").start("vim/execute", {opts = {display_limit = 1000, insert = false, offset = 1000}, source_opts = {cmd = "messages"}})<CR>
nnoremap [exec]cv <Cmd>lua require("thetto").start("vim/execute", {source_opts = {cmd = "version"}})<CR>
nnoremap [finder]J <Cmd>lua require("thetto").start("vim/jump")<CR>
nnoremap [finder]c <Cmd>lua require("thetto").start("vim/command")<CR>
nnoremap [finder]M <Cmd>lua require("thetto").start("env/manual")<CR>
nnoremap [finder]q <Cmd>lua require("thetto").start("cmd/jq", {opts = {filters = {"interactive", "substring", "-substring"}}})<CR>
nnoremap [finder]gR <Cmd>lua require("thetto").start("cmd/gron")<CR>

" custom source
nnoremap [finder]p <Cmd>lua require("thetto").start("plugin")<CR>
nnoremap [finder]b <Cmd>lua require("thetto").start("url/bookmark", {opts = {action = "browser_open"}})<CR>
nnoremap [finder]e <Cmd>lua require("thetto").start("emoji", {opts = {action = "append"}, action_opts = {key = "emoji"}})<CR>
nnoremap [finder]gp <Cmd>lua require("thetto").start("go/package")<CR>
nnoremap [finder]Q <Cmd>lua require("thetto").start("cmdhndlr/executed")<CR>

" custom action
nnoremap [finder]; <Cmd>lua require("thetto").start("vim/filetype", {opts = {action = "open_proto"}})<CR>
