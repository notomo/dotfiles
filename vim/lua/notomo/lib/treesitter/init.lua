local M = {}

function M.remove_indent(str)
  local lines = vim.split(str, "\n", { plain = true })
  lines = vim
    .iter(lines)
    :map(function(line)
      local x = line:gsub("^%s+", "")
      return x
    end)
    :totable()
  return table.concat(lines, " ")
end

function M._get_near_function_node(bufnr)
  local language = vim.bo[bufnr].filetype

  local root, err = require("misclib.treesitter").get_first_tree_root(bufnr, language)
  if err then
    error(err)
  end

  local row = unpack(vim.api.nvim_win_get_cursor(0))

  require("nvim-treesitter")
  local query = vim.treesitter.query.get(language, "locals")
  assert(query, ("%s locals query is not found"):format(language))

  local last_node = nil
  for id, node, _ in query:iter_captures(root, bufnr, 0, -1) do
    local name = query.captures[id]
    if name == "definition.function" then
      last_node = node
    end
    local start = node:start()
    if start > row then
      break
    end
  end
  if not last_node then
    error("not found near function node")
  end
  return last_node
end

function M.get_near_function_name()
  local bufnr = 0
  local node = M._get_near_function_node(bufnr)
  local text = vim.treesitter.get_node_text(node, bufnr):gsub('"', ""):gsub("'", "")
  return text
end

function M.get_current_function_range()
  local bufnr = 0
  local node = M._get_near_function_node(bufnr)
  local range_node --- @type TSNode?
  range_node = node
  for _ = 0, 2, 1 do
    range_node = range_node:parent()
    if not range_node then
      return "not found"
    end
    local s, _, e, _ = range_node:range()
    if s ~= e then
      return { s, e }
    end
  end
  return "not found"
end

function M.start()
  if require("misclib.window").is_floating(0) then
    return
  end
  vim.treesitter.start()
end

function M.setup()
  require("notomo.plugin.nvim-treesitter").mapping()
  M.start()
end

function M.get_expanded_row_range(bufnr, row, column)
  local lang = vim.treesitter.language.get_lang(vim.bo[bufnr].filetype)
  if not lang then
    return row, row
  end

  local node = vim.treesitter.get_node({
    bufnr = bufnr,
    pos = { row, column },
  })
  if not node then
    return row, row
  end

  local expanded = node:parent():parent()
  if not expanded then
    return row, row
  end
  local start_row = expanded:start()
  local end_row = expanded:end_()
  return start_row, end_row
end

function M.unwrap_selected_node()
  local pos1 = {
    vim.fn.line("v"),
    vim.fn.col("v"),
  }
  local pos2 = {
    vim.fn.line("."),
    vim.fn.col("."),
  }
  local start_pos = pos1
  local end_pos = pos2
  if pos1[1] > pos2[1] or (pos1[1] == pos2[1] and pos1[2] > pos2[2]) then
    start_pos = pos2
    end_pos = pos1
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local node = vim.treesitter.get_node({
    pos = start_pos,
    bufnr = bufnr,
  })
  if not node then
    return
  end

  local child = node:child(1)
  local child_node_text = vim.treesitter.get_node_text(child, bufnr)
  vim.api.nvim_buf_set_text(
    bufnr,
    start_pos[1] - 1,
    start_pos[2] - 1,
    end_pos[1] - 1,
    end_pos[2],
    vim.split(child_node_text, "\n", { plain = true })
  )

  require("misclib.visual_mode").leave()
end

function M.find_ancestor(base_node, typ, include_base)
  local node = base_node
  if not include_base then
    node = node:parent()
  end
  while true do
    if not node then
      return
    end

    if node:type() == typ then
      return node
    end
    node = node:parent()
  end
end

function M.find_root_ancestor(base_node, typ, include_base)
  local before_node = M.find_ancestor(base_node, typ, include_base)
  local node = before_node
  while true do
    if not node then
      return before_node
    end
    before_node = node
    node = M.find_ancestor(node, typ, false)
  end
end

return M
