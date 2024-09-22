local palette = require("yorumi.colors")

-- Custom Options for Floatterm
vim.api.nvim_set_hl(0, 'Floaterm', { bg = palette.kuroiViolet})
vim.api.nvim_set_hl(0, 'FloatermBorder', { bg = palette.yoru0, fg = palette.tsuki2})

vim.g.floaterm_titleposition = 'center'
vim.g.floaterm_title = 'terminal: $1/$2'


-- Keymaps 
local keymap_setter = vim.keymap.set
keymap_setter("n", "<F12>", vim.cmd.FloatermToggle)
keymap_setter("t", "<F12>", vim.cmd.FloatermToggle)
