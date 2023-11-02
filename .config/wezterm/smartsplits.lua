-- https://github.com/mrjones2014/smart-splits.nvim
local wezterm = require('wezterm')
local M = {}

function M._is_vim(pane)
  -- this is set by the plugin, and unset on ExitPre in Neovim
  return pane:get_user_vars().IS_NVIM == 'true'
end

M._direction_keys = {
  Left = 'h',
  Down = 'j',
  Up = 'k',
  Right = 'l',

  -- reverse lookup
  h = 'Left',
  j = 'Down',
  k = 'Up',
  l = 'Right',
}

function M._split_nav(resize_or_move, key)
  return {
    key = key,
    mods = resize_or_move == 'resize' and 'META' or 'CTRL',
    action = wezterm.action_callback(function(win, pane)
      if M._is_vim(pane) then
        -- pass the keys through to vim/nvim
        win:perform_action({
          SendKey = { key = key, mods = resize_or_move == 'resize' and 'META' or 'CTRL' },
        }, pane)
      else
        if resize_or_move == 'resize' then
          win:perform_action({ AdjustPaneSize = { M._direction_keys[key], 3 } }, pane)
        else
          win:perform_action({ ActivatePaneDirection = M._direction_keys[key] }, pane)
        end
      end
    end),
  }
end

function M.get_keys()
  return {
    -- move between split panes
    M._split_nav('move', 'h'),
    M._split_nav('move', 'j'),
    M._split_nav('move', 'k'),
    M._split_nav('move', 'l'),
    -- resize panes
    M._split_nav('resize', 'h'),
    M._split_nav('resize', 'j'),
    M._split_nav('resize', 'k'),
    M._split_nav('resize', 'l'),
  }
end

return M
