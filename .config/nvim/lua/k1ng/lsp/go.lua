local M = {
  configured = false,
}

function M.setup()
  local status, gonvim = pcall(require, 'go')
  if not status then
    vim.notify('go.nvim is not enabled', vim.log.levels.WARN)
    return false
  end

  gonvim.setup({
    lsp_cfg = false, -- do not configure lsp
  })

  M.configured = true
  return true
end

return M
