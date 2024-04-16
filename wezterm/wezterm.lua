-- vim: set fdm=marker:

local wezterm = require "wezterm"
local act = wezterm.action

local config = wezterm.config_builder()

-- Style. {{{1
config.font = wezterm.font_with_fallback {
  "Berkeley Mono",
  "Fira Code",
  "Noto Color Emoji",
}
config.font_size = 14.0
config.custom_block_glyphs = false
config.color_scheme = "Algmyr"
config.bold_brightens_ansi_colors = false

-- Cursor.
config.cursor_thickness = 1
config.cursor_blink_rate = 500
config.animation_fps = 1
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'

local padding = 0
config.window_padding = {
  left = padding,
  right = padding,
  top = padding,
  bottom = padding,
}

-- UI. {{{1
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
config.max_fps = 144

-- Keybinds. {{{1
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
  { key = 'Enter',  mods = 'ALT', action = act.DisableDefaultAssignment },
}

-- Config. {{{1
config.automatically_reload_config = false

-- }}}1
return config

