local colors = require("kanagawa.colors").setup()
local palette = colors.palette

-- Settings for Floatterm
local options = vim.opt
vim.api.nvim_set_hl(0, 'Floaterm', { bg = palette.sumiInk3})

options.floaterm_titleposition = 'center'
options.title = 'terminal: $1/$2'

-- Keymaps 
local keymap_setter = vim.keymap.set
keymap_setter("n", "<F12>", vim.cmd.FloatermToggle)
keymap_setter("t", "<F12>", vim.cmd.FloatermToggle)
