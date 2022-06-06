local util = vim.lsp.util

local M = {}

function M.go_to_definition()
  local params = util.make_position_params()
  vim.lsp.buf_request(0, "textDocument/definition", params, function(_, result, ctx)
    if vim.tbl_contains({ "thetto", "thetto-input" }, vim.bo.filetype) then
      return require("misclib.message").warn("already canceled: " .. vim.inspect(params, { newline = "", indent = "" }))
    end
    if not result or vim.tbl_isempty(result) then
      return require("misclib.message").warn("not found: " .. vim.inspect(params, { newline = "", indent = "" }))
    end

    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if vim.tbl_islist(result) then
      util.jump_to_location(result[1], client.offset_encoding)
      if #result > 1 then
        vim.fn.setloclist(0, util.locations_to_items(result))
      end
    else
      util.jump_to_location(result, client.offset_encoding)
    end
  end)
end

function M.setup()
  vim.keymap.set("n", "[keyword]o", M.go_to_definition, { buffer = true })
  vim.keymap.set("n", "[keyword]v", function()
    vim.cmd([[vsplit]])
    M.go_to_definition()
  end, { buffer = true })
  vim.keymap.set("n", "[keyword]h", function()
    vim.cmd([[split]])
    M.go_to_definition()
  end, { buffer = true })
  vim.keymap.set("n", "[keyword]t", function()
    require("wintablib.window").duplicate_as_right_tab()
    M.go_to_definition()
  end, { buffer = true })
  vim.keymap.set("n", "sl", function()
    vim.cmd([[nohlsearch]])
    vim.lsp.buf.document_highlight()
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      buffer = 0,
      once = true,
      callback = function()
        vim.lsp.buf.clear_references()
      end,
    })
  end, { buffer = true })
end

return M
