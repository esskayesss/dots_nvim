local keymap = vim.keymap.set
vim.g.mapleader = " "

-- lsp
keymap("n", "<leader>f", function()
  vim.lsp.buf.format()
end)

-- treesitter
keymap("n", "<leader>tt",      vim.cmd.NvimTreeToggle)

-- vertical split navigation
keymap("n", "<S-Left>", "<C-w>h")
keymap("n", "<S-Right>", "<C-w>l")
keymap("n", "<S-Down>", "<C-w>j")
keymap("n", "<S-Up>", "<C-w>k")

-- tabs navigation
keymap("n", "<leader>tn", ":tabnext<CR>")
keymap("n", "<leader>tp", ":tabprev<CR>")
keymap("n", "<leader>tx", ":tabclose<CR>")
keymap("n", "<leader>nt", ":tabnew<CR>")

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

-- line movement
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '>-2<CR>gv=gv")

-- sourcing current buffer
keymap("n", "<leader><leader>", function()
  vim.cmd("so")
end)

-- center search
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- paste retain
keymap("x", "<leader>p", "\"_dP")

-- delete to void 
keymap("n", "<leader>d", "\"_d")
keymap("v", "<leader>d", "\"_d")

-- copy to system clipboard
keymap({"n", "v"}, "<leader>y", [["+y]])
keymap("n", "<leader>Y", [["+Y]])

keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
