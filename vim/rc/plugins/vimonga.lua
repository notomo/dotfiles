vim.api.nvim_create_augroup("vimonga_setting", {})
vim.api.nvim_create_autocmd({ "User" }, {
  group = "vimonga_setting",
  pattern = { "VimongaSourceLoad" },
  once = true,
  callback = function()
    vim.api.nvim_create_autocmd({ "FileType" }, {
      group = "vimonga_setting",
      pattern = { "vimonga-conns", "vimonga-dbs", "vimonga-colls" },
      callback = function()
        vim.keymap.set("n", "j", [[line('.') == line('$') ? 'gg' : 'j']], {
          buffer = true,
          silent = true,
          expr = true,
        })
        vim.keymap.set("n", "k", [[line('.') == 1 ? 'G' : 'k']], { buffer = true, silent = true, expr = true })
      end,
    })

    vim.api.nvim_create_autocmd({ "FileType" }, {
      group = "vimonga_setting",
      pattern = { "vimonga-conns" },
      callback = function()
        vim.keymap.set("n", "l", [[<Cmd>Vimonga database.list<CR>]], { buffer = true })
      end,
    })

    vim.api.nvim_create_autocmd({ "FileType" }, {
      group = "vimonga_setting",
      pattern = { "vimonga-dbs" },
      callback = function()
        vim.keymap.set("n", "l", [[<Cmd>Vimonga collection.list<CR>]], { buffer = true })
        vim.keymap.set("n", "h", [[<Cmd>Vimonga connection.list<CR>]], { buffer = true })
        vim.keymap.set("n", "t<Space>", [[<Cmd>Vimonga collection.list -open=tab<CR>]], { buffer = true })
        vim.keymap.set("n", "dd", [[<Cmd>Vimonga database.drop<CR>]], { buffer = true })
        vim.keymap.set("x", "D", [[:Vimonga database.drop<CR>]], { buffer = true })
        vim.keymap.set("n", "u", [[<Cmd>Vimonga user.list<CR>]], { buffer = true })
        vim.keymap.set("n", "[exec]f", [[<Cmd>Vimonga connection.list -open=vertical -width=45<CR>]], {
          buffer = true,
        })
        vim.keymap.set("n", "I", [[:<C-u>Vimonga collection.create -coll=test -db=]], { buffer = true })
      end,
    })

    vim.api.nvim_create_autocmd({ "FileType" }, {
      group = "vimonga_setting",
      pattern = { "vimonga-users" },
      callback = function()
        vim.keymap.set("n", "h", [[<Cmd>Vimonga database.list<CR>]], { buffer = true })
        vim.keymap.set("n", "I", [[<Cmd>Vimonga user.new<CR>]], { buffer = true })
        vim.keymap.set("n", "X", [[:<C-u>Vimonga user.drop -user=]], { buffer = true })
        vim.keymap.set("n", "[exec]f", [[<Cmd>Vimonga database.list -open=vertical -width=45<CR>]], { buffer = true })
      end,
    })

    vim.api.nvim_create_autocmd({ "FileType" }, {
      group = "vimonga_setting",
      pattern = { "vimonga-user-new" },
      callback = function()
        vim.keymap.set("n", "[file]w", [[<Cmd>Vimonga user.create<CR>]], { buffer = true })
      end,
    })

    vim.api.nvim_create_autocmd({ "FileType" }, {
      group = "vimonga_setting",
      pattern = { "vimonga-colls" },
      callback = function()
        vim.keymap.set("n", "l", [[<Cmd>Vimonga document.find<CR>]], { buffer = true })
        vim.keymap.set("n", "dd", [[<Cmd>Vimonga collection.drop<CR>]], { buffer = true })
        vim.keymap.set("n", "D", [[:Vimonga collection.drop<CR>]], { buffer = true })
        vim.keymap.set("n", "h", [[<Cmd>Vimonga database.list<CR>]], { buffer = true })
        vim.keymap.set("n", "t<Space>", [[<Cmd>Vimonga document.find -open=tab<CR>]], { buffer = true })
        vim.keymap.set("n", "i", [[<Cmd>Vimonga index.list<CR>]], { buffer = true })
        vim.keymap.set("n", "I", [[<Cmd>Vimonga collection.create<CR>]], { buffer = true })
        vim.keymap.set("n", "[exec]f", [[<Cmd>Vimonga database.list -open=vertical -width=45<CR>]], { buffer = true })
      end,
    })

    vim.api.nvim_create_autocmd({ "FileType" }, {
      group = "vimonga_setting",
      pattern = { "vimonga-indexes" },
      callback = function()
        vim.keymap.set("n", "h", [[<Cmd>Vimonga collection.list<CR>]], { buffer = true })
        vim.keymap.set("n", "I", [[<Cmd>Vimonga index.new<CR>]], { buffer = true })
        vim.keymap.set("n", "X", [[:<C-u>Vimonga index.drop -index=]], { buffer = true })
        vim.keymap.set("n", "[exec]f", [[<Cmd>Vimonga collection.list -open=vertical -width=45<CR>]], {
          buffer = true,
        })
      end,
    })

    vim.api.nvim_create_autocmd({ "FileType" }, {
      group = "vimonga_setting",
      pattern = { "vimonga-index-new" },
      callback = function()
        vim.keymap.set("n", "[file]w", [[<Cmd>Vimonga index.create<CR>]], { buffer = true })
      end,
    })

    vim.api.nvim_create_autocmd({ "FileType" }, {
      group = "vimonga_setting",
      pattern = { "vimonga-docs" },
      callback = function()
        vim.keymap.set("n", "h", [[<Cmd>Vimonga collection.list<CR>]], { buffer = true })
        vim.keymap.set("n", "<C-n>", [[<Cmd>Vimonga document.page.next<CR>]], { buffer = true })
        vim.keymap.set("n", "<C-e>", [[<Cmd>Vimonga document.page.last<CR>]], { buffer = true })
        vim.keymap.set("n", "<C-p>", [[<Cmd>Vimonga document.page.prev<CR>]], { buffer = true })
        vim.keymap.set("n", "<C-a>", [[<Cmd>Vimonga document.page.first<CR>]], { buffer = true })
        vim.keymap.set("n", "dd", [[<Cmd>Vimonga document.projection.hide<CR>]], { buffer = true })
        vim.keymap.set("n", "dr", [[<Cmd>Vimonga document.projection.reset_all<CR>]], { buffer = true })
        vim.keymap.set("n", "sa", [[<Cmd>Vimonga document.sort.ascending<CR>]], { buffer = true })
        vim.keymap.set("n", "sd", [[<Cmd>Vimonga document.sort.descending<CR>]], { buffer = true })
        vim.keymap.set("n", "sr", [[<Cmd>Vimonga document.sort.reset<CR>]], { buffer = true })
        vim.keymap.set("n", "ss", [[<Cmd>Vimonga document.sort.toggle<CR>]], { buffer = true })
        vim.keymap.set("n", "sR", [[<Cmd>Vimonga document.sort.reset_all<CR>]], { buffer = true })
        vim.keymap.set("n", "a", [[<Cmd>Vimonga document.query.add<CR>]], { buffer = true })
        vim.keymap.set("n", "A", [[<Cmd>Vimonga document.query.reset_all<CR>]], { buffer = true })
        vim.keymap.set("n", "t<Space>", [[<Cmd>Vimonga document.one -open=tab<CR>]], { buffer = true })
        vim.keymap.set("n", "o", [[<Cmd>Vimonga document.one<CR>]], { buffer = true })
        vim.keymap.set("n", "I", [[<Cmd>Vimonga document.new -open=tab<CR>]], { buffer = true })
        vim.keymap.set("n", "F", [[<Cmd>Vimonga document.query.find_by_oid -open=tab<CR>]], { buffer = true })
        vim.keymap.set("n", "[exec]f", [[<Cmd>Vimonga collection.list -open=vertical -width=45<CR>]], {
          buffer = true,
        })
        vim.keymap.set("n", "J", [[<Cmd>Vimonga document.next_wrap<CR>]], { buffer = true })
        vim.keymap.set("n", "K", [[<Cmd>Vimonga document.prev_wrap<CR>]], { buffer = true })
      end,
    })

    vim.api.nvim_create_autocmd({ "FileType" }, {
      group = "vimonga_setting",
      pattern = { "vimonga-doc" },
      callback = function()
        vim.keymap.set("n", "X", [[<Cmd>Vimonga document.one.delete<CR>]], { buffer = true })
        vim.keymap.set("n", "H", [[<Cmd>Vimonga document.find<CR>]], { buffer = true })
        vim.keymap.set("n", "[exec]f", [[<Cmd>Vimonga document.find -open=vertical<CR>]], { buffer = true })
      end,
    })

    vim.api.nvim_create_autocmd({ "FileType" }, {
      group = "vimonga_setting",
      pattern = { "vimonga-doc-new" },
      callback = function()
        vim.keymap.set("n", "[file]w", [[<Cmd>Vimonga document.one.insert<CR>]], { buffer = true })
      end,
    })

    vim.fn["vimonga#config#set"]("default_host", "localhost:27017")
    vim.fn["vimonga#config#set"](
      "connection_config",
      require("optpack").get("vimonga").directory .. "/example/connection.json"
    )
  end,
})
