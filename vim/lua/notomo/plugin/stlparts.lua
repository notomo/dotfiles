local vim = vim
local api = vim.api
local fn = vim.fn
local fs = vim.fs
local stlparts = require("stlparts")
local C = stlparts.component
local join_by = require("misclib.collection.list").join_by

local escape = function(s)
  s = s:gsub("%%", "%%%%")
  return s
end

local alter_path = function(ctx)
  local bufnr = vim.api.nvim_win_call(ctx.window_id, function()
    return fn.bufnr("#")
  end)
  if bufnr == -1 then
    return ""
  end
  local path = api.nvim_buf_get_name(bufnr)
  return fn.fnamemodify(path, ":~")
end

local get_bufnr = function(ctx)
  return vim.api.nvim_win_get_buf(ctx.window_id)
end
local get_filetype = function(ctx)
  return vim.bo[get_bufnr(ctx)].filetype
end
local Switch = C.switch
local SwitchByFiletype = function(...)
  return Switch(get_filetype, ...)
end

local set_statusline = function()
  local surround = function(s)
    return ("[%s]"):format(s)
  end
  local cwd = function()
    return escape(fn.getcwd())
  end
  local filetype = function(ctx)
    return surround(get_filetype(ctx))
  end
  local column = function()
    return surround(fn.col("."))
  end
  local path = function()
    return escape(fn.expand("%:p:~"))
  end
  local branch = function()
    local branch_name = require("notomo.lib.git").branch_component()
    if #branch_name == 0 then
      return ""
    end
    return surround(branch_name)
  end
  local active_ls_names = function(ctx)
    local bufnr = get_bufnr(ctx)
    if vim.bo[bufnr].filetype == "" then
      return surround("")
    end
    local names = vim
      .iter(vim.lsp.get_clients({ bufnr = bufnr }))
      :map(function(client)
        if client:is_stopped() then
          return nil
        end

        local done_clients = vim.g.notomo_done_clients or {}
        if not done_clients[tostring(client.id)] then
          return nil
        end

        return client.name
      end)
      :totable()
    return surround(table.concat(names, ", "))
  end

  local TruncateLeft = C.truncate_left
  local Truncate = function(component)
    return TruncateLeft(component, {
      max_width = function(ctx)
        return ctx:width() * 0.8
      end,
    })
  end
  local Separate = C.separate

  local Base = function(path_component)
    return Separate({
      Truncate(join_by({ path_component, branch }, " ")),
      join_by({ column, active_ls_names, filetype }, " "),
    })
  end

  stlparts.set("statusline", {
    " ",
    SwitchByFiletype({
      ["kivi-file"] = Truncate(join_by({ cwd, branch }, " ")),
      ["thetto"] = Base(alter_path),
      ["thetto-inputter"] = Base(alter_path),
      _ = Base(path),
    }),
    " ",
  })

  vim.opt.statusline = [[%!v:lua.require("stlparts").build("statusline")]]
end
set_statusline()

local window_count = function(window_ids)
  local floating_window_ids = vim
    .iter(window_ids)
    :filter(function(window_id)
      return api.nvim_win_get_config(window_id).relative ~= ""
    end)
    :totable()
  local count = #window_ids - #floating_window_ids
  if count == 1 then
    return ""
  end
  return tostring(count)
end

local modified = function(current_bufnr, window_ids)
  if vim.bo[current_bufnr].modified then
    return "+"
  end

  local modified_window_ids = vim
    .iter(window_ids)
    :filter(function(window_id)
      local bufnr = api.nvim_win_get_buf(window_id)
      return vim.bo[bufnr].modified
    end)
    :totable()

  if #modified_window_ids > 0 then
    return "(+)"
  end
  return ""
end

local tab_label = function(tab_id, window_id)
  local bufnr = api.nvim_win_get_buf(window_id)
  local name = fs.basename(api.nvim_buf_get_name(bufnr))
  if name == "" then
    name = "[Scratch]"
  end

  local window_ids = api.nvim_tabpage_list_wins(tab_id)
  local opt = window_count(window_ids) .. modified(bufnr, window_ids)
  if opt == "" then
    return name
  end
  return ("%s[%s]"):format(name, opt)
end

local set_tabline = function()
  local Builder = C.builder
  local Highlight = C.highlight
  local DefaultHighlight = C.default_highlight
  local Tab = C.tab
  local ContextBuilder = C.context_builder

  local TruncateRight = function(component)
    return C.truncate_right(component, {
      max_width = 30,
    })
  end
  local TruncateLeft = function(component)
    return C.truncate_left(component, {
      max_width = 30,
    })
  end

  local get_buftype = function(ctx)
    return vim.bo[get_bufnr(ctx)].buftype
  end
  local Truncate = function(component)
    return Switch(get_buftype, {
      terminal = TruncateRight(component),
      _ = TruncateLeft(component),
    })
  end

  local alter = function(ctx)
    local bufnr = vim.api.nvim_win_call(ctx.window_id, function()
      return fn.bufnr("#")
    end)
    if bufnr == -1 then
      return ctx
    end

    local window_id = fn.bufwinid(bufnr)
    if window_id == -1 then
      return ctx
    end

    return ctx:with_window(window_id)
  end
  local TruncateAlter = function(component)
    return ContextBuilder(alter, Truncate(component))
  end

  local TabLabel = function(ctx)
    return escape(tab_label(ctx.tab_id, ctx.window_id))
  end
  local Content = {
    " ",
    SwitchByFiletype({
      ["kivi-file"] = TruncateLeft(function(ctx)
        local tab_number = api.nvim_tabpage_get_number(ctx.tab_id)
        local name = fs.basename(fn.getcwd(ctx.window_id, tab_number)) .. "/"
        return escape(name)
      end),
      ["thetto"] = TruncateAlter(TabLabel),
      ["thetto-inputter"] = TruncateAlter(TabLabel),
      _ = Truncate(TabLabel),
    }),
    " ",
  }

  local current_buffer_diagnostic = function(window_id)
    local is_float = require("misclib.window").is_floating(window_id)
    local bufnr = is_float
        and vim.api.nvim_win_call(window_id, function()
          local b = fn.bufnr("#")
          return b ~= -1 and b or nil
        end)
      or vim.api.nvim_win_get_buf(window_id)

    local severity = vim.diagnostic.severity

    local counts = vim.iter(vim.diagnostic.get(bufnr)):fold({
      [severity.ERROR] = 0,
      [severity.WARN] = 0,
      [severity.INFO] = 0,
      [severity.HINT] = 0,
    }, function(acc, d)
      acc[d.severity] = acc[d.severity] + 1
      return acc
    end)

    return vim
      .iter({
        {
          str = "ERROR",
          count = counts[severity.ERROR],
          hl_group = "DiagnosticError",
        },
        {
          str = "WARN",
          count = counts[severity.WARN],
          hl_group = "DiagnosticWarn",
        },
        {
          str = "INFO",
          count = counts[severity.INFO],
          hl_group = "DiagnosticInfo",
        },
        {
          str = "HINT",
          count = counts[severity.HINT],
          hl_group = "DiagnosticHint",
        },
      })
      :filter(function(x)
        return x.count > 0
      end)
      :map(function(x)
        return {
          Highlight(x.hl_group, x.str),
          (":%d"):format(x.count),
        }
      end)
      :totable()
  end

  stlparts.set(
    "tabline",
    DefaultHighlight(
      "TabLineFill",
      Builder(function()
        local tab_ids = api.nvim_list_tabpages()
        local current = api.nvim_get_current_tabpage()
        local components = vim
          .iter(tab_ids)
          :map(function(tab_id)
            local is_current = tab_id == current
            local hl_group = is_current and "TabLineSel" or "TabLine"
            return Tab(tab_id, Highlight(hl_group, Content))
          end)
          :totable()

        table.insert(components, " ")

        local current_window_id = vim.api.nvim_tabpage_get_win(current)
        local current_bufnr = vim.api.nvim_win_get_buf(current_window_id)
        local exists_modified = vim.iter(vim.api.nvim_list_bufs()):any(function(bufnr)
          return bufnr ~= current_bufnr
            and vim.api.nvim_buf_is_valid(bufnr)
            and vim.bo[bufnr].buflisted
            and vim.bo[bufnr].modified
        end)
        if exists_modified then
          table.insert(components, Highlight("TablineSel", " + "))
        end

        local diagnostic = current_buffer_diagnostic(current_window_id)
        if #diagnostic > 0 then
          vim.list_extend(
            components,
            { Highlight("Comment", " [ "), join_by(diagnostic, " "), Highlight("Comment", " ] ") }
          )
        end

        return components
      end)
    )
  )

  local group = vim.api.nvim_create_augroup("notomo.stlparts.diagnostic", {})
  vim.api.nvim_create_autocmd("DiagnosticChanged", {
    group = group,
    callback = function()
      vim.cmd.redrawtabline()
    end,
  })

  vim.opt.tabline = [[%!v:lua.require("stlparts").build("tabline")]]
end
set_tabline()
