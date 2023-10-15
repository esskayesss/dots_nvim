local options = vim.opt

options.clipboard = "unnamedplus"
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
options.backupdir = "/home/esskayesss/.cache/nvim/backups"
options.undofile = true
options.undodir = "/home/esskayesss/.cache/nvim/undo"
