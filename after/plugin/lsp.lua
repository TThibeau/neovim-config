print("Loading after/plugin/lsp.lua")
local lsp_zero = require('lsp-zero')

-- lsp_attach is where you enable features that only work
-- if there is a language server active in the file
local lsp_attach = function(client, bufnr)
	local opts = { buffer = bufnr }

	vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
	vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
	vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
	vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
	vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
	vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
	vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
	vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
	vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
	vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
end

lsp_zero.extend_lspconfig({
	sign_text = true,
	lsp_attach = lsp_attach,
	capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

-- My language servers:
require('mason').setup({})
require('mason-lspconfig').setup({

	--- First, make sure they are installed in neovim using Mason:
	ensure_installed = { 'clangd', 'lua_ls', 'cmake' },

	--- Second, make sure they are configured correctly using custom handlers in mason-lspconfig:
	handlers = {
		function(server_name)
			require('lspconfig')[server_name].setup({})
		end,

		---- clangd { "c", "cpp", "objc", "objcpp", "cuda", "proto" }
		------ requires compile_commands.json in the root
		------ If compile_commands.json lives in a build directory, should symlink it to the root
		------ ln -s /path/to/myproject/build/compile_commands.json /path/to/myproject/
		clangd = function()
			require('lspconfig').clangd.setup({
				cmd = { 'clangd', '--background-index', '--clang-tidy', '--log=verbose' },
				init_options = {
					fallbackFlags = { '-std=c++17' },
				},
				on_attach = function(client, bufnr)
					print('clangd on_attach called')
				end
			})
		end,

		lua_ls = function()
			require('lspconfig').lua_ls.setup({
				on_attach = function(client, bufnr)
					print('lua_ls on_attach called')
				end
			})
		end,

		cmake = function()
			require('lspconfig').cmake.setup({
				cmd = { 'cmake-language-server' },
				filetypes = { 'cmake' },
				on_attach = function(client, bufnr)
					print('cmake on_attach called')
				end,
				init_options = {
					buildDirectory = "build/"
				},
			})
		end
	}
})

--- Enable format on save
---- don't add this function in the `lsp_attach` callback.
---- `format_on_save` should run only once, before the language servers are active.
lsp_zero.format_on_save({
	format_opts = {
		async = false,
		timeout_ms = 10000,
	},
	servers = {
		['clangd'] = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
		['lua_ls'] = { 'lua' },
		['cmake'] = { 'cmake' },
	}
})

---
-- Autocompletion setup
---
local cmp = require('cmp')

cmp.setup({
	sources = {
		{ name = 'nvim_lsp' },
	},
	snippet = {
		expand = function(args)
			-- You need Neovim v0.10 to use vim.snippet
			vim.snippet.expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<Tab>'] = cmp.mapping.confirm { select = true },
	}),
})
