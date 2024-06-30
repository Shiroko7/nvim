
local lsp_zero = require('lsp-zero')

lsp_zero.preset("recommended")

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
	-- Replace the language servers listed here 
	-- with the ones you want to install
    ensure_installed = {
        'clangd',
        'eslint',
        'golangci_lint_ls',
        'jsonls',
        'luau_lsp',
        'marksman',
        'pylsp',
        'pyright',
        'rust_analyzer',
        'ruff',
        'svelte',
        'tailwindcss',
        'tsserver',
    },
	handlers = {
		function(server_name)
			require('lspconfig')[server_name].setup({})
		end,
	},
})


local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp_zero.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({ select = true }),
	['<C-Space>'] = cmp.mapping.complete(),
})

lsp_zero.set_preferences({
	sign_icons = { }
})


