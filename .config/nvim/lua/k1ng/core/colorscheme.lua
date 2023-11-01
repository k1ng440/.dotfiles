local icons = require('k1ng.core.icons')
-- dap
vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })
for name, sign in pairs(icons.dap) do
  sign = type(sign) == 'table' and sign or { sign }
  vim.fn.sign_define('Dap' .. name, { text = sign[1], texthl = sign[2] or 'DiagnosticInfo', linehl = sign[3], numhl = sign[3] })
end

-- cmp-tabnine
vim.api.nvim_set_hl(0, 'CmpItemKindTabNine', { fg = '#77E6EF' })

-- fidget
vim.api.nvim_set_hl(0, 'FidgetTitle', { link = 'NormalFloat' })
vim.api.nvim_set_hl(0, 'FidgetTask', { link = 'NormalFloat' })

