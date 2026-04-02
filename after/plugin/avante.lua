local ok, avante = pcall(require, 'avante')

if not ok then
  return
end

avante.setup({
  provider = 'opencode',
  acp_providers = {
    opencode = {
      command = 'opencode',
      args = { 'acp' },
    },
  },
  behaviour = {
    acp_follow_agent_locations = true,
  },
})
