-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- leader must be set before lazy.setup
vim.g.mapleader = vim.g.mapleader or " "
vim.g.maplocalleader = vim.g.maplocalleader or "\\"

require("lazy").setup({
  spec = {
    -- Core libs
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "stevearc/dressing.nvim",
    "nvim-tree/nvim-web-devicons",

    -- Markdown / images / AI
    "MeanderingProgrammer/render-markdown.nvim",
    "HakonHarnes/img-clip.nvim",
    {
      "nickjvandyke/opencode.nvim",
      dependencies = { "folke/snacks.nvim" },
    },
    "milanglacier/minuet-ai.nvim",

    -- LSP / completion
    {
      "VonHeikemen/lsp-zero.nvim",
      branch = "v3.x",
      dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
      },
    },
    "neovim/nvim-lspconfig",
    "nvimtools/none-ls.nvim",
    "lvimuser/lsp-inlayhints.nvim",
    "RRethy/vim-illuminate",

    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "onsails/lspkind.nvim",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",

    -- Treesitter
    -- NOTE: master branch is archived and incompatible with Neovim 0.12's
    -- query API change (captures return TSNode[] not TSNode). We re-register
    -- the crashing predicates/directives with force=true and a list-unwrap
    -- guard. Runtime override avoids dirtying the plugin worktree (which
    -- would block `:Lazy sync`).
    {
      "nvim-treesitter/nvim-treesitter",
      branch = "master",
      build = ":TSUpdate",
      config = function()
        -- Force the upstream module to load so its directives/predicates
        -- are registered first; then override them.
        pcall(require, "nvim-treesitter.query_predicates")

        local q = vim.treesitter.query
        local force_opts = { force = true, all = true }

        local function unwrap(n)
          if type(n) == "table" then return n[#n] end
          return n
        end

        -- Mirror upstream tables (kept in sync with nvim-treesitter master).
        local html_script_type_languages = {
          ["importmap"] = "json",
          ["module"] = "javascript",
          ["application/ecmascript"] = "javascript",
          ["text/ecmascript"] = "javascript",
        }
        local non_ft_aliases = {
          ex = "elixir", pl = "perl", sh = "bash", uxn = "uxntal", ts = "typescript",
        }
        local function lang_from_info_string(alias)
          local m = vim.filetype.match({ filename = "a." .. alias })
          return m or non_ft_aliases[alias] or alias
        end

        ---------------- directives ----------------
        q.add_directive("set-lang-from-mimetype!", function(match, _, bufnr, pred, metadata)
          local node = unwrap(match[pred[2]])
          if not node then return end
          local v = vim.treesitter.get_node_text(node, bufnr)
          local cfg = html_script_type_languages[v]
          if cfg then
            metadata["injection.language"] = cfg
          else
            local _, _, sub = string.find(v, "/(.+)")
            metadata["injection.language"] = sub or v
          end
        end, force_opts)

        q.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
          local node = unwrap(match[pred[2]])
          if not node then return end
          local alias = vim.treesitter.get_node_text(node, bufnr):lower()
          metadata["injection.language"] = lang_from_info_string(alias)
        end, force_opts)

        ---------------- predicates ----------------
        q.add_predicate("nth?", function(match, _pattern, _bufnr, pred)
          local node = unwrap(match[pred[2]])
          local n = tonumber(pred[3])
          if node and node:parent() and node:parent():named_child_count() > n then
            return node:parent():named_child(n) == node
          end
          return false
        end, force_opts)

        q.add_predicate("is?", function(match, _pattern, bufnr, pred)
          local locals = require("nvim-treesitter.locals")
          local node = unwrap(match[pred[2]])
          local types = { unpack(pred, 3) }
          if not node then return true end
          local _, _, kind = locals.find_definition(node, bufnr)
          return vim.tbl_contains(types, kind)
        end, force_opts)

        q.add_predicate("kind-eq?", function(match, _pattern, _bufnr, pred)
          local node = unwrap(match[pred[2]])
          local types = { unpack(pred, 3) }
          if not node then return true end
          return vim.tbl_contains(types, node:type())
        end, force_opts)

        -- Actual nvim-treesitter setup lives in after/plugin/treesitter.lua
      end,
    },
    "windwp/nvim-ts-autotag",
    "maxmellon/vim-jsx-pretty",
    "yuezk/vim-js",
    "HerringtonDarkholme/yats.vim",

    -- File explorer / pickers
    {
      "nvim-tree/nvim-tree.lua",
      dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
      "nvim-telescope/telescope-file-browser.nvim",
      dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    },
    "junegunn/fzf",
    "junegunn/fzf.vim",
    "otavioschwanck/arrow.nvim",
    "mbbill/undotree",
    "airblade/vim-rooter",

    -- UI
    "nvim-lualine/lualine.nvim",
    {
      "glepnir/galaxyline.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    "petertriho/nvim-scrollbar",
    "catgoose/nvim-colorizer.lua",
    "lukas-reineke/indent-blankline.nvim",

    -- Editing
    {
      "windwp/nvim-autopairs",
      config = function() require("nvim-autopairs").setup({}) end,
    },
    "machakann/vim-sandwich",
    "tpope/vim-commentary",

    -- Git
    "lewis6991/gitsigns.nvim",
    {
      "kdheepak/lazygit.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
    "tpope/vim-fugitive",

    -- TODO / Trouble
    {
      "folke/todo-comments.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function() require("todo-comments").setup({}) end,
    },
    {
      "folke/trouble.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      cmd = "Trouble",
      config = function() require("trouble").setup() end,
    },

    -- Debug / outline / terminal
    "mfussenegger/nvim-dap",
    "puremourning/vimspector",
    "hedyhli/outline.nvim",
    "voldikss/vim-floaterm",

    -- Lang tools
    "saecki/crates.nvim",
    "MunifTanjim/prettier.nvim",

    -- Remote
    {
      "amitds1997/remote-nvim.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-telescope/telescope.nvim",
      },
    },

    -- Fun
    {
      "nvzone/typr",
      dependencies = { "nvzone/volt" },
      cmd = { "Typr", "TyprStats" },
    },

    -- Colorscheme
    {
      "yorumicolors/yorumi.nvim",
      branch = "dev",
      priority = 1000,
      lazy = false,
    },
  },
  install = { colorscheme = { "yorumi", "habamax" } },
  checker = { enabled = false },
  change_detection = { notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin",
        "netrwPlugin",
      },
    },
  },
})
