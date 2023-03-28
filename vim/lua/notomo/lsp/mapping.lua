local util = vim.lsp.util

local M = {}

function M.go_to_definition()
  local params = util.make_position_params()
  vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result, ctx)
    if vim.tbl_contains({ "thetto", "thetto-input" }, vim.bo.filetype) then
      return require("misclib.message").warn("already canceled: " .. vim.inspect(params, { newline = "", indent = "" }))
    end
    if not result or vim.tbl_isempty(result) then
      return require("misclib.message").warn("not found: " .. vim.inspect(params, { newline = "", indent = "" }))
    end

    local client = vim.lsp.get_client_by_id(ctx.client_id)
    local handlers = client.handlers or {}
    local handler = handlers["textDocument/definition"]
    if handler then
      return handler(err, result, ctx)
    end

    if vim.tbl_islist(result) then
      util.jump_to_location(result[1], client.offset_encoding, false)
      if #result > 1 then
        vim.fn.setloclist(0, util.locations_to_items(result, client.offset_encoding))
      end
    else
      util.jump_to_location(result, client.offset_encoding, false)
    end
  end)
end

function M.setup(opts)
  local default = {
    symbol_source = "vim/lsp/document_symbol",
  }
  opts = vim.tbl_deep_extend("force", default, opts or {})

  vim.keymap.set("n", "<Leader>fs", function()
    vim.diagnostic.hide()
    vim.cmd.LspRestart()
  end, { silent = true, buffer = true })

  vim.keymap.set("n", "[exec]gn", [[<Cmd>lua vim.lsp.buf.rename()<CR>]], { silent = true, buffer = true })

  vim.keymap.set({ "n", "x" }, "[keyword]c", [[:lua vim.lsp.buf.code_action()<CR>]], { silent = true, buffer = true })
  vim.keymap.set("n", "[keyword]e", [[<Cmd>lua vim.lsp.buf.hover()<CR>]], { buffer = true })

  vim.keymap.set("n", "[keyword]o", function()
    require("notomo.lsp.mapping").go_to_definition()
  end, { buffer = true })
  vim.keymap.set("n", "[keyword]v", function()
    vim.cmd.vsplit()
    require("notomo.lsp.mapping").go_to_definition()
  end, { buffer = true })
  vim.keymap.set("n", "[keyword]h", function()
    vim.cmd.split()
    require("notomo.lsp.mapping").go_to_definition()
  end, { buffer = true })
  vim.keymap.set("n", "[keyword]t", function()
    require("wintablib.window").duplicate_as_right_tab()
    require("notomo.lsp.mapping").go_to_definition()
  end, { buffer = true })

  vim.keymap.set("n", "sl", function()
    vim.cmd.nohlsearch()
    vim.lsp.buf.document_highlight()
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      buffer = 0,
      once = true,
      callback = function()
        vim.lsp.buf.clear_references()
      end,
    })
  end, { buffer = true })

  vim.keymap.set("n", "[finder]o", function()
    require("thetto").start(opts.symbol_source)
  end, { buffer = true })
end

return M
