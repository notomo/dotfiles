local M = {}

function M.call(script_name, args)
  local script_path = vim.fn.expand("~/dotfiles/tool/autohotkey/" .. script_name)
  local windows_side_script_path = vim.fn.systemlist({ "wslpath", "-w", script_path })[1]
  local cmd = { "AutoHotkey64.exe", "/ErrorStdOut", windows_side_script_path, unpack(args) }
  require("notomo.job").run(cmd)
end

function M.run_without_focus(targets)
  M.call(
    "run_without_focus.ahk",
    vim.tbl_map(function(target)
      if vim.startswith(target, "http") then
        return target
      end
      return vim.fn.systemlist({ "wslpath", "-w", target })[1]
    end, targets)
  )
end

return M
