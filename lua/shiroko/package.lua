-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use "nvim-lua/plenary.nvim"
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.6',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use ({
	'joshdick/onedark.vim',
	as = 'onedark',
	config = function()
		vim.cmd('colorscheme onedark')
	end
  })

  use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use 'nvim-treesitter/nvim-treesitter-context'

  use {
	  'theprimeagen/harpoon', branch = 'harpoon2',
	  requires = { { 'nvim-lua/plenary.nvim'} }
  }
  use ('mbbill/undotree')
  use ('tpope/vim-fugitive')
  use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v3.x',
      requires = {
          {'williamboman/mason.nvim'},
          {'williamboman/mason-lspconfig.nvim'},

          {'neovim/nvim-lspconfig'},
          {'hrsh7th/nvim-cmp'},
          {'hrsh7th/cmp-nvim-lsp'},
          {'L3MON4D3/LuaSnip'},
      }
  }

  use "github/copilot.vim"
  use "numToStr/Comment.nvim"

  use {'preservim/nerdtree'}

  use 'sbdchd/neoformat'
  use {
    'prettier/vim-prettier',
    run = 'yarn install --frozen-lockfile --production',
    ft = { 'javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'html', 'svelte' }
  }


end) 
