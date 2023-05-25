local runtime = require("runtimetable").new(require("notomo.plugin.runtimetable").path)

runtime.after.ftplugin["Jenkinsfile.lua"] = function()
  vim.bo.commentstring = "//%s"
  vim.opt_local.expandtab = true
end

runtime.after.ftplugin["ansible.lua"] = function()
  vim.opt_local.tabstop = 2
  vim.opt_local.softtabstop = 2
  vim.opt_local.expandtab = true
end

runtime.after.ftplugin["autohotkey.lua"] = function()
  require("notomo.lsp.mapping").setup()
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    buffer = 0,
    callback = function()
      vim.lsp.buf.format({ timeout_ms = 3000 })
    end,
  })
end

runtime.after.ftplugin["c.lua"] = function()
  vim.opt_local.completeopt:remove("preview")
  vim.opt_local.tabstop = 2
  vim.opt_local.softtabstop = 2
  require("notomo.lsp.mapping").setup()
  require("notomo.lsp.autocmd").setup()
  vim.keymap.set("n", "sgj", [[<Cmd>TSTextobjectGotoNextStart @function.outer<CR>]], { buffer = true })
  vim.keymap.set("n", "sgk", [[<Cmd>TSTextobjectGotoPreviousStart @function.outer<CR>]], { buffer = true })
end

runtime.after.ftplugin["cpp.lua"] = function()
  require("notomo.lsp.mapping").setup()
end

runtime.after.ftplugin["cs.lua"] = function()
  vim.opt_local.completeopt:remove("preview")
  vim.opt_local.expandtab = true
end

runtime.after.ftplugin["diff.lua"] = function()
  vim.keymap.set("n", "q", [[<Cmd>quit<CR>]], { buffer = true, nowait = true })
end

runtime.after.ftplugin["dune.lua"] = function()
  vim.opt_local.iskeyword:remove(".")
  vim.opt_local.iskeyword:remove("/")
end

runtime.after.ftplugin["gitcommit.lua"] = function()
  vim.opt_local.spell = true
  vim.keymap.set("n", "q", [[<Cmd>quit<CR>]], { buffer = true, nowait = true })
end

runtime.after.ftplugin["go.lua"] = function()
  vim.opt_local.completeopt:remove("preview")
  vim.opt_local.expandtab = false
  require("notomo.lsp.mapping").setup({ symbol_source = "cmd/ctags" })
  require("notomo.lsp.autocmd").setup()

  vim.keymap.set(
    "n",
    "[yank]I",
    [[<Cmd>lua require("notomo.lib.edit").yank(vim.fn.trim(vim.fn.system('go list -f "{{.ImportPath}}" ./')))<CR>]],
    { buffer = true }
  )

  local test_pattern = [[\v^(func Test|\s*t\.Run)]]
  vim.keymap.set("n", "sgn", function()
    require("notomo.lib.edit").jump(test_pattern, "W")
  end, { buffer = true })
  vim.keymap.set("n", "sgp", function()
    require("notomo.lib.edit").jump(test_pattern, "Wb")
  end, { buffer = true })

  vim.cmd.syntax({ args = { "keyword", "goKeywords", "nil", "iota", "true", "false" } })
  vim.api.nvim_set_hl(0, "goKeywords", { link = "Boolean" })

  vim.cmd.inoreabbrev({ args = { "<buffer>", "~=", "!=" } })

  require("notomo.plugin.nvim-treesitter").mapping()

  local window_id = vim.api.nvim_get_current_win()
  if not require("misclib.window").is_floating(window_id) then
    vim.wo[window_id].winbar = [[%!v:lua.require("stlparts").build("navic")]]
  end

  local bufnr = vim.api.nvim_get_current_buf()
  vim.schedule(function()
    vim.treesitter.start(bufnr)
  end)
end

runtime.after.queries.go["highlights.scm"] = [=[
;; extends
"range" @repeat.go
]=]

runtime.after.ftplugin["gomod.lua"] = function()
  vim.bo.commentstring = "//%s"
end

runtime.after.ftplugin["graphql.lua"] = function()
  vim.opt_local.tabstop = 2
  vim.opt_local.softtabstop = 2
  vim.opt_local.expandtab = true
  require("notomo.lsp.autocmd").setup()
end

runtime.after.ftplugin["groovy.lua"] = function()
  vim.opt_local.expandtab = false
end

runtime.after.ftplugin["help.lua"] = function()
  if vim.bo.buftype ~= "help" then
    vim.opt_local.list = true
    vim.opt_local.tabstop = 8
    vim.opt_local.shiftwidth = 8
    vim.opt_local.softtabstop = 8
    vim.opt_local.expandtab = false
    vim.opt_local.textwidth = 78
    vim.opt_local.colorcolumn = "+1"
    vim.opt_local.conceallevel = 0
  end
end

runtime.after.ftplugin["html.lua"] = function()
  vim.opt_local.tabstop = 2
  vim.opt_local.softtabstop = 2
  vim.opt_local.expandtab = true
end

runtime.after.ftplugin["javascript.lua"] = function()
  vim.opt_local.completeopt:remove("preview")
  vim.opt_local.tabstop = 2
  vim.opt_local.softtabstop = 2
  vim.opt_local.expandtab = true
  require("notomo.lib.npm").mapping()
  require("notomo.lsp.mapping").setup()
  require("notomo.lsp.autocmd").setup()

  if vim.endswith(vim.fn.bufname(), ".mjs") then
    vim.b.cmdhndlr = { normal_runner = "javascript/zx" }
  end
end

runtime.after.ftplugin["json.lua"] = function()
  vim.keymap.set({ "n", "x" }, "J", function()
    vim.cmd.normal({ args = { "%" }, bang = true })

    local line = vim.trim(vim.fn.getline("."))
    if line == "}," then
      return vim.cmd.normal({ args = { "j" }, bang = true })
    end

    vim.cmd.normal({ args = { "j^%j$" }, bang = true })
  end, { buffer = true })
  vim.keymap.set({ "n", "x" }, "K", function()
    vim.cmd.normal({ args = { "k" }, bang = true })

    local line = vim.trim(vim.fn.getline("."))
    if line == "}," then
      return vim.cmd.normal({ args = { "%" }, bang = true })
    end

    vim.cmd.normal({ args = { "$%k$%" }, bang = true })
  end, { buffer = true })
  if vim.fn.bufname() == "package.json" then
    require("notomo.lib.npm").mapping()
  end
  require("notomo.lsp.autocmd").setup()
  vim.opt_local.tabstop = 2
  vim.opt_local.softtabstop = 2
end

runtime.after.ftplugin["jsonc.lua"] = function()
  vim.cmd.runtime("after/ftplugin/json.lua")
end

runtime.after.ftplugin["lua.lua"] = function()
  vim.opt_local.modeline = false
  vim.opt_local.completeopt:remove("preview")
  vim.opt_local.tabstop = 2
  vim.opt_local.softtabstop = 2
  vim.keymap.set("n", "[exec]s", [[<Cmd>luafile %<CR>]], { buffer = true })
  vim.keymap.set("n", "[exec]l", [[':lua ' . getline('.') . '<CR>']], { expr = true, buffer = true })
  vim.keymap.set("n", "[yank]I", function()
    require("notomo.lib.edit").yank(require("misclib.module.path").detect(vim.fn.expand("%:p")))
  end, { buffer = true })
  require("notomo.lsp.mapping").setup({ symbol_source = "cmd/ctags" })
  require("notomo.lsp.autocmd").setup()
  vim.cmd.inoreabbrev({ args = { "<buffer>", "!=", "~=" } })

  vim.keymap.set("n", "[finder]I", function()
    require("thetto").start("file/grep", {
      opts = {
        cwd = require("thetto.util.cwd").project(),
        filters = require("thetto.util.filter").prepend("interactive"),
        input_lines = { ('"%s"'):format(require("misclib.module.path").detect(vim.fn.expand("%:p"))), "require(" },
      },
    })
  end)

  require("notomo.plugin.nvim-treesitter").mapping()

  vim.treesitter.start()
end

runtime.after.queries.lua["highlights.scm"] = [=[
;; extends
"local" @local
]=]

runtime.after.queries.lua["injections.scm"] = [=[
;; extends
(
  (assignment_statement
    (variable_list
      name: (_) @_runtimetable (#lua-match? @_runtimetable "^runtime.after.queries")
    )
    (expression_list
      value: (string content: _ @query)
    )
  )
)
]=]

runtime.after.ftplugin["query.lua"] = function()
  vim.opt_local.tabstop = 2
  vim.opt_local.softtabstop = 2
end

runtime.after.ftplugin["markdown.lua"] = function()
  vim.opt_local.tabstop = 4
  vim.opt_local.softtabstop = 4
end

runtime.after.ftplugin["mydiary.lua"] = function()
  vim.opt_local.expandtab = true
end

runtime.after.ftplugin["neosnippet.lua"] = function()
  vim.opt_local.expandtab = false
end

runtime.after.ftplugin["ocaml.lua"] = function()
  require("notomo.lsp.mapping").setup()
  require("notomo.lsp.autocmd").setup()
  vim.schedule(function()
    vim.opt_local.indentkeys = ""
  end)
  local use_dune_top = vim.fs.find("dune-project", { upward = true, type = "file" })[1] ~= nil
  vim.b.cmdhndlr_runner_opts = {
    use_in_repl = true,
    use_dune_top = use_dune_top,
  }
end

runtime.after.ftplugin["python.lua"] = function()
  vim.opt_local.completeopt:remove("preview")
  vim.opt_local.modeline = false
  vim.b.cursorword = 0
  require("notomo.lsp.mapping").setup()
  require("notomo.lsp.autocmd").setup()

  vim.keymap.set("n", "sgj", [[<Cmd>TSTextobjectGotoNextStart @function.outer<CR>]], { buffer = true })
  vim.keymap.set("n", "sgk", [[<Cmd>TSTextobjectGotoPreviousStart @function.outer<CR>]], { buffer = true })
end

runtime.after.ftplugin["requirements.lua"] = function()
  vim.bo.commentstring = "#%s"
end

runtime.after.ftplugin["ruby.lua"] = function()
  vim.opt_local.tabstop = 2
  vim.opt_local.softtabstop = 2
end

runtime.after.ftplugin["rust.lua"] = function()
  vim.opt_local.completeopt:remove("preview")
  vim.opt_local.modeline = false
  require("notomo.lsp.mapping").setup()
  require("notomo.lsp.autocmd").setup()

  vim.keymap.set("n", "sgj", [[<Cmd>TSTextobjectGotoNextStart @function.outer<CR>]], { buffer = true })
  vim.keymap.set("n", "sgk", [[<Cmd>TSTextobjectGotoPreviousStart @function.outer<CR>]], { buffer = true })
end

runtime.after.ftplugin["scheme.lua"] = function()
  vim.opt_local.tabstop = 2
  vim.opt_local.softtabstop = 2
  vim.opt_local.expandtab = true
end

runtime.after.ftplugin["sql.lua"] = function()
  vim.b.match_ignorecase = 1
  vim.b.match_words = [[\<select\>:\<from\>:\<join\>:\<where\>]]
  vim.opt_local.tabstop = 2
  vim.opt_local.softtabstop = 2
end

runtime.after.ftplugin["terraform.lua"] = function()
  require("notomo.lsp.autocmd").setup()
  vim.schedule(function()
    vim.treesitter.start()
  end)
end

runtime.after.ftplugin["typescript.lua"] = function()
  vim.opt_local.modeline = false
  vim.opt_local.completeopt:remove("preview")
  vim.opt_local.tabstop = 2
  vim.opt_local.softtabstop = 2
  vim.opt_local.expandtab = true
  require("notomo.lsp.mapping").setup()
  require("notomo.lsp.autocmd").setup()
  vim.keymap.set("n", "[finder]i", [[<Cmd>lua require("thetto").start("deno/deps")<CR>]])
end

runtime.after.ftplugin["vim.lua"] = function()
  vim.opt_local.foldmethod = "marker"
  vim.b.match_words =
    [[\<if\>:\<elseif\>:\<else\>:\<endif\>,\<for\>:\<endfor\>,\<while\>:\<endwhile\>,\<try\>:\<catch\>:\<finally\>:\<endtry\>,\<func\(tion\)\?\>:\<endfunc\(tion\)\?\>,\<augroup [^E]\w*\>:\<augroup END\>]]
  vim.opt_local.iskeyword:remove("#")

  vim.keymap.set("n", "[exec]s", [[<Cmd>source %<CR>]], { buffer = true })
  require("notomo.lsp.mapping").setup({ symbol_source = "cmd/ctags" })
end

runtime.after.ftplugin["vue.lua"] = function()
  vim.opt_local.tabstop = 2
  vim.opt_local.softtabstop = 2
  vim.opt_local.expandtab = true
end

runtime.after.ftplugin["xml.lua"] = function()
  vim.opt_local.expandtab = false
end

runtime.after.ftplugin["yaml.lua"] = function()
  require("notomo.lsp.mapping").setup({ symbol_source = "cmd/ctags" })
end

require("notomo.plugin.runtimetable").save(runtime)
