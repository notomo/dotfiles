local M = {}

M.opts = {
  scope = "all",
  get_paths = function(_, bufnr)
    return { vim.api.nvim_buf_get_name(bufnr) }
  end,
}

local to_item = function(test, path, is_toplevel)
  local name_node = test.name_nodes[#test.name_nodes]
  local row, column = name_node:start()
  local end_row, end_column = name_node:end_()
  local full_name = test.full_name:gsub("\n", " ")
  return {
    value = full_name,
    is_leaf = #test.children == 0,
    is_toplevel = is_toplevel or false,
    row = row + 1,
    column = column,
    end_row = end_row,
    end_column = end_column,
    path = path,
    column_offsets = {
      name = #test.full_name - #test.name,
    },
  }
end

function M._collect(test, path, is_toplevel)
  local items = { to_item(test, path, is_toplevel) }
  for _, child in ipairs(test.children) do
    vim.list_extend(items, M._collect(child, path, false))
  end
  return items
end

function M.collect(source_ctx)
  local tool_name
  if require("cmdhndlr").get("test_runner/typescript/deno").working_dir_marker() then
    tool_name = "deno_test"
  elseif require("cmdhndlr").get("test_runner/typescript/playwright").working_dir_marker() then
    tool_name = "playwright"
  end

  return vim
    .iter(source_ctx.opts.get_paths(source_ctx.cwd, source_ctx.bufnr))
    :map(function(path)
      local tests = require("gettest").nodes({
        scope = source_ctx.opts.scope,
        target = {
          source = source_ctx.bufnr,
          row = vim.fn.line("."),
        },
        tool_name = tool_name,
      })
      return vim
        .iter(tests)
        :map(function(test)
          return M._collect(test, path, true)
        end)
        :flatten()
        :totable()
    end)
    :flatten()
    :totable()
end

M.highlight = require("thetto.util.highlight").columns({
  {
    group = "Comment",
    end_key = "name",
  },
})

M.kind_name = "file"

M.actions = {
  action_execute = function(items)
    local window_id = vim.api.nvim_get_current_win()
    for _, item in ipairs(items) do
      vim.api.nvim_set_current_win(window_id)
      require("cmdhndlr").test({ filter = item.value, is_leaf = item.is_leaf, layout = { type = "tab" } })
    end
  end,
}

return M
