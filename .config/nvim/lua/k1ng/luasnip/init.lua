local ok, ls = pcall(require, 'luasnip')
if not ok then
  vim.notify('luasnip is not loaded', vim.log.levels.ERROR)
  return
end

ls.snippets = {
  go = require('k1ng.luasnip.go'),
  gitcommit = require('k1ng.luasnip.gitcommit'),
}

require('luasnip.loaders.from_vscode').lazy_load()
