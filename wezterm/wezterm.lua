-- Pull in the wezterm API
local wezterm = require "wezterm"
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- font
-- font_hinting
-- font_locator
-- font_rasterizer
-- font_rules
-- font_shaper
-- font_size
config.font = wezterm.font_with_fallback {
  "Berkeley Mono",
  "Fira Code",
  "Noto Color Emoji",
}
config.font_size = 14.0

-- color_schemes
-- colors
config.color_scheme = "Algmyr"
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

local padding = 0
config.window_padding = {
  left = padding,
  right = padding,
  top = padding,
  bottom = padding,
}

config.cursor_thickness = 1
config.bold_brightens_ansi_colors = false

config.max_fps = 144

local function act_on_all_windows(action)
  return wezterm.action_callback(
    function(window, pane)
      for _, w in ipairs(wezterm.gui.gui_windows()) do
        w:perform_action(action, w:active_pane())
      end
    end
  )
end

config.keys = {
  -- Global resize.
  { key = ')', mods = 'SHIFT|CTRL', action = act_on_all_windows(act.ResetFontSize) },
  { key = '0', mods = 'SHIFT|CTRL', action = act_on_all_windows(act.ResetFontSize) },
  { key = '+', mods = 'SHIFT|CTRL', action = act_on_all_windows(act.IncreaseFontSize) },
  { key = '-', mods = 'SHIFT|CTRL', action = act_on_all_windows(act.DecreaseFontSize) },
  { key = '=', mods = 'SHIFT|CTRL', action = act_on_all_windows(act.IncreaseFontSize) },
  { key = '_', mods = 'SHIFT|CTRL', action = act_on_all_windows(act.DecreaseFontSize) },
}

config.automatically_reload_config = false

-- and finally, return the configuration to wezterm
return config

