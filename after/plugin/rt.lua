local rt = require('rust-tools')

rt.setup({
  tools = {
    autoSetHints = true,
    inlay_hints = {
      show_parameter_hints = true,
      parameter_hints_prefix = "<- ",
      other_hints_prefix = "=> "
    }
  },
  server = {
    on_attach = function(client, bufnr)
      require("shared/lsp")(client, bufnr)
      require("illuminate").on_attach(client)
      require"rust-tools".inlay_hints.set()

      local bufopts = {
        noremap = true,
        silent = true,
        buffer = bufnr
      }
      vim.keymap.set('n', 'K', "<Cmd>RustHoverActions<CR>", bufopts)
      vim.autocmd("<Cmd>lua require'rust-tools'.inlay_hints.set()<CR>")
    end,
    ["rust-analyzer"] = {
      assist = {
        importEnforceGranularity = true,
        importPrefix = "create"
      },
      cargo = {allFeatures = true},
      checkOnSave = {
        -- default: `cargo check`
        command = "clippy",
        allFeatures = true
      }
    },
    inlayHints = {
      -- NOT SURE THIS IS VALID/WORKS 😬
      lifetimeElisionHints = {
        enable = true,
        useParameterNames = true
      }
    }
  }
})
