local util = require('k1ng.util')

local prettierd = {
  formatCommand = 'prettierd "${INPUT}"',
  formatStdin = true,
  FormatCanRanage = true,
  env = {
    string.format('PRETTIERD_DEFAULT_CONFIG=%s', util.linterConfigFolder .. '/.prettierrc.json'),
  },
}

local languages = {
  html = {
    prettierd,
  },
  javascript = {
    prettierd,
  },
  typescript = {
    prettierd,
  },
  css = {
    prettierd,
  },
  scss = {
    prettierd,
  },
  sass = {
    prettierd,
  },
  json = {
    require('efmls-configs.formatters.jq'),
  },
  rust = {
    require('efmls-configs.formatters.rustfmt'),
  },
  terraform = {
    require('efmls-configs.formatters.terraform_fmt'),
  },
  go = {
    -- require('efmls-configs.formatters.goimports'),
    require('efmls-configs.formatters.gofmt'),
  },
}

return {
  filetypes = vim.tbl_keys(languages),
  settings = {
    rootMarkers = { '.git/', '.nvimroot' },
    languages = languages,
  },
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
  },
}
