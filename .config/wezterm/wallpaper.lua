local wezterm = require('wezterm')

local M = {}
function M.random_wallpaper()
  local wallpapers_glob = wezterm.home_dir .. '/Pictures/wl/wallpapers/*'
  local wallpapers = wezterm.glob(wallpapers_glob)
  if #wallpapers > 0 then
    return wallpapers[math.random(#wallpapers)]
  end
end

function M.hsb_toggle(window, pane)
  local overrides = window:get_config_overrides() or {}
  if not overrides.window_background_image_hsb or not overrides.window_background_image_hsb.brightness or overrides.window_background_image_hsb.brightness == 1.0 then
    overrides.window_background_image_hsb = {}
    overrides.window_background_image_hsb.brightness = 0.05
    overrides.window_background_image_hsb.hue = 0.1
    overrides.window_background_image_hsb.saturation = 0.1
    if not overrides.window_background_image then
      overrides.window_background_image = M.random_wallpaper()
    end
  elseif overrides.window_background_image_hsb.brightness == 0.05 then
    overrides.window_background_image_hsb.brightness = 0.0
    overrides.window_background_image_hsb.hue = 0.0
    overrides.window_background_image_hsb.saturation = 0.0
    overrides.window_background_image = nil
  elseif overrides.window_background_image_hsb.brightness == 0.0 then
    overrides.window_background_image_hsb.brightness = 1.0
    overrides.window_background_image_hsb.hue = 1.0
    overrides.window_background_image_hsb.saturation = 1.0
    if not overrides.window_background_image then
      overrides.window_background_image = M.random_wallpaper()
    end
  end
  window:set_config_overrides(overrides)
end

function M.change_wallpaper(window, pane)
  -- set a new one
  local overrides = window:get_config_overrides() or {}
  overrides.window_background_image = M.random_wallpaper()
  window:set_config_overrides(overrides)
end

return M
