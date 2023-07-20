vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local opt = vim.opt

opt.autowrite = true -- Enable auto write
opt.clipboard = 'unnamedplus' -- Sync with system clipboard
opt.completeopt = 'menu,menuone,noselect'
opt.conceallevel = 3 -- Hide * markup for bold and italic
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = 'jcroqlnt' -- tcqj
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = "rg --with-filename --no-heading --line-number --column --hidden --smart-case --follow"
opt.ignorecase = true -- Ignore case
opt.inccommand = 'nosplit' -- preview incremental substitute
opt.laststatus = 0
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = 'a' -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize' }
opt.shiftround = true -- Round indent
opt.shiftwidth = 4 -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true })
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.tabstop = 4 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.wildmode = 'longest:full,full' -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap
opt.fileencoding = 'utf-8'
opt.path:append('**')
opt.wildignore:append('*/node_modules/*')
opt.wildignore:append('*/.git/*')
opt.wildignore:append('*/.DS_Store')
opt.wildignore:append('*/.env')
opt.wildignore:append('*/.env.local')
opt.wildignore:append('*/.vscode/*')
opt.wildignore:append('*/.idea/*')
opt.wildignore:append('*/.gitignore')


-- stylua: ignore
local borderchars = {
  single  = {
    style = "single",
    vert = "│", vertleft = "┤", vertright = "├", horiz = "─", horizup = "┴", horizdown = "┬", verthoriz = "┼", topleft = "┌", topright = "┐", botleft = "└", botright = "┘"
  },
  double  = {
    style = "double",
    vert = "║", vertleft = "╣", vertright = "╠", horiz = "═", horizup = "╩", horizdown = "╦", verthoriz = "╬", topleft = "╔", topright = "╗", botleft = "╚", botright = "╝"
  },
  rounded = {
    style = "rounded",
    vert = "│", vertleft = "┤", vertright = "├", horiz = "─", horizup = "┴", horizdown = "┬", verthoriz = "┼", topleft = "╭", topright = "╮", botleft = "╰", botright = "╯"
  },
}

-- my custom borderchars
vim.g.bc = borderchars.rounded

-- stylua: ignore
vim.opt.fillchars:append({ horiz = vim.g.bc.horiz, horizup = vim.g.bc.horizup, horizdown = vim.g.bc.horizdown, vert = vim.g.bc.vert, vertright = vim.g.bc.vertright, vertleft = vim.g.bc.vertleft, verthoriz = vim.g.bc.verthoriz })


