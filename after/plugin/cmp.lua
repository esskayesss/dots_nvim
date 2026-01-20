local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')

require("luasnip/loaders/from_vscode").lazy_load()
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
  window = {
    completion = vim.tbl_extend("force", cmp.config.window.bordered(), {
      winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:CmpCursorLine,Search:None"
    }),
    documentation = vim.tbl_extend("force", cmp.config.window.bordered(), {
      winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:CmpCursorLine,Search:None"
    }),
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
      select = false,
    }),
  },
  -- Installed sources:
  sources = {
    { name = 'buffer', keyword_length = 3 }, -- Buffer (current file) first
    { name = 'nvim_lsp' },                   -- LSP suggestions
    { name = 'nvim_lsp_signature_help' },    -- Function signatures
    { name = 'nvim_lua' },                   -- Neovim Lua API
    { name = 'luasnip' },                    -- Snippets
    { name = 'path' },                       -- File paths
    { name = 'calc' },                       -- Math calculations
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      -- Custom comparator to prioritize 'buffer' source
      function(entry1, entry2)
        local source1 = entry1.source.name
        local source2 = entry2.source.name

        -- Prioritize 'buffer' source over others
        if source1 == 'buffer' and source2 ~= 'buffer' then
          return true -- entry1 (buffer) comes before entry2
        elseif source2 == 'buffer' and source1 ~= 'buffer' then
          return false -- entry2 (buffer) comes before entry1
        end
        return nil -- Let other comparators handle if sources are the same
      end,

      -- Default nvim-cmp comparators
      cmp.config.compare.offset,
      cmp.config.compare.exact, -- Exact matches first
      cmp.config.compare.score, -- Score-based sorting
      cmp.config.compare.kind, -- Kind-based sorting (e.g., text before snippet)
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
    },
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
