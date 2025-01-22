local cmp = require('cmp')
local lspkind = require('lspkind')
local luasnip = require('luasnip')

luasnip.filetype_extend('javascriptreact', { 'html' })
luasnip.filetype_extend('typescriptreact', { 'html' })
luasnip.filetype_extend('typescript', { 'tsdoc' })
luasnip.filetype_extend('javascript', { 'jsdoc' })
luasnip.filetype_extend('typescript', { 'javascript' })
luasnip.filetype_extend('typescriptreact', { 'javascript', 'typescript' })

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- Installed sources:
  sources = {
    { name = 'path' },          -- file paths
    { name = 'nvim_lsp' },      -- from language server
    { name = 'nvim_lsp_signature_help'},      -- display function signatures with current parameter emphasized
    { name = 'nvim_lua' },      -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer' },        -- source current buffer
    { name = 'luasnip' },       -- nvim-cmp source for vim-vsnip 
    { name = 'calc'},           -- source for math calculation
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      maxwidth = 50,
      ellipsis_char = '...',
      preset = 'codicons',

      require('lspkind').init({
        mode = 'symbol_text',
        preset = 'codicons',

        symbol_map = {
          Text = "󰉿 ",
          Method = "󰆧 ",
          Function = "󰊕 ",
          Constructor = " ",
          Field = "󰜢 ",
          Variable = "󰀫 ",
          Class = "󰠱 ",
          Interface = " ",
          Module = " ",
          Property = "󰜢 ",
          Unit = "󰑭 ",
          Value = "󰎠 ",
          Enum = " ",
          Keyword = "󰌋 ",
          Snippet = " ",
          Color = "󰏘 ",
          File = "󰈙 ",
          Reference = "󰈇 ",
          Folder = "󰉋 ",
          EnumMember = " ",
          Constant = "󰏿 ",
          Struct = "󰙅 ",
          Event = "",
          Operator = "󰆕 ",
          TypeParameter = "",
        },
      }),
    })
  },
})
