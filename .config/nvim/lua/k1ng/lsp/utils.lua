local M = {}
local icons = require('k1ng.core.icons').kinds
local lsputil = require 'lspconfig.util'

function M.get_root_dir(pattern, ...)
  local cwd = vim.fn.getcwd()
  local root_files = { ... }
  local root = require('lspconfig.util').root_pattern(unpack(root_files))(pattern)
  local descendant = lsputil.path.is_descendant(cwd, root) and cwd or root
  return descendant or cwd
end

local blackOrWhiteFg = function(r, g, b)
  return ((r * 0.299 + g * 0.587 + b * 0.114) > 186) and '#000000' or '#ffffff'
end

function M.cmp_formatter(min, max, ellipsis_char)
  local ellipsis_len = string.len(ellipsis_char)
  local ellipsis_padding = string.rep(' ', ellipsis_len)
  return function(entry, item)
    -- tailwindcss
    if item.kind == 'Color' and entry.completion_item.documentation then
      local _, _, r, g, b = string.find(entry.completion_item.documentation, '^rgb%((%d+), (%d+), (%d+)')
      if r then
        local color = string.format('%02x', r) .. string.format('%02x', g) .. string.format('%02x', b)
        local group = 'Tw_' .. color
        if vim.fn.hlID(group) < 1 then
          vim.api.nvim_set_hl(0, group, { fg = blackOrWhiteFg(r, g, b), bg = '#' .. color })
        end
        item.kind = '  ' .. icons[item.kind] .. ' '
        item.kind_hl_group = group
        return item
      end
    end

    if string.len(item.abbr) < min then
      local padding = string.rep(' ', min - string.len(item.abbr))
      item.abbr = item.abbr .. padding
      item.abbr = item.abbr .. ' ' .. ellipsis_padding .. '(' .. item.kind .. ')'
    elseif string.len(item.abbr) > max then
      item.abbr = vim.fn.strcharpart(item.abbr, 0, max) .. ellipsis_char .. ' ' .. '(' .. item.kind .. ')'
    end

    if icons[item.kind] then
      item.kind = ' ' .. icons[item.kind]
    end

    return item
  end
end

function M.get_mason_install_path(package)
  local ok, mason_registry = pcall(require, "mason-registry")
  if not ok then
    return ""
  end

  return mason_registry.get_package(package):get_install_path()
end

return M
