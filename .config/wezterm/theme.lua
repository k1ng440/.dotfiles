local wezterm = require('wezterm')

local M = {}

M.scheme_for_appearance = function(appearance, theme)
  if string.match(wezterm.target_triple, 'linux') then
    return theme.dark
  end
  if appearance:find('Dark') then
    return theme.dark
  else
    return theme.light
  end
end

M.get_custom_colorschemes = function()
  local mocha = wezterm.color.get_builtin_schemes()['Catppuccin Mocha']
  mocha.background = '#000000'
  mocha.tab_bar.background = '#040404'
  mocha.tab_bar.inactive_tab.bg_color = '#0f0f0f'
  mocha.tab_bar.new_tab.bg_color = '#080808'
  mocha.ansi[6] = '#c6a0f6'

  local latte = wezterm.color.get_builtin_schemes()['Catppuccin Latte']
  latte.ansi[6] = '#8839ef'

  return {
    ['Catppuccin Mocha'] = mocha,
    ['Catppuccin Latte'] = latte,
  }
end

return M
