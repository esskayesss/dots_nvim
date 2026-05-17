-- mapleader is set in init.lua (before lazy bootstrap). Don't duplicate here.

local keymap = vim.keymap.set
local function map(mode, lhs, rhs, desc, extra)
  local opts = { silent = true, desc = desc }
  if extra then for k, v in pairs(extra) do opts[k] = v end end
  keymap(mode, lhs, rhs, opts)
end

-- ─────────────────────────────────────────────────────────────────────
-- Editor essentials
-- ─────────────────────────────────────────────────────────────────────
map("n", "<Esc>", "<cmd>nohlsearch<CR>", "Clear search highlight")
map("n", "n", "nzzzv", "Next search (centered)")
map("n", "N", "Nzzzv", "Prev search (centered)")
map("n", "J", "mzJ`z", "Join lines (keep cursor)")
map("n", "<leader>l", "<cmd>set list!<CR>", "Toggle hidden chars")

-- ─────────────────────────────────────────────────────────────────────
-- Visual mode quality of life
-- ─────────────────────────────────────────────────────────────────────
map("v", "<", "<gv", "Indent left (keep selection)")
map("v", ">", ">gv", "Indent right (keep selection)")
map("v", "<C-j>", ":m '>+1<CR>gv=gv", "Move selection down")
map("v", "<C-k>", ":m '<-2<CR>gv=gv", "Move selection up")
map("x", "<leader>p", [["_dP]], "Paste over selection (no yank)")

-- ─────────────────────────────────────────────────────────────────────
-- Clipboard / black-hole
-- ─────────────────────────────────────────────────────────────────────
map({ "n", "v" }, "<leader>y", [["+y]], "Yank to system clipboard")
map("n", "<leader>Y", [["+Y]], "Yank line to system clipboard")
map({ "n", "v" }, "<leader>d", [["_d]], "Delete to black hole")

-- ─────────────────────────────────────────────────────────────────────
-- Window navigation + resize
-- ─────────────────────────────────────────────────────────────────────
map("n", "<C-h>", "<C-w>h", "Focus window left")
map("n", "<C-j>", "<C-w>j", "Focus window down")
map("n", "<C-k>", "<C-w>k", "Focus window up")
map("n", "<C-l>", "<C-w>l", "Focus window right")
map("n", "<C-Up>",    "<cmd>resize +2<CR>",          "Resize: taller")
map("n", "<C-Down>",  "<cmd>resize -2<CR>",          "Resize: shorter")
map("n", "<C-Left>",  "<cmd>vertical resize -2<CR>", "Resize: narrower")
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", "Resize: wider")

-- ─────────────────────────────────────────────────────────────────────
-- Buffer / quickfix / loclist navigation
-- ─────────────────────────────────────────────────────────────────────
map("n", "[b", "<cmd>bprevious<CR>", "Prev buffer")
map("n", "]b", "<cmd>bnext<CR>",     "Next buffer")
map("n", "[q", "<cmd>cprev<CR>",     "Prev quickfix")
map("n", "]q", "<cmd>cnext<CR>",     "Next quickfix")
map("n", "[l", "<cmd>lprev<CR>",     "Prev loclist")
map("n", "]l", "<cmd>lnext<CR>",     "Next loclist")

-- ─────────────────────────────────────────────────────────────────────
-- Tabs
-- ─────────────────────────────────────────────────────────────────────
map("n", "<leader><Tab>n", "<cmd>tabnew<CR>",   "Tab: new")
map("n", "<leader><Tab>x", "<cmd>tabclose<CR>", "Tab: close")
map("n", "<leader><Tab>]", "<cmd>tabnext<CR>",  "Tab: next")
map("n", "<leader><Tab>[", "<cmd>tabprev<CR>",  "Tab: prev")

-- ─────────────────────────────────────────────────────────────────────
-- File tree / explorer
-- ─────────────────────────────────────────────────────────────────────
map("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", "Explorer toggle")

-- ─────────────────────────────────────────────────────────────────────
-- Search / replace
-- ─────────────────────────────────────────────────────────────────────
map("n", "<leader>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  "Substitute word under cursor", { silent = false })

-- ─────────────────────────────────────────────────────────────────────
-- Misc
-- ─────────────────────────────────────────────────────────────────────
map("n", "<leader>cx", "<cmd>!chmod +x %<CR>", "chmod +x current file")

-- Re-source the current buffer (lua/vim files only — guard against accidents)
map("n", "<leader><CR>", function()
  local ft = vim.bo.filetype
  if ft == "lua" or ft == "vim" then
    vim.cmd("source %")
    vim.notify("Sourced " .. vim.fn.expand("%:t"), vim.log.levels.INFO)
  else
    vim.notify("Refusing to source filetype: " .. ft, vim.log.levels.WARN)
  end
end, "Source current file")
