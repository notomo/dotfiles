local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

wezterm.on("gui-startup", function(cmd)
  local _, _, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

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
end

return config
