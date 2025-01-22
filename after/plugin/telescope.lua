local function is_git_repo()
  local handle = io.popen("git rev-parse --is-inside-work-tree 2> /dev/null")
  if not handle then
    print("couldn't execute git rev-parse")
    return false
  end
  local result = handle:read("*a")
  handle:close()

  return result:match("true") ~= nil
end


local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>fg', function()
  if is_git_repo() then
    print("this is a git repository");
    builtin.git_files();
  else
    print("this isnt a git repository");
  end
end)
vim.keymap.set('n', '<leader>gf', function()
  builtin.grep_string({search = vim.fn.input("grep ▷") });
end)


require("telescope").load_extension "file_browser"
vim.keymap.set('n', '<leader>tf', ':Telescope file_browser<CR>')

require("telescope").load_extension "todo-comments"

local fb_actions = require("telescope._extensions.file_browser.actions")
vim.keymap.set('n', '<leader>co', function()
  local filename = vim.fn.input("create file ► ", vim.fn.getcwd())
  vim.api.nvim_command('edit ' .. filename)
end)
