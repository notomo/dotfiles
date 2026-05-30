local M = {}

function M.open(url)
  if not vim.startswith(url, "http") then
    require("notomo.lib.message").warn("invalid url: " .. url)
    return
  end
  require("notomo.lib.message").info("Opening: " .. url)
  vim.ui.open(url, {
    cmd = vim.fn.has("wsl") == 1 and { "wslview" } or nil,
  })
end

local preview_url = nil

function M.preview(cwd)
  local is_first = preview_url == nil
  if not is_first then
    M.open(preview_url)
  end

  local path = vim.fn.expand("%:p")
  local previewable = (vim.bo.filetype == "markdown" or vim.bo.filetype == "html")
    and vim.startswith(path, cwd .. "/")
    and vim.fn.filereadable(path) == 1

  local cmd = { "mo", "--foreground", "--no-open", "--target", cwd }
  if previewable then
    table.insert(cmd, path)
  end
  table.insert(cmd, cwd)

  local handle = require("notomo.lib.job").run(cmd, {
    prefix = "[preview] ",
    cwd = cwd,
    env = {
      XDG_STATE_HOME = vim.fn.tempname(),
    },
    stdout = function(_, data)
      if not data or preview_url then
        return
      end
      local first_url = vim.split(vim.trim(data), "\n", { plain = true })[1]
      preview_url = first_url
      vim.schedule(function()
        M.open(first_url)
      end)
    end,
  }, function()
    if is_first then
      preview_url = nil
    end
  end)

  if is_first then
    vim.api.nvim_create_autocmd("VimLeavePre", {
      once = true,
      callback = function()
        handle:kill("sigterm")
      end,
    })
  end
end

return M
