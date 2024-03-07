local util = vim.lsp.util

local M = {}

local go_to = function(method, params)
  vim.lsp.buf_request(
    0,
    method,
    params,
    require("lsp-handler-intercept").wrap(function(err, result, ctx)
      if vim.tbl_contains({ "thetto", "thetto-inputter" }, vim.bo.filetype) then
        return require("misclib.message").warn(
          "already canceled: " .. vim.inspect({ client_id = ctx.client_id }, { newline = "", indent = "" })
        )
      end
      if not result or vim.tbl_isempty(result) then
        return require("misclib.message").warn(
          "not found : " .. vim.inspect({ client_id = ctx.client_id }, { newline = "", indent = "" })
        )
      end

      local client = vim.lsp.get_client_by_id(ctx.client_id)
      local handlers = client.handlers or {}
      local handler = handlers[method]
      if handler then
        return handler(err, result, ctx)
      end

      if not vim.tbl_islist(result) then
        result = { result }
      end

      local already = {}
      local location_items = vim
        .iter(vim.lsp.util.locations_to_items(result, client.offset_encoding))
        :map(function(e)
          local path_with_row = ("%s:%d"):format(e.filename, e.lnum)
          if already[path_with_row] then
            return nil
          end
          already[path_with_row] = true
          return e
        end)
        :totable()

      if #location_items > 1 then
        require("thetto").start({
          collect = function(source_ctx)
            return vim
              .iter(location_items)
              :map(function(e)
                local relative_path = require("thetto.lib.path").to_relative(e.filename, source_ctx.cwd)
                local value = ("%s:%s:%d"):format(relative_path, e.lnum, e.col)
                return {
                  value = value,
                  path = e.filename,
                  row = e.lnum,
                }
              end)
              :totable()
          end,
          cwd = require("thetto.util.cwd").project(),
          consumer_opts = { ui = { insert = false } },
          kind_name = "file",
        })
      else
        util.jump_to_location(result[1], client.offset_encoding, false)
      end
    end)
  )
end

function M.go_to_definition()
  local params = util.make_position_params()
  go_to(vim.lsp.protocol.Methods.textDocument_definition, params)
end

function M.go_to_type_definition()
  local params = util.make_position_params()
  go_to(vim.lsp.protocol.Methods.textDocument_typeDefinition, params)
end

function M.yank_function_arg_labels()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, vim.lsp.protocol.Methods.textDocument_signatureHelp, params, function(err, result)
    if err then
      error(err)
    end

    local signatures = result.signatures
    table.sort(signatures, function(a, b)
      return #a.parameters > #b.parameters
    end)

    local signature = result.signatures[1] or {}
    local parameters = signature.parameters or {}

    local name_pattern = "[a-zA-Z_]+"
    local labels = vim.tbl_map(function(param)
      if type(param.label) == "string" then
        return param.label:match(name_pattern)
      end
      local s = param.label[1] + 1
      local e = param.label[2]
      local label = signature.label:sub(s, e)
      local name = label:match(name_pattern)
      return name
    end, parameters)

    local str = table.concat(labels, ", ")
    require("notomo.lib.edit").yank(str)
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
  vim.keymap.set({ "n", "x" }, "[keyword]a", function()
    vim.lsp.buf.code_action({
      filter = function(e)
        return (e.title:find("Add import") or e.title:find("Update import")) ~= nil
      end,
      apply = true,
    })
  end, { silent = true, buffer = true })
  vim.keymap.set({ "n", "x" }, "[keyword]p", function()
    vim.lsp.buf.code_action({
      filter = function(e)
        return e.title:find("Add missing") ~= nil
      end,
      apply = true,
    })
  end, { silent = true, buffer = true })
  vim.keymap.set("n", "[keyword]e", function()
    vim.api.nvim_echo({ { "" } }, false, {}) -- reset message
    vim.lsp.buf.hover()
  end, { buffer = true })

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

  vim.keymap.set("n", "[keyword]O", function()
    require("notomo.lsp.mapping").go_to_type_definition()
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

  vim.keymap.set("n", "si", function()
    vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled(0))
  end, { buffer = true })

  vim.keymap.set("n", "[finder]o", function()
    require("thetto.util.source").start_by_name(opts.symbol_source)
  end, { buffer = true })

  vim.keymap.set("n", "[yank]a", function()
    require("notomo.lsp.mapping").yank_function_arg_labels()
  end, { buffer = true })

  vim.keymap.set("n", "<Space>qo", function()
    vim.diagnostic.open_float({
      source = true,
    })
  end, { buffer = true })
end

return M
