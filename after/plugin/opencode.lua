local ok, opencode = pcall(require, 'opencode')

if not ok then
  return
end

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
