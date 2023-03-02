local api = vim.api
local fn = vim.fn
local stlparts = require("stlparts")
local C = stlparts.component

local escape = function(s)
  s = s:gsub("%%", "%%%%")
  return s
end

local get_filetype = function(ctx)
  local bufnr = vim.api.nvim_win_get_buf(ctx.window_id)
  return vim.bo[bufnr].filetype
end
local Switch = C.switch
local SwitchByFiletype = function(...)
  return Switch(get_filetype, ...)
end

local set_statusline = function()
  local TrancateLeft = C.trancate_left
  local Separate = C.separate

  local modes = {
    n = "N",
    i = "I",
    R = "R",
    v = "V",
    V = "V",
    [api.nvim_eval('"\\<C-v>"')] = "V",
    c = "C",
    s = "S",
    [api.nvim_eval('"\\<C-s>"')] = "S",
    t = "T",
  }
  local mode = function()
    local mode = fn.mode()
    return modes[mode] or ""
  end
  local surround = function(s)
    return ("[%s]"):format(s)
  end
  local cwd = function()
    return fn.getcwd()
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
    local name = require("notomo.git").current_branch()
    if #name == 0 then
      return ""
    end
    return surround(name)
  end

  stlparts.set("statusline", {
    " ",
    TrancateLeft(SwitchByFiletype({
      ["kivi-file"] = { cwd, " ", branch },
      _ = Separate({
        { path, " ", branch },
        { column, " ", filetype, " ", mode },
      }),
    })),
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

local tab_label = function(tab_id, window_id)
  local bufnr = api.nvim_win_get_buf(window_id)
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

local set_tabline = function()
  local Builder = C.builder
  local Highlight = C.highlight
  local DefaultHighlight = C.default_highlight
  local Tab = C.tab
  local TrancateLeft = C.trancate_left

  stlparts.set(
    "tabline",
    DefaultHighlight(
      "TabLineFill",
      Builder(function()
        local tab_ids = api.nvim_list_tabpages()
        local current = api.nvim_get_current_tabpage()
        return vim.tbl_map(function(tab_id)
          local is_current = tab_id == current
          local hl_group = is_current and "TabLineSel" or "TabLine"
          return Tab(
            tab_id,
            Highlight(hl_group, {
              " ",
              TrancateLeft(
                SwitchByFiletype({
                  ["kivi-file"] = function(ctx)
                    local tab_number = api.nvim_tabpage_get_number(tab_id)
                    local name = fn.fnamemodify(fn.getcwd(ctx.window_id, tab_number), ":t") .. "/"
                    return escape(name)
                  end,
                  _ = function(ctx)
                    return escape(tab_label(tab_id, ctx.window_id))
                  end,
                }),
                { max_width = 30 }
              ),
              " ",
            })
          )
        end, tab_ids)
      end)
    )
  )

  vim.opt.tabline = [[%!v:lua.require("stlparts").build("tabline")]]
end
set_tabline()
