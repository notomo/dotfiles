local M = {}

function M.buffer_reverse()
  vim.cmd.global([[/^/m0]])
  vim.cmd.nohlsearch()
end

function M.expand_line()
  local line = vim.fn.getline("."):gsub("\\n", "\n"):gsub("\\t", "  ")

  vim.cmd.tabedit()
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"

  local lines = vim.split(line, "\n", { plan = true })
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

function M.open_treesitter_query_editor()
  local runtime_dir = vim.fs.joinpath(vim.fn.stdpath("cache"), "notomo")
  local dir = vim.fs.joinpath(runtime_dir, "queries", vim.bo.filetype)
  local query_path = vim.fs.joinpath(dir, "scratch.scm")
  vim.fn.writefile({}, query_path, "p")
  vim.opt.runtimepath:append(runtime_dir)
  vim.treesitter.query.edit()
  vim.cmd.stopinsert()
  vim.cmd.wincmd("r")
  vim.cmd.wincmd("=")
  vim.cmd.new({ mods = { split = "belowright" } })
  local winid = vim.api.nvim_get_current_win()
  vim.cmd.wincmd("h")
  vim.treesitter.inspect_tree({ winid = winid })
end

function M.ready_parser()
  for _, language in ipairs({
    "go",
    "gomod",
    "javascript",
    "typescript",
    "terraform",
    "graphql",
    "comment",
    "prisma",
    "astro",
    "tsx",
    "css",
    "yaml",
    "bash", -- workaround: not to use builtin bash parser
    "cpp",
    "rust",
  }) do
    vim.cmd.TSUpdate(language)
  end
end

function M.clear_messages()
  vim.cmd.messages("clear")
end

function M.count_characters()
  vim.notify(("Characters: %d"):format(vim.fn.wordcount().chars))
end

function M.hlmsg()
  local bufnr = vim.api.nvim_create_buf(false, true)
  require("hlmsg").render(bufnr)
  vim.cmd.tabedit()
  vim.cmd.buffer(bufnr)
  require("misclib.cursor").to_bottom()
end

function M.cmdline_window_for_excmd()
  vim.fn.feedkeys("q:", "n")
end
function M.cmdline_window_for_search()
  vim.fn.feedkeys("q/", "n")
end

function M.rename()
  vim.fn.feedkeys(":file ", "n")
end

function M.check_health()
  vim.cmd.checkhealth()
end

function M.reload_vimrc()
  if vim.env.MYVIMRC and vim.env.MYVIMRC ~= "" then
    vim.cmd.source(vim.env.MYVIMRC)
  end
  vim.cmd.nohlsearch()
end

function M.diff()
  local window_ids = vim.api.nvim_tabpage_list_wins(0)
  if #window_ids ~= 2 then
    return require("notomo.lib.message").warn(("must have 2 windows, but: %d"):format(#window_ids))
  end
  for _, window_id in ipairs(window_ids) do
    vim.api.nvim_win_call(window_id, function()
      vim.cmd.diffthis()
    end)
  end
end

function M.generate_helptags()
  require("cmdhndlr").run({
    name = "make/make",
    working_dir_marker = function()
      return vim.fn.expand("$DOTFILES/vim/Makefile")
    end,
    runner_opts = { target = "help_tags" },
  })
end

function M.install_plugins()
  require("optpack").install()
end

function M.preview()
  vim.cmd.PrevimOpen()
end

function M.test_highlight()
  vim.cmd.tabedit()
  vim.cmd.source([[$VIMRUNTIME/syntax/hitest.vim]])
  vim.cmd.only()
end

function M.inspect()
  vim.cmd.Inspect({ bang = true })
end

function M.reset_runtimetable()
  require("notomo.plugin.runtimetable").save_all()
end

function M.inspect_redraw()
  require("redraw-inspect").start({
    on_redraw = require("redraw-inspect.util").highlight_line(),
  })
end

function M.open_line_in_vscode()
  local path = vim.fn.expand("%:p") .. ":" .. vim.fn.line(".") .. ":" .. vim.fn.col(".")
  require("notomo.lib.job").run({ "code", "-r", "-g", path }, {
    stderr = function() end,
  })
end

function M.open_repo_in_vscode()
  local git_root = vim.fs.root(".", { ".git" })
  require("notomo.lib.job")
    .run({ "code", "-r", git_root }, {
      stderr = function() end,
    })
    :wait()
  M.open_line_in_vscode()
end

function M.create_issue()
  require("notomo.lib.github").create_issue()
end
function M.view_issue()
  require("notomo.lib.github").view_issue(vim.fn.expand("<cword>"))
end
function M.view_pull_request()
  require("notomo.lib.github").view_pr()
end
function M.view_current_repository()
  require("notomo.lib.github").view_repo()
end
function M.view_cursor_repository()
  require("notomo.lib.github").view_repo(vim.fn.expand("<cWORD>"))
end

function M.package_json_update()
  require("notomo.lib.npm").update(vim.fn.expand("%:p"))
end

function M.format_do()
  vim.lsp.buf.format({ async = true })
end

function M.format_toggle()
  local disabled = vim.b.notomo_format_disabled
  vim.b.notomo_format_disabled = not disabled
end

function M.format_biome_unsafe()
  require("cmdhndlr")
    .format({
      name = "javascript/biome",
      runner_opts = {
        extra_args = { "--unsafe" },
      },
    })
    :next(function()
      vim.cmd.TSRemoveUnused()
    end)
end

function M.install_lua_debugger()
  local lldebugger_path = vim.fn.expand("~/app/local-lua-debugger-vscode")
  if vim.uv.fs_stat(lldebugger_path) then
    return
  end
  require("notomo.lib.job")
    .run({ "git", "clone", "https://github.com/tomblind/local-lua-debugger-vscode", lldebugger_path })
    :wait()
  require("notomo.lib.job").run({ "npm", "install" }, { cwd = lldebugger_path }):wait()
  require("notomo.lib.job").run({ "npm", "run", "build" }, { cwd = lldebugger_path }):wait()
end

return M
