vim.api.nvim_create_augroup("kivi_setting", {})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "kivi_setting",
  pattern = { "kivi-*" },
  callback = function()
    vim.keymap.set("n", "j", [[line('.') == line('$') ? 'gg' : 'j']], { silent = true, buffer = true, expr = true })
    vim.keymap.set("n", "k", [[line('.') == 1 ? 'G' : 'k']], { silent = true, buffer = true, expr = true })
    vim.keymap.set("n", "h", [[<Cmd>lua require("kivi").execute("parent")<CR>]], { buffer = true })
    vim.keymap.set("n", "l", [[<Cmd>lua require("kivi").execute("child")<CR>]], { buffer = true })
    vim.keymap.set("n", "q", [[<Cmd>quit<CR>]], { buffer = true, nowait = true })
    vim.keymap.set(
      "n",
      "t<Space>",
      [[<Cmd>lua require("kivi").execute("tab_open", {quit = not require("kivi").is_parent()})<CR>]],
      { buffer = true }
    )
    vim.keymap.set(
      "n",
      "sv",
      [[<Cmd>lua require("kivi").execute("vsplit_open", {quit = not require("kivi").is_parent()})<CR>]],
      { buffer = true }
    )
    vim.keymap.set("n", "D", [[<Cmd>lua require("kivi").execute("debug_print")<CR>]], { buffer = true })
    vim.keymap.set("n", "yr", [[<Cmd>lua require("kivi").execute("yank")<CR>]], { buffer = true })
    vim.keymap.set("n", "B", [[<Cmd>lua require("kivi").execute("back")<CR>]], { buffer = true })
    vim.keymap.set("n", "rn", [[<Cmd>lua require("kivi").execute("rename")<CR>]], { buffer = true })
    vim.keymap.set("n", "o", function()
      if require("kivi").is_parent() then
        return require("kivi").execute("toggle_tree")
      end
      return require("kivi").execute("open")
    end, { buffer = true })
    vim.keymap.set("n", "c", [[<Cmd>lua require("kivi").execute("close_all_tree")<CR>]], { buffer = true })
    vim.keymap.set("n", "<2-LeftMouse>", [[<Cmd>lua require("kivi").execute("child")<CR>]], { buffer = true })
    vim.keymap.set("n", "sm", [[<Cmd>lua require("kivi").execute("toggle_selection")<CR>j]], { buffer = true })
    vim.keymap.set("x", "sm", [[<Cmd>lua require("kivi").execute("toggle_selection")<CR>]], { buffer = true })
    vim.keymap.set("n", "O", [[<Cmd>lua require("kivi").execute("expand_parent")<CR>]], { buffer = true })
    vim.keymap.set("n", ".", [[<Cmd>lua require("kivi").execute("shrink")<CR>]], { buffer = true })
    vim.keymap.set("n", "I", [[<Cmd>lua require("kivi").execute("show_details")<CR>]], { buffer = true })
    vim.keymap.set("x", "I", [[<Cmd>lua require("kivi").execute("show_details")<CR>]], { buffer = true })

    local gesture = require("gesture")
    gesture.register({
      name = "go to the parent",
      buffer = "%",
      inputs = { gesture.up() },
      action = "lua require('kivi').execute('parent')",
    })

    vim.keymap.set("n", "<RightMouse>", [[<LeftMouse><Cmd>lua require("piemenu").start("kivi")<CR>]], {
      buffer = true,
    })
    vim.keymap.set(
      "n",
      "<2-RightMouse>",
      [[<LeftMouse><Cmd>lua require("piemenu").start("kivi")<CR>]],
      { buffer = true }
    )
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "kivi_setting",
  pattern = { "kivi-file" },
  callback = function()
    vim.keymap.set(
      "n",
      "<Space>g",
      [[<Cmd>lua require("kivi").navigate(".", {target = "project"})<CR>]],
      { buffer = true }
    )
    vim.keymap.set("n", "<Space>h", [[<Cmd>lua require("kivi").navigate("~")<CR>]], { buffer = true })
    vim.keymap.set("n", "<Space>r", [[<Cmd>lua require("kivi").navigate("/tmp")<CR>]], {
      buffer = true,
      nowait = true,
    })
    vim.keymap.set("n", "df", [[<Cmd>lua require("kivi").execute("delete")<CR>]], { buffer = true })
    vim.keymap.set("n", "xf", [[<Cmd>lua require("kivi").execute("cut")<CR>]], { buffer = true })
    vim.keymap.set("n", "yf", [[<Cmd>lua require("kivi").execute("copy")<CR>]], { buffer = true })
    vim.keymap.set("n", "p", [[<Cmd>lua require("kivi").execute("paste")<CR>]], { buffer = true })
    vim.keymap.set("n", "i", [[<Cmd>lua require("kivi").execute("create")<CR>]], { buffer = true })
  end,
})

vim.api.nvim_create_autocmd({ "BufRead" }, {
  group = "kivi_setting",
  pattern = { "*/kivi-renamer", "*/kivi-creator" },
  callback = function()
    vim.keymap.set("n", "q", [[<Cmd>quit!<CR>]], { buffer = true, nowait = true })
    vim.keymap.set("i", "jq", [[<ESC><Cmd>quit!<CR>]], { buffer = true })
  end,
})
