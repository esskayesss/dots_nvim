local ok, snacks = pcall(require, 'snacks')

if not ok then
  return
end

snacks.setup({
  input = { enabled = true },
  picker = { enabled = true },
})
