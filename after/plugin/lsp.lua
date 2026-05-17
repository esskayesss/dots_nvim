local lsp_zero = require('lsp-zero')
local lspconfig = vim.lsp.config
lsp_zero.skip_setup = {'cmp'}

-- Keep your custom capabilities if you still need them (e.g. for snippets)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Your shared on_attach (keymaps, etc.)
lsp_zero.on_attach(function(_, bufnr)
  local opts = { buffer = bufnr, remap = false, silent = true }
  local function m(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
  end

  -- Navigation
  m("n", "gd", vim.lsp.buf.definition,       "LSP: definition")
  m("n", "gD", vim.lsp.buf.declaration,      "LSP: declaration")
  m("n", "gi", vim.lsp.buf.implementation,   "LSP: implementation")
  m("n", "gr", vim.lsp.buf.references,       "LSP: references")
  m("n", "gy", vim.lsp.buf.type_definition,  "LSP: type definition")

  -- Info
  m("n", "K",         vim.lsp.buf.hover,           "LSP: hover")
  m("i", "<C-h>",     vim.lsp.buf.signature_help,  "LSP: signature help")
  m("n", "<leader>ws", vim.lsp.buf.workspace_symbol, "LSP: workspace symbols")

  -- Code
  m("n", "<leader>ca", vim.lsp.buf.code_action, "LSP: code action")
  m("n", "<leader>rn", vim.lsp.buf.rename,      "LSP: rename")
  m("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, "LSP: format buffer")

  -- Diagnostics  ([ = prev, ] = next  — vim convention)
  m("n", "<leader>cd", vim.diagnostic.open_float, "Diagnostic: line float")
  m("n", "[d",        vim.diagnostic.goto_prev,  "Diagnostic: prev")
  m("n", "]d",        vim.diagnostic.goto_next,  "Diagnostic: next")
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
  }
})


lspconfig('emmet_ls', {
    -- on_attach = on_attach,  -- Uncomment if you have a custom on_attach defined
    capabilities = capabilities,
    filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte", "pug", "typescriptreact", "vue" },
    init_options = {
      html = {
        options = {
          -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
          ["bem.enabled"] = true,
        },
      },
    }
})

lspconfig('htmx', {
    filetypes = { "html", "htm" }, -- Only apply to HTML files
})

lspconfig('gdscript', capabilities)

lsp_zero.set_sign_icons({
  error = " ",
  warn = " ",
  hint = " ",
  info = " "
})
