local M = {}

function M.watch(scheme_name, plugin_name)
  local path = require("optpack").get(plugin_name).directory .. "/lua/" .. scheme_name .. "/init.lua"

  local on_change
  local event = vim.loop.new_fs_event()
  local start = function()
    event:start(
      path,
      {},
      vim.schedule_wrap(function()
        on_change()
      end)
    )
  end

  on_change = function()
    vim.cmd.checktime()

    event:stop()

    vim.api.nvim_clear_autocmds({ event = "ColorScheme", group = "notomo_setting" })
    require("lreload").refresh(scheme_name)
    vim.cmd.colorscheme(scheme_name)
    vim.cmd.redraw({ bang = true })

    start()
  end

  start()
end

return M
