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
    vim.keymap.set("n", "j", [[line('.') == line('$') ? 'gg' : 'j']], { silent = true, buf = 0, expr = true })
    vim.keymap.set("n", "k", [[line('.') == 1 ? 'G' : 'k']], { silent = true, buf = 0, expr = true })
    vim.keymap.set("n", "h", execute("parent"), { buf = 0 })
    vim.keymap.set("n", "l", execute("child"), { buf = 0 })
    vim.keymap.set("n", "q", [[<Cmd>quit<CR>]], { buf = 0, nowait = true })
    vim.keymap.set("n", "t<Space>", function()
      require("kivi").execute("tab_open", {
        quit = not require("kivi").is_parent(),
      })
    end, { buf = 0 })
    vim.keymap.set("n", "sv", function()
      require("kivi").execute("vsplit_open", {
        quit = not require("kivi").is_parent(),
      })
    end, { buf = 0 })
    vim.keymap.set("n", "D", execute("debug_print"), { buf = 0 })
    vim.keymap.set("n", "yr", execute("yank"), { buf = 0 })
    vim.keymap.set("n", "B", execute("back"), { buf = 0 })
    vim.keymap.set("n", "rn", execute("rename"), { buf = 0 })
    vim.keymap.set("n", "o", function()
      if require("kivi").is_parent() then
        return require("kivi").execute("toggle_tree")
      end
      return require("kivi").execute("open")
    end, { buf = 0 })
    vim.keymap.set("n", "c", execute("close_all_tree"), { buf = 0 })

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
    end, { buf = 0 })

    vim.keymap.set("n", "sm", [[<Cmd>lua require("kivi").execute("toggle_selection")<CR>j]], { buf = 0 })
    vim.keymap.set("x", "sm", execute("toggle_selection"), { buf = 0 })
    vim.keymap.set("n", "O", execute("expand_parent"), { buf = 0 })
    vim.keymap.set("n", ".", execute("shrink"), { buf = 0 })
    vim.keymap.set({ "n", "x" }, "I", execute("show_details"), { buf = 0 })
    vim.keymap.set("n", "T", execute("show_git_ignores"), { buf = 0 })
    vim.keymap.set("n", "X", execute("open_by_system_default"), { buf = 0 })

    local gesture = require("gesture")
    gesture.register({
      name = "go to the parent",
      buf = "%",
      inputs = { gesture.up() },
      action = function()
        require("kivi").execute("parent")
      end,
    })

    vim.keymap.set("n", "<RightMouse>", [[<LeftMouse><Cmd>lua require("piemenu").start("kivi")<CR>]], {
      buf = 0,
    })
    vim.keymap.set("n", "<2-RightMouse>", [[<LeftMouse><Cmd>lua require("piemenu").start("kivi")<CR>]], { buf = 0 })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = group,
  pattern = { "kivi-file" },
  callback = function()
    local navigate = function(path)
      return function()
        require("kivi").navigate(path)
      end
    end

    vim.keymap.set("n", "<Space>g", navigate(vim.fs.root(0, ".git") or "."), { buf = 0 })
    vim.keymap.set("n", "<Space>h", navigate("~"), { buf = 0 })
    vim.keymap.set("n", "<Space>r", navigate("/tmp"), {
      buf = 0,
      nowait = true,
    })
    vim.keymap.set({ "n", "x" }, "df", execute("delete"), { buf = 0 })
    vim.keymap.set({ "n", "x" }, "xf", execute("cut"), { buf = 0 })
    vim.keymap.set({ "n", "x" }, "yf", execute("copy"), { buf = 0 })
    vim.keymap.set("n", "yx", execute("clear_clipboard"), { buf = 0 })
    vim.keymap.set("n", "p", execute("paste"), { buf = 0 })
    vim.keymap.set("n", "i", execute("create"), { buf = 0 })
  end,
})

vim.api.nvim_create_autocmd({ "BufRead" }, {
  group = group,
  pattern = { "*/kivi-renamer", "*/kivi-creator" },
  callback = function()
    vim.keymap.set("n", "q", [[<Cmd>quit!<CR>]], { buf = 0, nowait = true })
    vim.keymap.set("i", "jq", [[<ESC><Cmd>quit!<CR>]], { buf = 0 })
  end,
})
