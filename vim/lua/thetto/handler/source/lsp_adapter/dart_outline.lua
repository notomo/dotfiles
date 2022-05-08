local util = require("notomo.plugin.thetto.util")

local M = {}

M._element_key = "element"
M._result_key = "_thetto_dart_outline"

function M.collect(self)
  local current_path = vim.fn.expand("%:p")
  local items = {}
  local result = vim.b[self._result_key] or { outline = { children = {} } }
  for _, v in ipairs(result.outline.children) do
    vim.list_extend(items, M._to_items(self, v, nil, current_path))
  end
  return items
end

function M._to_items(self, item, parent, current_path)
  if item.kind == "NEW_INSTANCE" then
    return {}
  end

  local items = {}
  local value = ""
  local desc = nil
  local pre_desc = ""
  local next_parent = nil
  local element = item[self._element_key]
  if element then
    if element.kind == "FUNCTION" then
      pre_desc = ("%s "):format(element.returnType)
      value = element.name
      desc = ("%s%s%s"):format(pre_desc, value, element.parameters)
    elseif element.kind == "METHOD" then
      pre_desc = ("%s "):format(element.returnType)
      value = ("%s.%s"):format(parent.name, element.name)
      desc = ("%s%s%s"):format(pre_desc, value, element.parameters)
    elseif element.kind == "FUNCTION_TYPE_ALIAS" then
      pre_desc = "typedef "
      value = element.name
      desc = ("%s%s = %s Function%s"):format(pre_desc, value, element.returnType, element.parameters)
    elseif element.kind == "GETTER" then
      pre_desc = ("%s get "):format(element.returnType)
      value = ("%s.%s"):format(parent.name, element.name)
      desc = ("%s%s"):format(pre_desc, value)
    elseif element.kind == "SETTER" then
      pre_desc = "set "
      value = ("%s.%s"):format(parent.name, element.name)
      desc = ("%s%s%s"):format(pre_desc, value, element.parameters)
    elseif element.kind == "CONSTRUCTOR" then
      value = element.name
      desc = ("%s%s"):format(value, element.parameters)
    elseif element.kind == "FIELD" then
      pre_desc = ("%s "):format(element.returnType)
      value = ("%s.%s"):format(parent.name, element.name)
      desc = ("%s%s"):format(pre_desc, value)
    elseif element.kind == "TOP_LEVEL_VARIABLE" then
      value = element.name
      desc = value
    elseif element.kind == "CLASS" then
      pre_desc = "class "
      value = element.name
      desc = ("%s%s"):format(pre_desc, value)
      next_parent = element
    elseif element.kind == "EXTENSION" then
      pre_desc = "extension "
      value = element.name
      desc = ("%s%s"):format(pre_desc, value)
      next_parent = element
    elseif element.kind == "CONSTRUCTOR_INVOCATION" then
      return {}
    end
  else
    return {}
  end

  local range = element.range or item.codeRange
  table.insert(items, {
    path = current_path,
    value = value,
    desc = desc,
    row = range.start.line + 1,
    column = range.start.character,
    range = util.range(range),
    column_offsets = { value = #pre_desc },
    _origin = item,
  })

  for _, v in ipairs(item.children or {}) do
    vim.list_extend(items, M._to_items(self, v, next_parent, current_path))
  end

  return items
end

function M.highlight(self, bufnr, first_line, items)
  local highlighter = self.highlights:create(bufnr)
  for i, item in ipairs(items) do
    highlighter:add("Comment", first_line + i - 1, 0, item.column_offsets.value)
    highlighter:add("Comment", first_line + i - 1, item.column_offsets.value + #item.value, -1)
  end
end

M.kind_name = "file"

return M
