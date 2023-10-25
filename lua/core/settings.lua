local options = vim.opt
local homedir = require("os").getenv("HOME")

-- miscellaneous
options.updatetime = 50
options.clipboard = "unnamed"
options.autochdir = true
options.ic = true
options.title = true
options.termguicolors = true

-- editor options
options.wrap = true
options.expandtab = true
options.breakindent = true
options.lbr = true
options.smartindent = true
options.tabstop = 2
options.shiftwidth = 2
options.softtabstop = 2
options.nu = true
options.rnu = true

-- file backups and undo
options.backup = true
options.backupcopy = "yes"
options.backupdir = homedir .. "/.cache/nvim/backups"
options.undofile = true
options.undodir = homedir .. "/.cache/nvim/undo"

-- searching
options.hlsearch = false
options.incsearch = true

-- scrolling
options.scrolloff = 8
options.signcolumn = "yes"
options.isfname:append("@-@")


