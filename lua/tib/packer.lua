print("Loading lua/tib/packer.lua")

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer (can manage itself)
	use 'wbthomason/packer.nvim'

	-- Fuzzy finder
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		-- or                            , branch = '0.1.x',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}

	-- Theme
	use "rebelot/kanagawa.nvim"

	-- Treesitter (improved syntax highlighting)
	use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

	-- Harpoon: Fast switching between 4 common files
	use('theprimeagen/harpoon')

	-- Git
	use('tpope/vim-fugitive')

	-- LSP setup using LSP Zero
	use({ 'VonHeikemen/lsp-zero.nvim', branch = 'v4.x' })
	use({ 'neovim/nvim-lspconfig' })
	use({ 'hrsh7th/nvim-cmp' })
	use({ 'hrsh7th/cmp-nvim-lsp' })

	-- Mason (allows for installing LSPs inside neovim automatically)
	use {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		-- "neovim/nvim-lspconfig", -- (already included in LSP zero setup)
	}
end)
