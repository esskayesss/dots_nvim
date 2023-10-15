local keymap = vim.keymap.set
local opts = {noremap = true, silent = true}
local termopts = {silent = true}


vim.g.mapleader = " "

keymap("n", "<leader>tt",      vim.cmd.NvimTreeToggle)

keymap("n", "<S-Left>", "<C-w>h")
keymap("n", "<S-Right>", "<C-w>l")

-- split resizing
keymap("n", "<C-Up>", ":resize +2<CR>")
keymap("n", "<C-Down>", ":resize -2<CR>")
keymap("n", "<C-Left>", ":vertical resize -2<CR>")
keymap("n", "<C-Right>", ":vertical resize +2<CR>")

-- create and open a file
vim.keymap.set('n', '<leader>co', function()
  local filename = vim.fn.input("create file ► ", vim.fn.getcwd())
  vim.api.nvim_command('edit ' .. filename)
end)

