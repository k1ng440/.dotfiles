local M = {}
local icons = require("k1ng.configs.icons").kinds


function M.cmp_formatter(min, max, ellipsis_char)
  local ellipsis_len = string.len(ellipsis_char)
  local ellipsis_padding = string.rep(' ', ellipsis_len)
  return function(_, item)
    --@label string|number
    local label = item.abbr

    if string.len(item.abbr) < min then
      local padding = string.rep(' ', min - string.len(item.abbr))
      item.abbr = item.abbr .. padding
      item.abbr = item.abbr .. ' ' .. ellipsis_padding .. '(' .. item.kind .. ')'
    elseif string.len(item.abbr) > max then
      item.abbr = vim.fn.strcharpart(item.abbr, 0, max) .. ellipsis_char .. ' ' .. '(' .. item.kind .. ')'
    end

    if icons[item.kind] then
      item.kind = icons[item.kind]
    end

    return item
  end
end

return M
