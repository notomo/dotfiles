vim.g.ale_open_list = 0
vim.g.ale_lint_on_filetype_changed = 0
vim.g.ale_lint_on_enter = 0
vim.g.ale_lint_on_save = 0
vim.g.ale_fix_on_save = 1
vim.g.ale_lint_on_text_changed = "never"
vim.g.ale_virtualtext_cursor = 1
vim.g.ale_virtualtext_prefix = " "
vim.g.ale_lint_on_insert_leave = 0
vim.g.ale_hover_cursor = 0
vim.g.ale_disable_lsp = 1

vim.g.ale_linters = vim.empty_dict()

local fixers = vim.empty_dict()
fixers["sh"] = {}
fixers["python"] = {}
fixers["go"] = {}
fixers["rust"] = {}
fixers["javascript"] = {}
fixers["typescript"] = {}
fixers["css"] = {}
fixers["html"] = {}
fixers["scss"] = fixers["css"]
fixers["vue"] = {}
fixers["json"] = {}
fixers["lua"] = {}
fixers["terraform"] = {}
fixers["dart"] = {}
fixers["c"] = {}
vim.g.ale_fixers = fixers

vim.g.ale_c_uncrustify_options = "-c " .. vim.fn.expand("~/workspace/neovim/src/uncrustify.cfg")
vim.g.ale_lua_stylua_options = "--config-path " .. vim.fn.expand("~/dotfiles/tool/stylua.toml")
vim.g.ale_sql_sqlfmt_options = "-u"
