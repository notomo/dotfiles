local api = vim.api
local fn = vim.fn

local surround = function(s)
  return ("[%s]"):format(s)
end

local path = function()
  return fn.expand("%:p:~")
end

local filetype = function()
  return surround(vim.bo.filetype)
end

local branch = function()
  if fn.exists("*gina#component#repo#branch") == 0 then
    return ""
  end
  local ok, name = pcall(fn["gina#component#repo#branch"])
  if not ok then
    return ""
  end
  if #name == 0 then
    return ""
  end
  return surround(name)
end

local column = function()
  return surround(fn.col("."))
end

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

local cwd = function()
  return fn.getcwd()
end

local stlparts = require("stlparts")

local List = stlparts.component("list")
local Padding = stlparts.component("padding")
local FileType = stlparts.component("file_type")

local set_statusline = function()
  local IfNormalWindow = stlparts.component("if_normal_window")
  local TrancateLeft = stlparts.component("trancate_left")
  local IfActiveWindow = stlparts.component("if_active_window")
  local Separate = stlparts.component("separate")

  local active = Separate(List({ path, branch }), List({ column, filetype, mode }))
  local inactive = path
  stlparts.set(
    "default",
    IfNormalWindow(
      TrancateLeft(Padding(FileType({ ["kivi-file"] = List({ cwd, branch }) }, IfActiveWindow(active, inactive))))
    )
  )

  vim.opt.statusline = [[%!v:lua.require("stlparts").build("default")]]
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
  local Builder = stlparts.component("builder")
  local Highlight = stlparts.component("highlight")
  local DefaultHighlight = stlparts.component("default_highlight")
  local Tab = stlparts.component("tab")

  stlparts.set(
    "tabline",
    DefaultHighlight(
      "TabLineFill",
      Builder(function()
        local tab_ids = api.nvim_list_tabpages()
        local current = api.nvim_get_current_tabpage()
        return List(
          vim.tbl_map(function(tab_id)
            local is_current = tab_id == current
            local hl_group = is_current and "TabLineSel" or "TabLine"
            return Tab(
              tab_id,
              Highlight(
                hl_group,
                Padding(FileType({
                  ["kivi-file"] = function(_, ctx)
                    local tab_number = api.nvim_tabpage_get_number(tab_id)
                    return fn.fnamemodify(fn.getcwd(ctx.window_id, tab_number), ":t") .. "/"
                  end,
                }, function(_, ctx)
                  return tab_label(tab_id, ctx.window_id)
                end))
              )
            )
          end, tab_ids),
          { separator = "" }
        )
      end)
    )
  )

  vim.opt.tabline = [[%!v:lua.require("stlparts").build("tabline")]]
end
set_tabline()
