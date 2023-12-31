require('catppuccin').setup({
  background = {
    light = 'latte',
    dark = 'mocha',
  },
  compile_path = vim.fn.stdpath('cache') .. '/catppuccin',
  flavour = 'mocha',
  transparent_background = true,
  term_colors = true,
  show_end_of_buffer = true,
  dim_inactive = {
    enabled = false,
    shade = 'dark',
    percentage = 0.15,
  },
  styles = {
    conditionals = { 'italic' },
  },
  custom_highlights = function(colors)
    return {
      Comment = { fg = colors.subtext1, style = { 'italic' } }, -- this is a comment
      CmpItemKindSnippet = { fg = C.base, bg = C.mauve },
      CmpItemKindKeyword = { fg = C.base, bg = C.red },
      CmpItemKindText = { fg = C.base, bg = C.teal },
      CmpItemKindMethod = { fg = C.base, bg = C.blue },
      CmpItemKindConstructor = { fg = C.base, bg = C.blue },
      CmpItemKindFunction = { fg = C.base, bg = C.blue },
      CmpItemKindFolder = { fg = C.base, bg = C.blue },
      CmpItemKindModule = { fg = C.base, bg = C.blue },
      CmpItemKindConstant = { fg = C.base, bg = C.peach },
      CmpItemKindField = { fg = C.base, bg = C.green },
      CmpItemKindProperty = { fg = C.base, bg = C.green },
      CmpItemKindEnum = { fg = C.base, bg = C.green },
      CmpItemKindUnit = { fg = C.base, bg = C.green },
      CmpItemKindClass = { fg = C.base, bg = C.yellow },
      CmpItemKindVariable = { fg = C.base, bg = C.flamingo },
      CmpItemKindFile = { fg = C.base, bg = C.blue },
      CmpItemKindInterface = { fg = C.base, bg = C.yellow },
      CmpItemKindColor = { fg = C.base, bg = C.red },
      CmpItemKindReference = { fg = C.base, bg = C.red },
      CmpItemKindEnumMember = { fg = C.base, bg = C.red },
      CmpItemKindStruct = { fg = C.base, bg = C.blue },
      CmpItemKindValue = { fg = C.base, bg = C.peach },
      CmpItemKindEvent = { fg = C.base, bg = C.blue },
      CmpItemKindOperator = { fg = C.base, bg = C.blue },
      CmpItemKindTypeParameter = { fg = C.base, bg = C.blue },
      CmpItemKindCopilot = { fg = C.base, bg = C.teal },
      CmpItemKindCopilotSnippet = { fg = C.base, bg = C.teal },
    }
  end,
  integrations = {
    alpha = true,
    cmp = true,
    gitsigns = true,
    illuminate = true,
    indent_blankline = { enabled = false },
    lsp_trouble = true,
    mason = true,
    mini = true,
    notify = true,
    which_key = true,
    fidget = true,
    dashboard = true,
    harpoon = true,
    native_lsp = {
      enabled = true,
      underlines = {
        errors = { 'undercurl' },
        hints = { 'undercurl' },
        warnings = { 'undercurl' },
        information = { 'undercurl' },
      },
    },
    navic = { enabled = true, custom_bg = 'NONE' },
    neotest = true,
    noice = true,
    semantic_tokens = true,
    telescope = true,
    treesitter = true,
    treesitter_context = true,
  },
})

vim.cmd.colorscheme('catppuccin')

-- Eyeliner
local colors = require('catppuccin.palettes').get_palette('mocha')
---@diagnostic disable: need-check-nil
vim.api.nvim_set_hl(0, 'EyelinerPrimary', { fg = colors.flamingo, bold = true, underline = true })
vim.api.nvim_set_hl(0, 'EyelinerSecondary', { fg = colors.pink, underline = true })
