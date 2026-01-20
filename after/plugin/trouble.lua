local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
keymap('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<CR>', vim.tbl_extend('force', opts, { desc = 'Diagnostics (Trouble)' }))
keymap('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', vim.tbl_extend('force', opts, { desc = 'Buffer Diagnostics (Trouble)' }))
keymap('n', '<leader>cs', '<cmd>Trouble symbols toggle focus=false<CR>', vim.tbl_extend('force', opts, { desc = 'Symbols (Trouble)' }))
keymap('n', '<leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=right<CR>', vim.tbl_extend('force', opts, { desc = 'LSP Definitions / references / ... (Trouble)' }))
keymap('n', '<leader>xL', '<cmd>Trouble loclist toggle<CR>', vim.tbl_extend('force', opts, { desc = 'Location List (Trouble)' }))
keymap('n', '<leader>xQ', '<cmd>Trouble qflist toggle<CR>', vim.tbl_extend('force', opts, { desc = 'Quickfix List (Trouble)' }))
