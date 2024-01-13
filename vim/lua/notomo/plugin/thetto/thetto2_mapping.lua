local action = function(action_name, opts)
  return function()
    local items, metadata = require("thetto2").get()
    local item_action_groups = require("thetto2.util.action").grouping(items, {
      action_name = action_name,
      actions = metadata.actions,
    })
    require("thetto2").execute(item_action_groups, opts)
  end
end

local action_key = function(prev, action_name)
  return function()
    vim.fn.feedkeys(prev, "mx")
    action(action_name)
  end
end

local thetto_starter = function(source_name, fields, opts)
  return function()
    require("thetto2").start(require("thetto2.util.source").by_name(source_name, fields, opts))
  end
end

local call_consumer = function(action_name, opts)
  return function()
    return require("thetto2").call_consumer(action_name, opts)
  end
end

local call_consumer_key = function(prev, action_name, next)
  return ([[%s<Cmd>lua require("thetto2").call_consumer(%q)<CR>%s]]):format(prev, action_name, next)
end

local thetto_group = vim.api.nvim_create_augroup("thetto2_setting", {})
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = thetto_group,
  pattern = { "thetto2" },
  callback = function()
    vim.keymap.set("n", "<2-LeftMouse>", action(), { buffer = true, silent = true })
    vim.keymap.set("n", "<2-LeftMouse>", action(), { buffer = true, silent = true })
    vim.keymap.set("n", "<RightMouse>", [[<Nop>]], { buffer = true })
    vim.keymap.set("n", "<RightDrag>", [[<Nop>]], { buffer = true })
    vim.keymap.set("n", "<C-w>", call_consumer("quit"), { buffer = true })

    vim.keymap.set("n", "dd", call_consumer_key("", "move_to_input", "<Cmd>silent delete _<CR>"), { buffer = true })
    vim.keymap.set(
      "n",
      "cc",
      call_consumer_key("<ESC>", "move_to_input", "<Cmd>silent delete _<CR>i"),
      { buffer = true }
    )

    vim.keymap.set("n", "i", call_consumer("move_to_input"), { buffer = true })
    vim.keymap.set("n", "I", call_consumer_key("", "move_to_input", "<Home>"), { buffer = true })
    vim.keymap.set("n", "a", call_consumer("move_to_input"), { buffer = true })
    vim.keymap.set("n", "A", call_consumer_key("", "move_to_input", "<End>"), { buffer = true })

    vim.keymap.set("n", "q", call_consumer("quit"), { buffer = true, nowait = true })
    vim.keymap.set("n", "M", call_consumer("increase_display_limit"), { buffer = true })

    vim.keymap.set("n", "<CR>", action(), { buffer = true })
    vim.keymap.set("n", "o", action("open"), { buffer = true })
    vim.keymap.set("n", "sv", action("vsplit_open"), { buffer = true })
    vim.keymap.set("n", "t<Space>", action("tab_open"), { buffer = true })
    vim.keymap.set("n", "fo", action("directory_open"), { buffer = true })
    vim.keymap.set("n", "fi", action("directory_tab_open"), { buffer = true })
    vim.keymap.set("n", "ff", action("list_children"), { buffer = true })
    vim.keymap.set("n", "F", action("list_parents"), { buffer = true })
    vim.keymap.set("n", "yy", action("yank"), { buffer = true })
    vim.keymap.set("n", "D", action("debug_print", { quit = false }), { buffer = true })
    vim.keymap.set("n", "rn", action("rename"), { buffer = true })
    vim.keymap.set("n", "O", action("search"), { buffer = true })

    vim.keymap.set("n", "rp", action("unionbuf"), { buffer = true })
    vim.keymap.set("n", "<Leader>rP", function()
      action("unionbuf", {
        action_opts = {
          convert = function(item)
            local bufnr = vim.fn.bufadd(item.path)
            vim.fn.bufload(bufnr)
            local s, e =
              require("notomo.lib.treesitter").get_expanded_row_range(bufnr, item.range.s.row, item.range.s.column)
            return {
              bufnr = bufnr,
              start_row = s,
              end_row = e,
            }
          end,
        },
      })
    end, { buffer = true })

    vim.keymap.set("n", "j", [[line('.') == line('$') ? 'gg' : 'j']], { buffer = true, expr = true, silent = true })
    vim.keymap.set("n", "k", [[line('.') == 1 ? 'G' : 'k']], { buffer = true, expr = true, silent = true })

    vim.keymap.set("n", "<Tab>", thetto_starter("thetto/action"), { buffer = true })
    vim.keymap.set("n", "[finder]<CR>", function()
      require("thetto2").resume({ offset = -1 })
    end, { buffer = true })
    vim.keymap.set("n", "[finder]n", function()
      require("thetto2").resume({ offset = -1 })
    end, { buffer = true })
    vim.keymap.set("n", "[finder]N", function()
      require("thetto2").resume({ offset = 1 })
    end, { buffer = true })

    vim.keymap.set("n", "sm", call_consumer_key("", "toggle_selection", "<Down>"), { buffer = true })
    vim.keymap.set("x", "sm", call_consumer_key("", "toggle_selection", "<ESC>"), { buffer = true })
    vim.keymap.set("n", "sa", call_consumer_key("", "toggle_all_selection", ""), { buffer = true })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = thetto_group,
  pattern = { "thetto2-input" },
  callback = function()
    vim.keymap.set("n", "<CR>", action(), { buffer = true })
    vim.keymap.set("i", "<CR>", action_key("<ESC>"), { buffer = true })

    vim.keymap.set("i", "jq", call_consumer_key("", "quit", "<Cmd>stopinsert<CR>"), { buffer = true })
    vim.keymap.set("n", "q", call_consumer("quit"), { buffer = true })

    vim.keymap.set("n", "j", call_consumer("move_to_list"), { buffer = true })
    vim.keymap.set("n", "J", [[line('.') == line('$') ? 'gg' : 'j']], { buffer = true, silent = true, expr = true })
    vim.keymap.set("n", "k", [[line('.') == 1 ? 'G' : 'k']], { buffer = true, expr = true })
    vim.keymap.set("n", "K", [[line('.') == 1 ? 'G' : 'k']], { buffer = true, expr = true })

    vim.keymap.set("i", "<C-u>", function()
      require("notomo.lib.edit").delete_prev()
    end, { buffer = true })
  end,
})

vim.keymap.set("n", "[finder]R", thetto_starter("vim/runtimepath"))
vim.keymap.set("n", "<Space>usf", thetto_starter("file/recursive"))
vim.keymap.set("n", "[finder]f", thetto_starter("file/in_dir"))
vim.keymap.set("n", "[finder]h", thetto_starter("vim/help"))
vim.keymap.set("n", "[finder]l", thetto_starter("line"))
vim.keymap.set("n", "[finder]b", thetto_starter("url/bookmark"))
vim.keymap.set("n", "[exec]gr", thetto_starter("vim/lsp/references"))
vim.keymap.set("n", "[finder]p", thetto_starter("plugin"))
vim.keymap.set("n", "[finder]e", thetto_starter("emoji"))
vim.keymap.set("n", "[finder]a", thetto_starter("aliaser"))
vim.keymap.set("n", "[finder]C", thetto_starter("cmdhndlr/runner"))
vim.keymap.set("n", "[finder]d", thetto_starter("vim/diagnostic"))
vim.keymap.set("n", "[finder]O", thetto_starter("vim/option"))
vim.keymap.set("n", "[finder]H", thetto_starter("vim/highlight_group"))
vim.keymap.set("n", "[finder]B", thetto_starter("vim/buffer"))
vim.keymap.set("n", "[finder]y", thetto_starter("file/bookmark"))
vim.keymap.set("n", "[finder]E", thetto_starter("env/variable"))
vim.keymap.set("n", "[finder]to", thetto_starter("test"))
vim.keymap.set("n", "[finder]z", thetto_starter("cmd/zsh/history"))
vim.keymap.set("n", "[finder]gP", thetto_starter("github/pull_request"))
vim.keymap.set("n", "[finder]J", thetto_starter("vim/jump"))
vim.keymap.set("n", "[finder]c", thetto_starter("vim/command"))
vim.keymap.set("n", "[finder]q", thetto_starter("cmd/jq"))
vim.keymap.set("n", "[finder]P", thetto_starter("cmd/procs"))
vim.keymap.set("n", "[finder]A", thetto_starter("vim/autocmd"))
vim.keymap.set("n", "[finder]s", thetto_starter("thetto/source"))
vim.keymap.set("n", "[finder]m", thetto_starter("listdefined/keymap"))
vim.keymap.set("n", "[finder]o", thetto_starter("cmd/ctags"))
vim.keymap.set("n", "[finder]S", thetto_starter("vim/substitute"))
vim.keymap.set("x", "[finder]s", thetto_starter("vim/substitute"))
vim.keymap.set("n", "[finder];", thetto_starter("vim/filetype", { actions = { default_action = "open_scratch" } }))

vim.keymap.set("n", "[file]f", function()
  require("thetto2").start(require("thetto2.util.source").by_name("file/alter"), {
    consumer_factory = require("thetto2.util.consumer").immediate(),
  })
end)

vim.keymap.set("n", "[file]l", function()
  require("thetto2").start(require("thetto2.util.source").by_name("file/alter"), {
    actions = { default_action = "tab_open" },
    consumer_factory = require("thetto2.util.consumer").immediate(),
  })
end)

vim.keymap.set("n", "[file]t", function()
  require("thetto2").start(require("thetto2.util.source").by_name("file/alter"), {
    opts = {
      allow_new = true,
    },
    consumer_factory = require("thetto2.util.consumer").immediate(),
  })
end)

vim.keymap.set("n", "[finder]T", function()
  require("thetto2").start(require("thetto2.util.source").by_name("vim/buffer"), {
    modify_pipeline = require("thetto2.util.pipeline").prepend({
      require("thetto2.util.filter").item(function(item)
        return vim.bo[item.bufnr].buftype == "terminal"
      end),
    }),
  })
end)
vim.keymap.set("n", "[exec]cv", thetto_starter("vim/execute", { opts = { cmd = "version" } }))

vim.keymap.set("n", "<Space>ur", function()
  require("thetto2").start(require("thetto2.util.source").by_name("file/mru", {
    cwd = require("thetto2.util.cwd").project(),
  }))
end)
