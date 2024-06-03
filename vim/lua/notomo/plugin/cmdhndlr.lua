vim.keymap.set("n", "<Leader>Q", [[<Cmd>lua require("cmdhndlr").run()<CR>]])
vim.keymap.set("x", "<Leader>Q", [[<Cmd>lua require("cmdhndlr").run()<CR>]])

local build_cmd = function(default_cmd, callback)
  local cmd
  if type(default_cmd) == "table" then
    cmd = table.concat(default_cmd, " ")
  else
    cmd = default_cmd
  end

  vim.ui.input({
    prompt = "Command:",
    default = cmd .. " ",
  }, function(input)
    if not input then
      return callback()
    end
    vim.schedule(function()
      callback(input)
    end)
  end)
end

vim.keymap.set("n", "<Leader>qr", function()
  require("cmdhndlr").run({ build_cmd = build_cmd })
end)
vim.keymap.set("n", "<Leader>qt", function()
  require("cmdhndlr").test({ build_cmd = build_cmd })
end)
vim.keymap.set("n", "<Leader>qb", function()
  require("cmdhndlr").build({ build_cmd = build_cmd })
end)

local decide_runner = function()
  if require("cmdhndlr").get("build_runner/make/make").working_dir_marker() then
    return "make/make"
  end
  return "javascript/npm"
end

vim.keymap.set("n", "[test]t", function()
  local runner = decide_runner()
  require("cmdhndlr").test({ name = runner, layout = { type = "tab" } })
end)
vim.keymap.set("n", "S", function()
  local runner = decide_runner()
  require("cmdhndlr").run({
    name = runner,
    runner_opts = { target = "start" },
    layout = { type = "tab_drop" },
    hooks = {
      failure = require("cmdhndlr.util.hook").echo_failure(),
    },
    reuse_predicate = function(current_state, state)
      local same = current_state.full_name == state.full_name
        and current_state.working_dir_path == state.working_dir_path
        and vim.deep_equal(current_state.cmd, state.executed_cmd)
      return same
    end,
  })
end)
vim.keymap.set("n", "[exec]bl", function()
  local runner = decide_runner()
  require("cmdhndlr").build({ name = runner })
end)
vim.keymap.set("n", "[exec]bL", [[<Cmd>lua require("cmdhndlr").build()<CR>]])

vim.keymap.set("n", "<Leader>F", [[<Cmd>lua require("cmdhndlr").format()<CR>]])
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = vim.api.nvim_create_augroup("cmdhndlr_format_setting", {}),
  pattern = { "*" },
  callback = function(args)
    local bufnr = args.buf
    if vim.b[bufnr].notomo_format_disabled then
      return
    end
    if not require("cmdhndlr").enabled("format_runner") then
      return
    end

    require("cmdhndlr").setup({
      opts = {
        format_runner = {
          ["lua/stylua"] = {
            build_cmd = function(cmd, callback, ctx)
              local upward = vim.fs.find({ "stylua.toml", ".stylua.toml" }, {
                upward = true,
                stop = vim.uv.os_homedir(),
                path = vim.fs.dirname(vim.api.nvim_buf_get_name(ctx.bufnr)),
                type = "file",
                limit = 1,
              })[1]
              if upward then
                vim.list_extend(cmd, { "--config-path", upward })
                callback(cmd)
                return
              end

              local workflow = require("optpack").get("workflow")
              local default = vim.fs.joinpath(workflow.directory, "stylua.toml")
              vim.list_extend(cmd, { "--config-path", default })
              callback(cmd)
            end,
          },
        },
      },
    })

    require("cmdhndlr").format({
      hooks = {
        success = function()
          vim.api.nvim_buf_call(bufnr, function()
            return vim.cmd.update({ mods = { silent = true, noautocmd = true } })
          end)
        end,
        pre_execute = function() end,
      },
    })
  end,
})

vim.keymap.set("n", "[test]f", [[<Cmd>lua require("cmdhndlr").test({layout = {type = "tab"}})<CR>]])
vim.keymap.set("n", "[test]n", function()
  local test = require("gettest").nodes({
    scope = "smallest_ancestor",
    target = { row = vim.fn.line(".") },
  })[1]
  test = test or { children = {} }
  require("cmdhndlr").test({ filter = test.full_name, is_leaf = #test.children == 0 })
end)
vim.keymap.set("n", "[test]N", function()
  local test = require("gettest").nodes({
    scope = "largest_ancestor",
    target = { row = vim.fn.line(".") },
  })[1]
  test = test or { children = {} }
  require("cmdhndlr").test({ filter = test.full_name, is_leaf = #test.children == 0 })
end)
vim.keymap.set("x", "[test]N", function()
  local selected_text = require("notomo.lib.edit").get_selected_text()

  local tests, info = require("gettest").nodes({
    scope = "smallest_ancestor",
    target = { row = vim.fn.line(".") },
  })
  local test = tests[1]
  test = test or { children = {} }

  require("cmdhndlr").test({ filter = test.full_name .. info.tool.separator .. selected_text })
end)

vim.keymap.set("n", "[test]d", function()
  local test = require("gettest").nodes({
    scope = "smallest_ancestor",
    target = { row = vim.fn.line(".") },
  })[1]
  if not test then
    require("misclib.message").warn("not found test")
    return nil
  end

  require("dap").run({
    type = vim.bo.filetype,
    name = test.full_name,
    request = "launch",
    mode = "test",
    program = "${relativeFileDirname}",
    args = { "-test.run", test.full_name },
  })
end)

vim.keymap.set("x", "[test]d", function()
  local selected_text = require("notomo.lib.edit").get_selected_text()

  local tests, info = require("gettest").nodes({
    scope = "smallest_ancestor",
    target = { row = vim.fn.line(".") },
  })
  local test = tests[1]
  if not test then
    require("misclib.message").warn("not found test")
    return nil
  end
  require("misclib.visual_mode").leave()

  local name = test.full_name .. info.tool.separator .. selected_text
  require("dap").run({
    type = vim.bo.filetype,
    name = name,
    request = "launch",
    mode = "test",
    program = "${relativeFileDirname}",
    args = { "-test.run", name },
  })
end)

vim.keymap.set("n", "<Leader>D", function()
  vim.ui.input({ prompt = "Debug args: " }, function(input)
    if not input then
      require("misclib.message").info("Canceled debug.")
      return
    end
    local args = vim.split(input, "%s+", { trimempty = true })
    vim.schedule(function()
      require("dap").run({
        type = vim.bo.filetype,
        name = "Debug",
        request = "launch",
        program = "${file}",
        args = args,
      })
    end)
  end)
end)

local group = vim.api.nvim_create_augroup("cmdhndlr_setting", {})
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = group,
  pattern = { "cmdhndlr" },
  callback = function()
    vim.keymap.set("n", "[file]rl", [[<Cmd>lua require("cmdhndlr").retry()<CR>]], { buffer = true })
  end,
})
