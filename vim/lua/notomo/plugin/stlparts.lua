local vim = vim
local api = vim.api
local fn = vim.fn
local stlparts = require("stlparts")
local C = stlparts.component
local join_by = require("misclib.collection.list").join_by

local escape = function(s)
  s = s:gsub("%%", "%%%%")
  return s
end

local alter_path = function()
  local path = api.nvim_buf_get_name(fn.bufnr("#"))
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
      ["thetto-input"] = Base(alter_path),
      _ = Base(path),
    }),
    " ",
  })

  vim.opt.statusline = [[%!v:lua.require("stlparts").build("statusline")]]
end
set_statusline()

local window_count = function(window_ids)
  local floating_window_ids = vim.tbl_filter(function(window_id)
    return api.nvim_win_get_config(window_id).relative ~= ""
  end, window_ids)
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

  local modified_window_ids = vim.tbl_filter(function(window_id)
    local bufnr = api.nvim_win_get_buf(window_id)
    return vim.bo[bufnr].modified
  end, window_ids)

  if #modified_window_ids > 0 then
    return "(+)"
  end
  return ""
end

local tab_label = function(tab_id, bufnr)
  local name = fn.fnamemodify(api.nvim_buf_get_name(bufnr), ":t")
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

local current_tab_label = function(tab_id, window_id)
  local bufnr = api.nvim_win_get_buf(window_id)
  return tab_label(tab_id, bufnr)
end

local alter_tab_label = function(tab_id, window_id)
  local bufnr = vim.api.nvim_win_call(window_id, function()
    return fn.bufnr("#")
  end)
  if bufnr == -1 then
    return current_tab_label(tab_id, window_id)
  end
  return tab_label(tab_id, bufnr)
end

local set_tabline = function()
  local Builder = C.builder
  local Highlight = C.highlight
  local DefaultHighlight = C.default_highlight
  local Tab = C.tab
  local TruncateLeft = C.truncate_left

  stlparts.set(
    "tabline",
    DefaultHighlight(
      "TabLineFill",
      Builder(function()
        local tab_ids = api.nvim_list_tabpages()
        local current = api.nvim_get_current_tabpage()
        local components = vim.tbl_map(function(tab_id)
          local is_current = tab_id == current
          local hl_group = is_current and "TabLineSel" or "TabLine"
          return Tab(
            tab_id,
            Highlight(hl_group, {
              " ",
              TruncateLeft(
                SwitchByFiletype({
                  ["kivi-file"] = function(ctx)
                    local tab_number = api.nvim_tabpage_get_number(tab_id)
                    local name = fn.fnamemodify(fn.getcwd(ctx.window_id, tab_number), ":t") .. "/"
                    return escape(name)
                  end,
                  ["thetto"] = function(ctx)
                    return escape(alter_tab_label(tab_id, ctx.window_id))
                  end,
                  ["thetto-input"] = function(ctx)
                    return escape(alter_tab_label(tab_id, ctx.window_id))
                  end,
                  _ = function(ctx)
                    return escape(current_tab_label(tab_id, ctx.window_id))
                  end,
                }),
                { max_width = 30 }
              ),
              " ",
            })
          )
        end, tab_ids)

        table.insert(components, " ")

        local current_window_id = vim.api.nvim_tabpage_get_win(current)
        local current_bufnr = vim.api.nvim_win_get_buf(current_window_id)
        local exists_modified = vim.iter(vim.api.nvim_list_bufs()):any(function(bufnr)
          return bufnr ~= current_bufnr and vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].modified
        end)
        if exists_modified then
          table.insert(components, Highlight("TablineSel", " + "))
        end

        return components
      end)
    )
  )

  vim.opt.tabline = [[%!v:lua.require("stlparts").build("tabline")]]
end
set_tabline()

local set_winbar = function()
  local Builder = C.builder
  local Highlight = C.highlight
  local DefaultHighlight = C.default_highlight

  local no_scope = Highlight("Comment", "(no scope)")
  local separator = Highlight("Comment", " > ")

  local ignore_types = {
    "Variable",
  }
  stlparts.set("navic", {
    DefaultHighlight("Normal", {
      Highlight("Comment", " > "),
      Builder(function(ctx)
        local bufnr = get_bufnr(ctx)
        local navic = require("nvim-navic")
        if not navic.is_available(bufnr) then
          return ""
        end
        local data = navic.get_data(bufnr)
        if not data or #data == 0 then
          return no_scope
        end
        local names = vim
          .iter(data)
          :filter(function(d)
            return not vim.tbl_contains(ignore_types, d.type)
          end)
          :map(function(d)
            return Highlight("WinbarNavic", d.name)
          end)
          :totable()
        return join_by(names, separator)
      end),
      " ",
    }),
  })
end
set_winbar()
