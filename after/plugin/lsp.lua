local lsp_zero = require('lsp-zero')
lsp_zero.skip_setup = {'cmp'}

-- Keep your custom capabilities if you still need them (e.g. for snippets)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Your shared on_attach (keymaps, etc.)
lsp_zero.on_attach(function(_, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)

-- Mason setup (unchanged – you can keep nice icons)
require("mason").setup({
  ui = {
    icons = {
      package_installed = "󱧘 ",
      package_pending = "󱣶 ",
      package_uninstalled = "󱧖 ",
    },
  },
})

-- mason-lspconfig: use lsp_zero's default handler for everything installed by Mason
require('mason-lspconfig').setup({
  handlers = {
    lsp_zero.default_setup,  -- this now uses the new vim.lsp.config API internally

    -- Optional: override lua_ls if you still want nvim_lua_ls defaults
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      vim.lsp.config('lua_ls', lua_opts)
    end,
  },
})
