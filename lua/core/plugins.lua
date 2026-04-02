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
  use 'wbthomason/packer.nvim'

  use 'nvim-lua/plenary.nvim'
  use 'MunifTanjim/nui.nvim'
  use 'stevearc/dressing.nvim'

  use 'MeanderingProgrammer/render-markdown.nvim'
  use 'HakonHarnes/img-clip.nvim'
  use {
    'nickjvandyke/opencode.nvim',
    requires = {
      'folke/snacks.nvim',
    },
  }
  use 'milanglacier/minuet-ai.nvim'

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    requires = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      { 'neovim/nvim-lspconfig' },
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'L3MON4D3/LuaSnip' },
    },
  }

  use 'neovim/nvim-lspconfig'
  use 'nvimtools/none-ls.nvim'
  use 'lvimuser/lsp-inlayhints.nvim'
  use 'RRethy/vim-illuminate'

  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'onsails/lspkind.nvim'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
  use 'windwp/nvim-ts-autotag'
  use 'maxmellon/vim-jsx-pretty'
  use 'yuezk/vim-js'
  use 'HerringtonDarkholme/yats.vim'

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons'
    }
  }
  use {
    'nvim-telescope/telescope-file-browser.nvim',
    requires = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' }
  }
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use { 'otavioschwanck/arrow.nvim' }
  use 'mbbill/undotree'
  use 'airblade/vim-rooter'

  use 'nvim-lualine/lualine.nvim'
  use {
    'glepnir/galaxyline.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' }
  }
  use 'petertriho/nvim-scrollbar'
  use 'catgoose/nvim-colorizer.lua'
  use 'lukas-reineke/indent-blankline.nvim'

  use {
    'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup {} end
  }
  use 'machakann/vim-sandwich'
  use 'tpope/vim-commentary'

  use 'lewis6991/gitsigns.nvim'
  use {
    'kdheepak/lazygit.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
    },
  }
  use {
    'folke/todo-comments.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('todo-comments').setup({})
    end,
  }
  use {
    'folke/trouble.nvim',
    requires = {
      'nvim-tree/nvim-web-devicons'
    },
    cmd = 'Trouble',
    config = function()
      require('trouble').setup()
    end
  }

  use 'mfussenegger/nvim-dap'
  use 'puremourning/vimspector'
  use 'hedyhli/outline.nvim'
  use 'voldikss/vim-floaterm'

  use 'saecki/crates.nvim'
  use 'MunifTanjim/prettier.nvim'

  use {
    'amitds1997/remote-nvim.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-telescope/telescope.nvim',
    },
  }

  use {
    'nvzone/typr',
    requires = { 'nvzone/volt' },
    cmd = { 'Typr', 'TyprStats' },
  }

  use { 'yorumicolors/yorumi.nvim', branch = 'dev' }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
