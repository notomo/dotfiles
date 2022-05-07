local M = {}

function M.setup()
  vim.keymap.set("n", "[keyword]o", [[<Cmd>lua vim.lsp.buf.definition()<CR>]], { buffer = true })
  vim.keymap.set("n", "[keyword]v", [[<Cmd>vsplit | lua vim.lsp.buf.definition()<CR>]], { buffer = true })
  vim.keymap.set("n", "[keyword]h", [[<Cmd>split | lua vim.lsp.buf.definition()<CR>]], { buffer = true })
  vim.keymap.set("n", "[keyword]t", function()
    require("wintablib.window").duplicate_as_right_tab()
    vim.lsp.buf.definition()
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
