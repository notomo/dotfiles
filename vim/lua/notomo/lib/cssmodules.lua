-- rough workaround for css modules editing

local M = {}

local get_import_source_node = function(base_node)
  local row, column = base_node:range()
  local method = vim.lsp.protocol.Methods.textDocument_references
  local params = vim.lsp.util.make_position_params()
  params.position = {
    character = column,
    line = row,
  }
  params.context = {
    includeDeclaration = true,
  }
  return require("promise").new(function(resolve)
    vim.lsp.buf_request(0, method, params, function(_, result)
      if not result or not result[1] then
        resolve()
        return
      end

      local import_pos = result[1].range.start

      local import_node = vim.treesitter.get_node({
        pos = { import_pos.line, import_pos.character },
      })

      local import_statement_node = import_node:parent():parent()
      local import_source_node = import_statement_node:field("source")[1]:named_child(0)
      resolve(import_source_node)
    end)
  end)
end

local get_css_path = function(import_source_node)
  local row, column = import_source_node:range()
  local params = vim.lsp.util.make_position_params()
  params.position = {
    character = column,
    line = row,
  }
  params.context = {
    includeDeclaration = true,
  }

  local method = vim.lsp.protocol.Methods.textDocument_definition
  return require("promise").new(function(resolve)
    vim.lsp.buf_request(0, method, params, function(_, result, _, err)
      for _, res in ipairs(result) do
        if vim.endswith(res.targetUri, ".css") then
          resolve(vim.uri_to_fname(res.targetUri))
          return
        end
      end
      if err then
        require("misclib.message").warn(err)
      end
      resolve()
    end)
  end)
end

local get_css_symbols = function(path)
  local bufnr = vim.fn.bufadd(path)
  vim.fn.bufload(bufnr)

  local method = vim.lsp.protocol.Methods.textDocument_documentSymbol
  local params = { textDocument = vim.lsp.util.make_text_document_params(bufnr) }
  return require("promise").new(function(resolve)
    local symbols = {}
    local already = {}
    local add = function(name)
      name = name:sub(2)
      name = vim.split(name, "[^%w_]")[1]

      if already[name] then
        return
      end

      already[name] = true
      table.insert(symbols, { name = name })
    end
    vim.lsp.buf_request(bufnr, method, params, function(_, result, _, err)
      for _, res in ipairs(result or {}) do
        add(res.name)
        for _, child in ipairs(res.children or {}) do
          add(child.name)
        end
      end
      if err then
        require("misclib.message").warn(err)
      end
      resolve(symbols)
    end)
  end)
end

local get_css_symbol = function(path, selector_name)
  local bufnr = vim.fn.bufadd(path)
  vim.fn.bufload(bufnr)

  local method = vim.lsp.protocol.Methods.textDocument_documentSymbol
  local params = { textDocument = vim.lsp.util.make_text_document_params(bufnr) }
  return require("promise").new(function(resolve)
    vim.lsp.buf_request(bufnr, method, params, function(_, result, ctx, err)
      for _, res in ipairs(result) do
        if res.name == selector_name then
          resolve(res, ctx.bufnr)
          return
        end
        for _, child in ipairs(res.children or {}) do
          if child.name == selector_name then
            resolve(child, bufnr)
            return
          end
        end
      end
      if err then
        require("misclib.message").warn(err)
      end
      resolve()
    end)
  end)
end

function M.go_to_definition(open_cmd)
  local css_selector_in_tsx = vim.treesitter.get_node()
  local selector_name = "." .. vim.treesitter.get_node_text(css_selector_in_tsx, 0)
  local base_node = css_selector_in_tsx:parent()
  local object_node = base_node:field("object")[1]
  if not object_node then
    require("misclib.message").warn("not found")
    return
  end

  return get_import_source_node(object_node)
    :next(function(node)
      if not node then
        return
      end
      return get_css_path(node)
    end)
    :next(function(css_path)
      if not css_path then
        require("misclib.message").warn("not found css path for: " .. selector_name)
        return
      end
      return get_css_symbol(css_path, selector_name)
    end)
    :next(function(result, bufnr)
      if not result then
        require("misclib.message").warn("not found symbol: " .. selector_name)
        return
      end
      if open_cmd then
        vim.cmd(open_cmd)
      end
      vim.api.nvim_set_current_buf(bufnr)
      vim.api.nvim_win_set_cursor(0, { result.range.start.line + 1, result.range.start.character })
    end)
end

function M.symbols()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local pos = { cursor_pos[1] - 1, math.max(0, cursor_pos[2] - 1) }
  local base_node = vim.treesitter.get_node({ pos = pos })
  local object_node
  if base_node:type() ~= "member_expression" then
    object_node =
      vim.treesitter.get_node({ pos = {
        cursor_pos[1] - 1,
        math.max(0, cursor_pos[2] - 2),
      } })
  else
    object_node = base_node:parent():field("object")[1]
  end

  if not object_node then
    return require("promise").resolve({})
  end

  return get_import_source_node(object_node)
    :next(function(node)
      if not node then
        return
      end
      return get_css_path(node)
    end)
    :next(function(css_path)
      if not css_path then
        return {}
      end
      return get_css_symbols(css_path)
    end)
end

return M
