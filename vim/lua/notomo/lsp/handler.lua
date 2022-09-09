local M = {}

local ignored_diagnostic = {
  -- diagnostic.source = {diagnostic.code = true}
  deno = { ["import-map-remap"] = true },
}

function M.publish_diagnostics(err, result, ctx, config)
  result.diagnostics = vim.tbl_filter(function(e)
    return not vim.tbl_get(ignored_diagnostic, e.source, e.code)
  end, result.diagnostics)

  vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
  vim.diagnostic.setloclist({
    open = false,
    namespace = vim.lsp.diagnostic.get_namespace(ctx.client_id),
  })
end

function M.dart_publish_outline(_, result, ctx)
  vim.api.nvim_buf_set_var(ctx.bufnr or 0, "_thetto_dart_outline", result)
end

function M.dart_publish_flutter_outline(_, result, ctx)
  vim.api.nvim_buf_set_var(ctx.bufnr or 0, "_thetto_flutter_outline", result)
end

M.ignored_progress = { "null-ls" }
function M.progress()
  local messages = vim.tbl_filter(function(msg)
    return not vim.tbl_contains(M.ignored_progress, msg.name)
  end, vim.lsp.util.get_progress_messages())
  for _, msg in ipairs(messages) do
    if msg.done and not msg.message then
      msg.message = "done"
    end
    local text = ("[%s] %s: %s"):format(msg.name, msg.title, msg.message)
    vim.api.nvim_echo({ { text } }, msg.done, {})
  end
end

vim.lsp.set_log_level("error")

vim.lsp.handlers["textDocument/publishDiagnostics"] = function(...)
  require("notomo.lsp.handler").publish_diagnostics(...)
end
vim.lsp.handlers["dart/textDocument/publishOutline"] = function(...)
  require("notomo.lsp.handler").dart_publish_outline(...)
end
vim.lsp.handlers["dart/textDocument/publishFlutterOutline"] = function(...)
  require("notomo.lsp.handler").dart_publish_flutter_outline(...)
end

vim.api.nvim_create_augroup("notomo_lsp_progress", {})
vim.api.nvim_create_autocmd({ "User" }, {
  group = "notomo_lsp_progress",
  pattern = { "LspProgressUpdate" },
  callback = function()
    require("notomo.lsp.handler").progress()
  end,
})

require("notomo.mapping.util").set_prefix({ "n" }, "lc", "<Leader>f")
vim.keymap.set("n", "[lc]D", [[<Cmd>lua vim.lsp.buf.type_definition()<CR>]], { silent = true })
vim.keymap.set("n", "[lc]K", [[<Cmd>lua vim.lsp.buf.signature_help()<CR>]], { silent = true })
vim.keymap.set("n", "[lc]s", [[<Cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>]], { silent = true })
vim.keymap.set("n", "[exec]gn", [[<Cmd>lua vim.lsp.buf.rename()<CR>]], { silent = true })
vim.keymap.set("n", "[exec]gf", [[<Cmd>lua vim.lsp.buf.format({async = true})<CR>]])
vim.keymap.set("n", "[keyword]c", [[<Cmd>lua vim.lsp.buf.code_action()<CR>]], { silent = true })
vim.keymap.set("x", "[keyword]c", [[:lua vim.lsp.buf.range_code_action()<CR>]], { silent = true })
vim.keymap.set("n", "[keyword]e", [[<Cmd>lua vim.lsp.buf.hover()<CR>]])

local original_select = vim.ui.select
vim.ui.select = function(items, opts, on_choice)
  if opts.kind == "codeaction" and #items == 1 and items[1][2].kind == "refactor.extract" then
    require("misclib.message").info("Executed: " .. items[1][2].title, "Title")
    return on_choice(items[1])
  end
  original_select(items, opts, on_choice)
end

vim.ui.input = function(opts, on_confirm)
  local bufnr = vim.api.nvim_create_buf(false, true)
  local default_line = opts.default
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { default_line })
  vim.bo[bufnr].bufhidden = "wipe"

  vim.api.nvim_echo({ { "" } }, false, {})

  local window_id = vim.api.nvim_open_win(bufnr, true, {
    width = vim.o.columns,
    height = 2,
    relative = "editor",
    row = vim.o.lines - vim.o.cmdheight,
    col = 0,
    external = false,
    style = "minimal",
    zindex = 200,
  })
  local prompt = opts.prompt or ""
  vim.wo[window_id].winbar = " " .. prompt
  vim.wo[window_id].winhighlight = "Normal:Normal,SignColumn:Normal"
  vim.wo[window_id].signcolumn = "yes:1"
  vim.cmd.normal({ args = { "$" }, bang = true })

  local cancel = function()
    on_confirm()
    if vim.api.nvim_win_is_valid(window_id) then
      vim.api.nvim_win_close(window_id, true)
    end
    vim.api.nvim_echo({ { "Canceled: " .. prompt .. default_line } }, false, {})
  end

  local group = vim.api.nvim_create_augroup("notomo_ui_input", {})
  vim.api.nvim_create_autocmd({ "WinClosed", "WinLeave", "TabLeave", "BufLeave", "BufWipeout" }, {
    group = group,
    buffer = bufnr,
    callback = cancel,
    once = true,
  })
  vim.keymap.set("n", "q", cancel)

  local confirm = function()
    local line = vim.fn.getline(".")
    if line == default_line then
      return cancel()
    end

    on_confirm(line)

    vim.api.nvim_clear_autocmds({ group = group })
    if vim.api.nvim_win_is_valid(window_id) then
      vim.api.nvim_win_close(window_id, true)
    end
  end

  vim.keymap.set("n", "<CR>", confirm, { buffer = bufnr })
  vim.keymap.set("n", "[file]w", confirm, { buffer = bufnr })
end

return M
