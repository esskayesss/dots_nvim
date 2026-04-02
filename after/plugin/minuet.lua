local ok, minuet = pcall(require, 'minuet')

if not ok then
  return
end

local openrouter_api_key = vim.env.OPENROUTER_API_KEY or os.getenv('OPENROUTER_API_KEY')

if not openrouter_api_key or openrouter_api_key == '' then
  vim.schedule(function()
    vim.notify('Minuet: OPENROUTER_API_KEY is missing', vim.log.levels.WARN)
  end)
  return
end

minuet.setup({
  provider = 'openai_compatible',
  request_timeout = 4.5,
  throttle = 2200,
  debounce = 900,
  notify = 'warn',
  cmp = {
    enable_auto_complete = false,
  },
  virtualtext = {
    auto_trigger_ft = {},
    keymap = {
      accept = '<M-a>',
      accept_line = '<M-A>',
      accept_n_lines = '<M-z>',
      next = '<M-]>',
      prev = '<M-[>',
      dismiss = '<M-e>',
    },
    show_on_completion_menu = true,
  },
  provider_options = {
    openai_compatible = {
      name = 'OpenRouter',
      end_point = 'https://openrouter.ai/api/v1/chat/completions',
      model = 'qwen/qwen3-coder-flash',
      api_key = function()
        return openrouter_api_key
      end,
      stream = false,
      optional = {
        max_tokens = 64,
        top_p = 0.9,
        provider = {
          sort = 'throughput',
        },
      },
    },
  },
})
