local function init(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return {
      desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true 
    }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set('n', '<leader>T', api.tree.change_root_to_parent, opts('Up'))
end


require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

