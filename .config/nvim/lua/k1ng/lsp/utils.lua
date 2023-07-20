local M = {}

function M.cmp_formatter(min, max, ellipsis_char)
  return function(_, item)
    --@label string|number
    local label = item.abbr
    local truncated_label = vim.fn.strcharpart(label, 0, max)
    if truncated_label ~= label then
      item.abbr = truncated_label .. ellipsis_char
    elseif string.len(label) < min then
      local padding = string.rep(' ', min - string.len(label))
      item.abbr = label .. padding
    end

    -- icons
    local icons = require("k1ng.configs.icons").kinds
    if icons[item.kind] then
      item.kind = icons[item.kind] .. item.kind
    end
    return item
  end
end

return M
