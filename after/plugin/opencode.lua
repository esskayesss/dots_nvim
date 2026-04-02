local ok, opencode = pcall(require, 'opencode')

if not ok then
  return
end

vim.g.opencode_opts = {
  provider = {
    enabled = 'tmux',
    tmux = {},
  },
}

vim.o.autoread = true

vim.keymap.set({ 'n', 'x' }, '<leader>oa', function()
  opencode.ask('@this: ', { submit = true })
end, { desc = 'Ask opencode' })

vim.keymap.set({ 'n', 'x' }, '<leader>os', function()
  opencode.select()
end, { desc = 'Select opencode action' })

vim.keymap.set({ 'n', 't' }, '<leader>ot', function()
  opencode.toggle()
end, { desc = 'Toggle opencode' })

vim.keymap.set('n', '<leader>oc', function()
  opencode.command('session.compact')
end, { desc = 'Compact opencode session' })

vim.keymap.set({ 'n', 'x' }, '<leader>or', function()
  return opencode.operator('@this ')
end, { desc = 'Add range to opencode', expr = true })

vim.keymap.set('n', '<leader>ol', function()
  return opencode.operator('@this ') .. '_'
end, { desc = 'Add line to opencode', expr = true })

vim.keymap.set('n', '<S-C-u>', function()
  opencode.command('session.half.page.up')
end, { desc = 'Scroll opencode up' })

vim.keymap.set('n', '<S-C-d>', function()
  opencode.command('session.half.page.down')
end, { desc = 'Scroll opencode down' })
