local M = {} 
---@param method string
function M.has(buffer, method)
  method = method:find("/") and method or "textDocument/" .. method
  local clients = vim.lsp.get_active_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    if client.supports_method(method) then
      return true
    end
  end
  return false
end

function M.diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

function M.diagnostic_toggle_virtual_text()
  local diagnostics = vim.lsp.diagnostic
  local buffer = vim.api.nvim_get_current_buf()
  local enabled = diagnostics.get_config({ bufnr = buffer }).virtual_text
  diagnostics.set_virtual_text_enabled(not enabled)
end

function M.diagnostic_toggle_underline()
  local diagnostics = vim.lsp.diagnostic
  local buffer = vim.api.nvim_get_current_buf()
  local enabled = diagnostics.get_config({ bufnr = buffer }).underline
  diagnostics.set_underline_enabled(not enabled)
end

function M.diagnostic_toggle_signs()
  local diagnostics = vim.lsp.diagnostic
  local buffer = vim.api.nvim_get_current_buf()
  local enabled = diagnostics.get_config({ bufnr = buffer }).signs
  diagnostics.set_signs_enabled(not enabled)
end

return M
