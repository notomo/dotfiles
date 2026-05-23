local M = {}

local declarations_by_filetype = {
  terraform = { "block" },
  lua = { "function_declaration" },
  go = {
    "function_declaration",
    "method_declaration",
    "type_declaration",
    "var_declaration",
    "const_declaration",
  },
  typescript = {
    "function_declaration",
    "class_declaration",
    "interface_declaration",
    "type_alias_declaration",
    "lexical_declaration",
    "enum_declaration",
    "export_statement",
  },
  typescriptreact = {
    "function_declaration",
    "class_declaration",
    "interface_declaration",
    "type_alias_declaration",
    "lexical_declaration",
    "enum_declaration",
    "export_statement",
  },
  prisma = {
    "model_declaration",
    "enum_declaration",
    "datasource_declaration",
    "generator_declaration",
    "type_declaration",
  },
  moonbit = {
    "function_definition",
    "trait_definition",
    "struct_definition",
    "enum_definition",
    "type_definition",
    "let_declaration",
  },
}

local function to_set(types)
  local set = {}
  for _, t in ipairs(types) do
    set[t] = true
  end
  return set
end

local function find_root_decl(base_node, type_set)
  local match
  local node = base_node
  while node do
    if type_set[node:type()] then
      match = node
    end
    node = node:parent()
  end
  return match
end

local function find_sibling_decl(node, type_set, dir)
  local step = dir == "next" and node.next_sibling or node.prev_sibling
  local sibling = step(node)
  while sibling do
    if type_set[sibling:type()] then
      return sibling
    end
    sibling = step(sibling)
  end
  return nil
end

local function find_root_node(node)
  while node:parent() do
    node = node:parent()
  end
  return node
end

local function collect_top_level_decls(root, type_set)
  local decls = {}
  for child in root:iter_children() do
    if type_set[child:type()] then
      table.insert(decls, child)
    end
  end
  return decls
end

local function jump(node)
  local row, column = node:start()
  require("misclib.window").jump(0, row + 1, column)
end

local function get_type_set()
  local types = declarations_by_filetype[vim.bo.filetype]
  if not types then
    return nil
  end
  return to_set(types)
end

function M.go_to_prev()
  local type_set = get_type_set()
  if not type_set then
    return
  end

  local base_node = vim.treesitter.get_node({})
  if not base_node then
    return
  end

  local cursor_row = vim.api.nvim_win_get_cursor(0)[1] - 1
  local decl = find_root_decl(base_node, type_set)
  local target
  if decl then
    if decl:start() == cursor_row then
      target = find_sibling_decl(decl, type_set, "prev")
    else
      target = decl
    end
  end
  if not target then
    local decls = collect_top_level_decls(find_root_node(base_node), type_set)
    if #decls == 0 then
      return
    end
    for i = #decls, 1, -1 do
      if decls[i]:start() < cursor_row then
        target = decls[i]
        break
      end
    end
    target = target or decls[#decls]
  end
  jump(target)
end

function M.go_to_next()
  local type_set = get_type_set()
  if not type_set then
    return
  end

  local base_node = vim.treesitter.get_node({})
  if not base_node then
    return
  end

  local decl = find_root_decl(base_node, type_set)
  local target
  if decl then
    target = find_sibling_decl(decl, type_set, "next")
  end
  if not target then
    local decls = collect_top_level_decls(find_root_node(base_node), type_set)
    if #decls == 0 then
      return
    end
    local cursor_row = vim.api.nvim_win_get_cursor(0)[1] - 1
    for _, d in ipairs(decls) do
      if d:start() > cursor_row then
        target = d
        break
      end
    end
    target = target or decls[1]
  end
  jump(target)
end

return M
