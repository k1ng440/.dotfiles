local function augroup(name)
  return vim.api.nvim_create_augroup("nvimtraap_" .. name, { clear = true })
end

--- [[ Highlight yanked text ]]
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup("yank_highlight"),
  pattern = '*',
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Close some filetypes with <q>. ]]
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = { "fugitive" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set(
      "n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true }
    )
  end,
})


-- [[ csv ]]
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  command = "setlocal filetype=csv nowrap textwidth=0",
  group = augroup("csv"),
  pattern = "*.csv",
})


-- [[ spell ]]
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown", "wiki" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

-- [[ WhiteSpace ]]
vim.api.nvim_create_autocmd("BufWritePre", {
  command = [[%s/\s\+$//e]],
  group = augroup("whitespace"),
})

-- [[ Disable colorschme for large files ]]
vim.api.nvim_create_autocmd("BufRead", {
  command = [[if getfsize(expand("%")) > 1000000 | setlocal eventignore+=ColorScheme | endif]],
  group = augroup("disable_colorscheme"),
})
