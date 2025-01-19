local group = vim.api.nvim_create_augroup("notomo.kivi", {})

local execute = function(action_name, opts)
  return function()
    require("kivi").execute(action_name, opts)
  end
end

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = group,
  pattern = { "kivi-*" },
  callback = function()
    vim.keymap.set("n", "j", [[line('.') == line('$') ? 'gg' : 'j']], { silent = true, buffer = true, expr = true })
    vim.keymap.set("n", "k", [[line('.') == 1 ? 'G' : 'k']], { silent = true, buffer = true, expr = true })
    vim.keymap.set("n", "h", execute("parent"), { buffer = true })
    vim.keymap.set("n", "l", execute("child"), { buffer = true })
    vim.keymap.set("n", "q", [[<Cmd>quit<CR>]], { buffer = true, nowait = true })
    vim.keymap.set("n", "t<Space>", function()
      require("kivi").execute("tab_open", {
        quit = not require("kivi").is_parent(),
      })
    end, { buffer = true })
    vim.keymap.set("n", "sv", function()
      require("kivi").execute("vsplit_open", {
        quit = not require("kivi").is_parent(),
      })
    end, { buffer = true })
    vim.keymap.set("n", "D", execute("debug_print"), { buffer = true })
    vim.keymap.set("n", "yr", execute("yank"), { buffer = true })
    vim.keymap.set("n", "B", execute("back"), { buffer = true })
    vim.keymap.set("n", "rn", execute("rename"), { buffer = true })
    vim.keymap.set("n", "o", function()
      if require("kivi").is_parent() then
        return require("kivi").execute("toggle_tree")
      end
      return require("kivi").execute("open")
    end, { buffer = true })
    vim.keymap.set("n", "c", execute("close_all_tree"), { buffer = true })

    vim.keymap.set("n", "<2-LeftMouse>", function()
      require("kivi").execute("child")
      -- workaround?
      vim.api.nvim_create_autocmd({ "ModeChanged" }, {
        group = vim.api.nvim_create_augroup("notomo.kivi.mouse", {}),
        pattern = { "*:v" },
        callback = function()
          local ESC = vim.keycode("<ESC>")
          vim.cmd.normal({ args = { ESC }, bang = true })
        end,
        once = true,
      })
    end, { buffer = true })

    vim.keymap.set("n", "sm", [[<Cmd>lua require("kivi").execute("toggle_selection")<CR>j]], { buffer = true })
    vim.keymap.set("x", "sm", execute("toggle_selection"), { buffer = true })
    vim.keymap.set("n", "O", execute("expand_parent"), { buffer = true })
    vim.keymap.set("n", ".", execute("shrink"), { buffer = true })
    vim.keymap.set("n", "I", execute("show_details"), { buffer = true })
    vim.keymap.set("x", "I", execute("show_details"), { buffer = true })
    vim.keymap.set("n", "T", execute("show_git_ignores"), { buffer = true })
    vim.keymap.set("n", "X", execute("open_by_system_default"), { buffer = true })

    local gesture = require("gesture")
    gesture.register({
      name = "go to the parent",
      buffer = "%",
      inputs = { gesture.up() },
      action = function()
        require("kivi").execute("parent")
      end,
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
  group = group,
  pattern = { "kivi-file" },
  callback = function()
    local navigate = function(path, source_setup_opts)
      return function()
        require("kivi").navigate(path, source_setup_opts)
      end
    end

    vim.keymap.set("n", "<Space>g", navigate(".", { target = "project" }), { buffer = true })
    vim.keymap.set("n", "<Space>h", navigate("~"), { buffer = true })
    vim.keymap.set("n", "<Space>r", navigate("/tmp"), {
      buffer = true,
      nowait = true,
    })
    vim.keymap.set("n", "df", execute("delete"), { buffer = true })
    vim.keymap.set("n", "xf", execute("cut"), { buffer = true })
    vim.keymap.set("n", "yf", execute("copy"), { buffer = true })
    vim.keymap.set("n", "yx", execute("clear_clipboard"), { buffer = true })
    vim.keymap.set("n", "p", execute("paste"), { buffer = true })
    vim.keymap.set("n", "i", execute("create"), { buffer = true })
  end,
})

vim.api.nvim_create_autocmd({ "BufRead" }, {
  group = group,
  pattern = { "*/kivi-renamer", "*/kivi-creator" },
  callback = function()
    vim.keymap.set("n", "q", [[<Cmd>quit!<CR>]], { buffer = true, nowait = true })
    vim.keymap.set("i", "jq", [[<ESC><Cmd>quit!<CR>]], { buffer = true })
  end,
})
