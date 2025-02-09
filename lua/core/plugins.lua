local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  -- TODO arrange and group these plugins
  use({
    'amitds1997/remote-nvim.nvim',
    requires = {
      "nvim-lua/plenary.nvim", -- For standard functions
      "MunifTanjim/nui.nvim", -- To build the plugin UI
      "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
    },
  })
  use 'airblade/vim-rooter'
  use 'norcalli/nvim-colorizer.lua'
  use 'voldikss/vim-floaterm'
  use 'puremourning/vimspector'
  use 'saecki/crates.nvim'
  use 'lvimuser/lsp-inlayhints.nvim'
  use 'junegunn/fzf.vim'
  use 'yuezk/vim-js'
  use 'maxmellon/vim-jsx-pretty'

  -- Completion framework:
  use 'hrsh7th/nvim-cmp'

  -- LSP completion source:
  use 'hrsh7th/cmp-nvim-lsp'

  -- Useful completion sources:
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  use 'wbthomason/packer.nvim'
  use 'RRethy/vim-illuminate'
  use 'mfussenegger/nvim-dap'
  use "hedyhli/outline.nvim"
  use 'lukas-reineke/indent-blankline.nvim'
  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }
  use "machakann/vim-sandwich"
  use 'onsails/lspkind.nvim'

  use({
    "kdheepak/lazygit.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
  })

  use ({
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { }
  })

  use {
    'folke/trouble.nvim',
    require = {
      'nvim-tree/nvim-web-devicons'
    },
    cmd = 'Trouble'
  }

  use 'nvim-lualine/lualine.nvim'
  use 'maxmellon/vim-jsx-pretty'
  use 'yuezk/vim-js'
  use 'HerringtonDarkholme/yats.vim'

  use {
    "nvim-telescope/telescope-file-browser.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim'}
  }

  use (
    'nvim-treesitter/nvim-treesitter',
    { run = ':TSUpdate'}
  )

  use 'neovim/nvim-lspconfig'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'MunifTanjim/prettier.nvim'
  use { 'yorumicolors/yorumi.nvim', branch = 'dev' }
  use { 'otavioschwanck/arrow.nvim'}
  use 'mbbill/undotree'
  use 'tpope/vim-commentary'

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    requires = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- LSP Support
      {'neovim/nvim-lspconfig'},
      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'L3MON4D3/LuaSnip'},
    }
  }

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons'
    }
  }

  use {
    'glepnir/galaxyline.nvim',
    requires = { 'kyazdani42/nvim-web-devicons'}
  }

  use 'lewis6991/gitsigns.nvim'
  use 'petertriho/nvim-scrollbar'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
