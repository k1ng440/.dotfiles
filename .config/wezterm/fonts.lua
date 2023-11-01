local wezterm = require('wezterm')

local M = {}

-- calt = contextual alternates
-- ss02 = stylistic set 2

-- italic
function M.get_font(name)
  local fonts = {
    CascadiaCode = {
      font = {
        family = 'Cascadia Code',
        weight = 'Medium',
        harfbuzz_features = { 'calt=1', 'ss01=0' },
      },
      size = 16,
    },

    JetBrainsMono = {
      font = {
        family = 'JetBrains Mono',
        weight = 'Medium',
      },
      size = 16,
    },

    victor = {
      font = {
        family = 'Victor Mono',
        weight = 'DemiBold',
        harfbuzz_features = { 'calt=1', 'ss02=1' },
      },
      size = 17,
    },

    FiraCode = {
      font = {
        family = 'Fira Code',
        weight = 'Medium',
        harfbuzz_features = { 'calt=1', 'ss01=1' },
      },
      size = 16,
    },
  }

  return {
    font = wezterm.font(fonts[name].font),
    size = fonts[name].size,
  }
end

return M
