local tools = {
  formatting = {
    prettier_d = {
      formatCommand = "prettierd ${INPUT}",
      formatStdin = true,
    },
    stylua = {
      formatCommand = "stylua --color Never -",
      formatStdin = true,
      rootMarkers = { "stylua.toml", ".stylua.toml" },
    },
    terraform = {
      formatCommand = "terraform fmt -",
      formatStdin = true,
    },
    python = {
      { formatCommand = "black --quiet -", formatStdin = true }
    },
  },
}

return {
  init_options = { documentFormatting = true, codeAction = false },
  filetypes = { "lua", "javascript", "javascriptreact", "typescript", "typescriptreact", "terraform", "hcl" },
  settings = {
    rootMarkers = { ".git/" },
    languages = {
      lua = { tools.formatting.stylua },
      javascript = { tools.formatting.prettier_d },
      typescript = { tools.formatting.prettier_d },
      typescriptreact = { tools.formatting.prettier_d },
      terraform = { tools.formatting.terraform },
      hcl = { tools.formatting.terraform },
    },
  },
}
