local M = {}

M.opts = {
  scope = "all",
  get_paths = function()
    return { vim.fn.expand("%:p") }
  end,
}

local to_item = function(test, path)
  local name_node = test.name_nodes[#test.name_nodes]
  local row, column = name_node:start()
  return {
    value = test.full_name,
    is_leaf = #test.children == 0,
    row = row + 1,
    column = column,
    path = path,
    column_offsets = {
      name = #test.full_name - #test.name,
    },
  }
end

function M._collect(test, path)
  local items = { to_item(test, path) }
  for _, child in ipairs(test.children) do
    vim.list_extend(items, M._collect(child, path))
  end
  return items
end

function M.collect(source_ctx)
  local items = {}
  local paths = source_ctx.opts.get_paths()
  for _, path in ipairs(paths) do
    local tests, _, err = require("gettest").nodes({
      scope = source_ctx.opts.scope,
      target = {
        path = path,
        row = vim.fn.line("."),
      },
    })
    if err then
      return nil, err
    end
    for _, test in ipairs(tests) do
      vim.list_extend(items, M._collect(test, path))
    end
  end
  return items
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

M.default_action = "execute"

return M
