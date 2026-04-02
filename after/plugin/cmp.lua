local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')
local lsp_types = require('cmp.types').lsp

require("luasnip/loaders/from_vscode").lazy_load()
luasnip.filetype_extend('javascriptreact', { 'html' })
luasnip.filetype_extend('typescriptreact', { 'html' })
luasnip.filetype_extend('typescript', { 'tsdoc' })
luasnip.filetype_extend('javascript', { 'jsdoc' })
luasnip.filetype_extend('typescript', { 'javascript' })
luasnip.filetype_extend('typescriptreact', { 'javascript', 'typescript' })

local mapping = {
  ['<C-p>'] = cmp.mapping.select_prev_item(),
  ['<C-n>'] = cmp.mapping.select_next_item(),
  ['<S-Tab>'] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    else
      fallback()
    end
  end, { 'i', 's' }),
  ['<Tab>'] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    else
      fallback()
    end
  end, { 'i', 's' }),
  ['<M-l>'] = cmp.mapping.confirm({
    behavior = cmp.ConfirmBehavior.Insert,
    select = false,
  }),
  ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<C-e>'] = cmp.mapping.close(),
  ['<CR>'] = cmp.mapping(function(fallback)
    fallback()
  end, { 'i', 's' }),
}

cmp.setup({
  performance = {
    fetching_timeout = 4000,
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  preselect = cmp.PreselectMode.None,
  completion = {
    completeopt = 'menu,menuone,noselect',
  },
  window = {
    completion = vim.tbl_extend("force", cmp.config.window.bordered(), {
      winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:CmpCursorLine,Search:None"
    }),
    documentation = vim.tbl_extend("force", cmp.config.window.bordered(), {
      winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:CmpCursorLine,Search:None"
    }),
  },
  mapping = mapping,
  -- Installed sources:
  sources = {
    { name = 'nvim_lsp' },                   -- LSP suggestions first
    { name = 'buffer', keyword_length = 3 }, -- Buffer (current file)
    { name = 'nvim_lsp_signature_help' },    -- Function signatures
    { name = 'nvim_lua' },                   -- Neovim Lua API
    { name = 'luasnip' },                    -- Snippets
    { name = 'path' },                       -- File paths
    { name = 'calc' },                       -- Math calculations
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      -- Default nvim-cmp comparators
      cmp.config.compare.offset,
      cmp.config.compare.exact, -- Exact matches first
      function(entry1, entry2)
        local kind1 = entry1:get_kind()
        local kind2 = entry2:get_kind()

        if kind1 == lsp_types.CompletionItemKind.Field and kind2 ~= lsp_types.CompletionItemKind.Field then
          return true
        elseif kind2 == lsp_types.CompletionItemKind.Field and kind1 ~= lsp_types.CompletionItemKind.Field then
          return false
        end

        if kind1 == lsp_types.CompletionItemKind.Text and kind2 ~= lsp_types.CompletionItemKind.Text then
          return false
        elseif kind2 == lsp_types.CompletionItemKind.Text and kind1 ~= lsp_types.CompletionItemKind.Text then
          return true
        end

        return nil
      end,
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
