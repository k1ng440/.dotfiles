local M = {}
local icons = require("k1ng.configs.icons").kinds

function M.cmp_formatter(min, max, ellipsis_char)
  return function(_, item)
    --@label string|number
    local label = item.abbr

    if string.len(item.abbr) < min then
      local padding = string.rep(' ', min - string.len(item.abbr))
      item.abbr = item.abbr .. padding
      item.abbr = item.abbr .. ' ' .. '(' .. item.kind .. ')'
    elseif string.len(item.abbr) > max then
      item.abbr = vim.fn.strcharpart(item.abbr, 0, max) .. ellipsis_char
      item.abbr = item.abbr .. ' ' .. '(' .. item.kind .. ')'
    end

    if icons[item.kind] then
      item.kind = icons[item.kind]
    end

    return item
  end
end

return M
