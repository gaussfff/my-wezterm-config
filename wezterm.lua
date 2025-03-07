local wezterm = require('wezterm')
local mux = wezterm.mux
local config = wezterm.config_builder()

function is_macos()
  return wezterm.target_triple == 'x86_64-apple-darwin' or wezterm.target_triple == 'aarch64-apple-darwin'
end

config.color_scheme = 'Catppuccin Mocha'

config.font = wezterm.font 'Iosevka Nerd Font'
config.font_size = 16
config.default_cursor_style = 'SteadyBar'
config.audible_bell = 'Disabled'
config.automatically_reload_config = true
config.window_close_confirmation = 'NeverPrompt'

-- full screen
wezterm.on('gui-startup', function(_)
  local _, pane, window = mux.spawn_window({})
  local gui_window = window:gui_window()
  gui_window:perform_action(wezterm.action.ToggleFullScreen, pane)
end)

if is_macos() then
  config.native_macos_fullscreen_mode = true
end

-- plugins 
local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
bar.apply_to_config(config)

return config;
