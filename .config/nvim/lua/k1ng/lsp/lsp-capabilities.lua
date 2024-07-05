local M = {}

function M.capabilities(server_name)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
  capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
  capabilities.workspace.didChangeConfiguration.dynamicRegistration = true

  return capabilities
end

return M
