vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.licenses_copyright_holders_name = 'Asaduzzaman, Pavel <contact@iampavel.dev>'
vim.g.licenses_default_commands = { 'gpl', 'mit' }

local opt = vim.opt

opt.autowrite = true -- Enable auto write
opt.clipboard:append('unnamedplus') -- Sync with system clipboard
opt.completeopt = 'menuone,noselect'
opt.conceallevel = 0
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = 'jcroqlnt' -- tcqj
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --with-filename --no-heading --line-number --column --hidden --smart-case --follow'
opt.ignorecase = true -- Ignore case
opt.inccommand = 'split' -- preview incremental substitute
-- opt.laststatus = 2
opt.list = false -- Show some invisible characters (tabs...
opt.mouse = 'a' -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize' }
opt.shiftround = true -- Round indent
opt.shiftwidth = 4 -- Size of an indent
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescroll = 0 -- sidescroll in jumps because terminals are slow
opt.sidescrolloff = 3 -- Columns of context
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
opt.undodir = os.getenv('HOME') .. '/.local/share/nvim/undodir'
opt.updatetime = 50
opt.wildmode = 'longest:full,full' -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap
opt.fileencoding = 'utf-8'
opt.hidden = true
opt.lazyredraw = true
-- opt.colorcolumn = '80'
opt.title = true
opt.titlestring = [[%f %h%m%r%w %{v:progname}]]
opt.exrc = true -- Enable local .nvimrc

-- spell

opt.foldmethod = 'expr' -- code folding
opt.foldexpr = 'nvim_treesitter#foldexpr()' -- code folding with treesitter
opt.foldenable = false -- can be enabled directly in opened file - using 'zi' - toogle fold

opt.shortmess = opt.shortmess + 'A' -- ignore annoying swapfile messages
opt.shortmess = opt.shortmess + 'I' -- no splash screen
opt.shortmess = opt.shortmess + 'O' -- file-read message overwrites previous
opt.shortmess = opt.shortmess + 'T' -- truncate non-file messages in middle
opt.shortmess = opt.shortmess + 'W' -- don't echo "[w]"/"[written]" when writing
opt.shortmess = opt.shortmess + 'a' -- use abbreviations in messages eg. `[RO]` instead of `[readonly]`
opt.shortmess = opt.shortmess + 'c' -- completion messages
opt.shortmess = opt.shortmess + 'o' -- overwrite file-written messages
opt.shortmess = opt.shortmess + 't' -- truncate file messages at start

opt.path:append('**')
opt.wildignore:append('*/node_modules/*')
opt.wildignore:append('*/.git/*')
opt.wildignore:append('*/vendor/*')
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
    vert = "│",
    vertleft = "┤",
    vertright = "├",
    horiz = "─",
    horizup = "┴",
    horizdown = "┬",
    verthoriz = "┼",
    topleft = "┌",
    topright = "┐",
    botleft = "└",
    botright = "┘"
  },
  double  = {
    style = "double",
    vert = "║",
    vertleft = "╣",
    vertright = "╠",
    horiz = "═",
    horizup = "╩",
    horizdown = "╦",
    verthoriz = "╬",
    topleft = "╔",
    topright = "╗",
    botleft = "╚",
    botright = "╝"
  },
  rounded = {
    style = "rounded",
    vert = "│",
    vertleft = "┤",
    vertright = "├",
    horiz = "─",
    horizup = "┴",
    horizdown = "┬",
    verthoriz = "┼",
    topleft = "╭",
    topright = "╮",
    botleft = "╰",
    botright = "╯"
  },
}

-- my custom borderchars
vim.g.bc = borderchars.rounded

-- stylua: ignore
vim.opt.fillchars:append({
  horiz = vim.g.bc.horiz,
  horizup = vim.g.bc.horizup,
  horizdown = vim.g.bc.horizdown,
  vert = vim.g.bc.vert,
  vertright = vim.g.bc.vertright,
  vertleft = vim.g.bc.vertleft,
  verthoriz = vim.g.bc.verthoriz
})

if vim.env.USER == 'root' then
  vim.opt.shada = ''
else
  -- Defaults:
  --   Neovim: !,'100,<50,s10,h
  --
  -- - ! save/restore global variables (only all-uppercase variables)
  -- - '100 save/restore marks from last 100 files
  -- - <50 save/restore 50 lines from each register
  -- - s10 max item size 10KB
  -- - h do not save/restore 'hlsearch' setting
  --
  -- Our overrides:
  -- - '0 store marks for 0 files
  -- - <0 don't save registers
  -- - f0 don't store file marks
  -- - n: store in ~/.config/nvim/
  --
  -- vim.opt.shada = "'0,<0,f0,n~/.config/nvim/shada"
end
