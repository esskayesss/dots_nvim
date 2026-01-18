local theme = require("yorumi.colors")("abyss")

-- Custom Options for Floatterm
vim.api.nvim_set_hl(0, 'Floaterm', { bg = theme.ui.special})
vim.api.nvim_set_hl(0, 'FloatermBorder', { bg = theme.ui.bg, fg = theme.ui.fg_dim})

vim.g.floaterm_titleposition = 'center'
vim.g.floaterm_title = 'terminal: $1/$2'


-- Keymaps 
local keymap_setter = vim.keymap.set
keymap_setter("n", "<F12>", vim.cmd.FloatermToggle)
keymap_setter("t", "<F12>", vim.cmd.FloatermToggle)
