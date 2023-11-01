local wezterm = require('wezterm')
local fonts = require('fonts')
local theme = require('theme')
local gpus = wezterm.gui.enumerate_gpus()
require('bar')

local font = fonts.get_font('CascadiaCode')
-- local font = fonts.get_font('JetBrainsMono')
-- local font = fonts.get_font('FiraCode')

wezterm.on('window-config-reloaded', function(window, pane)
  -- remove any overridden wallpaper
  local overrides = window:get_config_overrides() or {}
  overrides.window_background_image = nil
  window:set_config_overrides(overrides)
end)

local config = {
  -- keys
  disable_default_key_bindings = true,
  leader = { key = 's', mods = 'CTRL', timeout_milliseconds = 5000 },
  keys = require('shortcuts'),

  -- fonts
  font = font.font,
  font_size = font.size,

  -- window
  window_background_opacity = 0.80,
  window_decorations = 'RESIZE',
  window_padding = { left = 4, right = 0, top = 0, bottom = 0 },
  inactive_pane_hsb = { saturation = 1.0, brightness = 0.6 },

  -- theme
  color_schemes = theme.get_custom_colorschemes(),
  color_scheme = theme.scheme_for_appearance(wezterm.gui.get_appearance(), {
    dark = 'Catppuccin Mocha',
    light = 'Catppuccin Latte',
  }),

  -- tab bar
  tab_bar_at_bottom = true,
  tab_max_width = 32,
  use_fancy_tab_bar = false,

  -- cursor
  default_cursor_style = 'BlinkingBar',
  cursor_thickness = '2px',
  animation_fps = 1,
  cursor_blink_ease_in = 'Constant',
  cursor_blink_ease_out = 'Constant',
  cursor_blink_rate = 0,

  -- unix domain sockets
  -- unix_domains = { {
  --   name = 'unix',
  --   connect_automatically = true,
  -- } },

  -- etc.
  window_close_confirmation = 'NeverPrompt',
  adjust_window_size_when_changing_font_size = false,
  use_resize_increments = false,
  audible_bell = 'Disabled',
  clean_exit_codes = { 130 },
  enable_scroll_bar = false,

  -- rendering
  webgpu_preferred_adapter = gpus[1],
  front_end = 'OpenGL',
  max_fps = 100,
}

-- use WebGPU on integrated GPUs
for _, gpu in ipairs(wezterm.gui.enumerate_gpus()) do
  if gpu.backend == 'Vulkan' and gpu.device_type == 'IntegratedGpu' then
    config.webgpu_preferred_adapter = gpu
    config.front_end = 'WebGpu'
    break
  end
end

return config
