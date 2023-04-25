local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

local config = {
  color_scheme = "Adventure",

  font_size = 14.0,
  harfbuzz_features = { "calt=0", "clig=0", "liga=0" },

  use_ime = true,

  hide_mouse_cursor_when_typing = false,
  hide_tab_bar_if_only_one_tab = true,
  adjust_window_size_when_changing_font_size = false,
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },

  default_cursor_style = "BlinkingBlock",
  cursor_blink_ease_in = "Constant",
  cursor_blink_ease_out = "Constant",

  launch_menu = {},

  set_environment_variables = {},

  disable_default_key_bindings = true,
  keys = {
    { key = "Tab", mods = "CTRL", action = act.SendKey({ key = "Tab", mods = "CTRL" }) },
    { key = "0", mods = "CTRL", action = act.ResetFontSize },
    { key = ";", mods = "CTRL", action = act.IncreaseFontSize },
    { key = "-", mods = "CTRL", action = act.DecreaseFontSize },
    { key = "r", mods = "ALT", action = act.ReloadConfiguration },
    { key = "n", mods = "ALT", action = act.SpawnTab("CurrentPaneDomain") },
    { key = "t", mods = "ALT", action = act.ShowLauncherArgs({ flags = "FUZZY|LAUNCH_MENU_ITEMS" }) },
    { key = "l", mods = "ALT", action = act.ActivateTabRelative(1) },
    { key = "h", mods = "ALT", action = act.ActivateTabRelative(-1) },
  },

  mouse_bindings = {
    {
      event = { Down = { streak = 1, button = "Right" } },
      mods = "NONE",
      action = act.PasteFrom("Clipboard"),
    },
  },
}

local specified_position = false
local gui_info = wezterm.procinfo.get_info_for_pid(wezterm.procinfo.pid())
local info = wezterm.procinfo.get_info_for_pid(gui_info.ppid) or {}
for _, arg in ipairs(info.argv or {}) do
  if arg == "--position" then
    specified_position = true
    config.initial_rows = 20
    break
  end
end

wezterm.on("gui-startup", function(cmd)
  local _, _, window = mux.spawn_window(cmd or {})
  local gui_window = window:gui_window()
  if specified_position then
    local width = gui_window:get_dimensions().pixel_width
    local height = gui_window:get_dimensions().pixel_height
    local active_screen = wezterm.gui.screens().active
    local x = active_screen.width - width * 1.05
    local y = active_screen.height - height * 1.2
    gui_window:set_position(x, y)
    gui_window:focus()
  else
    gui_window:maximize()
  end
end)

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  -- wezterm ls-fonts --list-system
  config.font = wezterm.font("MeiryoKe_Gothic", { weight = "Regular", stretch = "Normal", style = "Normal" })

  local wsl = { "wsl.exe", "--distribution", "notomo_dev2", "--exec", "/bin/bash", "-l" }
  config.default_prog = wsl

  table.insert(config.launch_menu, {
    label = "WSL",
    args = wsl,
  })
  table.insert(config.launch_menu, {
    label = "Powershell",
    args = { "powershell.exe" },
  })
elseif wezterm.target_triple:match("apple") then
  config.font = wezterm.font("Source Han Code JP", { weight = "Regular", stretch = "Normal", style = "Normal" })
  config.font_size = 17.0
end

return config
