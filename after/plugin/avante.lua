require('avante').setup({
  provider = "openai",  -- Set as default for all modes (edits, completions, questions/chat)
  mode = "legacy",  -- Use legacy mode for compatibility
  auto_suggestions_provider = "openai",  -- Default for auto-suggestions/completions
  providers = {
    openai = {
      endpoint = "https://api.x.ai/v1/",
      model = "grok-3-mini",
      timeout = 30000,  -- Optional: Adjust as needed for response time
      extra_request_body = {
        temperature = 0.7,  -- Optional: Tune for creativity (0-1 range)
        max_tokens = 4096,  -- Optional: Max output length
      },
    },
  },
})
