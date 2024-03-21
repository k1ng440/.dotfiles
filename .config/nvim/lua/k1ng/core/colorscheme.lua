local hl = vim.api.nvim_set_hl

-- dap
local icons = require('k1ng.core.icons')
hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })
for name, sign in pairs(icons.dap) do
  sign = type(sign) == 'table' and sign or { sign }
  vim.fn.sign_define('Dap' .. name, { text = sign[1], texthl = sign[2] or 'DiagnosticInfo', linehl = sign[3], numhl = sign[3] })
end

-- fidget
hl(0, 'FidgetTitle', { link = 'NormalFloat' })
hl(0, 'FidgetTask', { link = 'NormalFloat' })

-- mini..hipatterns

-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
hl(0, 'MiniHipatternsFixme', { fg = '#000000', bg = '#DC2626', bold = true })
hl(0, 'MiniHipatternsHack', { fg = '#000000', bg = '#C24AD0', bold = true })
hl(0, 'MiniHipatternsTodo', { fg = '#000000', bg = '#7C3AED', bold = true })
hl(0, 'MiniHipatternsNote', { fg = '#000000', bg = '#10B981', bold = true })
