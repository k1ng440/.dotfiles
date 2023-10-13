-- Register linters and formatters per language
local languages = require('efmls-configs.defaults').languages()
languages = vim.tbl_extend('force', languages, {
  html = {
    require('efmls-configs.formatters.prettier'),
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
  markdown = {
    require('efmls-configs.formatters.mdformat'),
  },
  go = {
    require('efmls-configs.formatters.goimports'),
    require('efmls-configs.formatters.gofmt'),
    require('efmls-configs.formatters.golines'),
  },
})

return {
  filetypes = vim.tbl_keys(languages),
  settings = {
    rootMarkers = { '.git/' },
    languages = languages,
  },
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
  },
}
