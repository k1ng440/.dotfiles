local M = {}

function M.capabilities(server_name)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend('force', capabilities, {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },

    -- nvim-cmp
    textDocument = {
      completion = {
        completionItem = {
          documentationFormat = { 'markdown', 'plaintext' },
          commitCharactersSupport = true,
          deprecatedSupport = true,
          insertReplaceSupport = true,
          insertTextModeSupport = {
            valueSet = { 1, 2 },
          },
          labelDetailsSupport = true,
          preselectSupport = true,
          resolveSupport = {
            properties = {
              'documentation',
              'detail',
              'additionalTextEdits',
              'sortText',
              'filterText',
              'insertText',
              'textEdit',
              'insertTextFormat',
              'insertTextMode',
            },
          },
          snippetSupport = true,
          tagSupport = {
            valueSet = { 1 },
          },
        },
        completionList = {
          itemDefaults = { 'commitCharacters', 'editRange', 'insertTextFormat', 'insertTextMode', 'data' },
        },
        contextSupport = true,
        dynamicRegistration = false,
        insertTextMode = 1,
      },
    },
  })

  return capabilities
end

return M
