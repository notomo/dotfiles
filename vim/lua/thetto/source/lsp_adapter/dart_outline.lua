local util = require("notomo/thetto_util")

local M = {}

M._element_key = "element"
M._result_key = "_thetto_dart_outline"

function M.collect(self)
  local current_path = vim.fn.expand("%:p")
  local items = {}
  local result = vim.b[self._result_key] or {outline = {children = {}}}
  for _, v in ipairs(result.outline.children) do
    vim.list_extend(items, M._to_items(self, v, nil, current_path))
  end
  return items
end

function M._to_items(self, item, parent_class, current_path)
  local items = {}

  if item.kind == "NEW_INSTANCE" then
    return {}
  end

  local value = ""
  local desc = nil
  local pre_desc = ""
  local class = nil
  local element = item[self._element_key]
  if element then
    if element.kind == "FUNCTION" then
      pre_desc = ("%s "):format(element.returnType)
      value = element.name
      desc = ("%s%s%s"):format(pre_desc, value, element.parameters)
    elseif element.kind == "METHOD" then
      pre_desc = ("%s "):format(element.returnType)
      value = ("%s.%s"):format(parent_class.name, element.name)
      desc = ("%s%s%s"):format(pre_desc, value, element.parameters)
    elseif element.kind == "CONSTRUCTOR" then
      value = element.name
      desc = ("%s%s"):format(value, element.parameters)
    elseif element.kind == "FIELD" then
      pre_desc = ("%s "):format(element.returnType)
      value = ("%s.%s"):format(parent_class.name, element.name)
      desc = ("%s%s"):format(pre_desc, value)
    elseif element.kind == "CLASS" then
      pre_desc = "class "
      value = element.name
      desc = ("%s%s"):format(pre_desc, value)
      class = element
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
    column_offsets = {value = #pre_desc},
    _origin = item,
  })

  for _, v in ipairs(item.children or {}) do
    vim.list_extend(items, M._to_items(self, v, class, current_path))
  end

  return items
end

M.highlight = function(self, bufnr, items)
  local highlighter = self.highlights:reset(bufnr)
  for i, item in ipairs(items) do
    highlighter:add("Comment", i - 1, 0, item.column_offsets.value)
    highlighter:add("Comment", i - 1, item.column_offsets.value + #item.value, -1)
  end
end

M.kind_name = "file"

return M
