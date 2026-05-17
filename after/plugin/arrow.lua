require('arrow').setup({
  show_icons = true,
  leader_key = ';', -- Recommended to be a single key
  buffer_leader_key = 'm', -- Per Buffer Mappings
  save_key = "git_root",
  always_show_path = true,
})

vim.keymap.set("n", "[a", require("arrow.persist").previous, { desc = "Arrow: prev bookmark" })
vim.keymap.set("n", "]a", require("arrow.persist").next,     { desc = "Arrow: next bookmark" })
vim.keymap.set("n", "<leader>aa", require("arrow.persist").toggle, { desc = "Arrow: toggle bookmark" })
