local lsp_zero = require('lsp-zero')

lsp_zero.preset("recommended")

lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({buffer = bufnr})
end)

-- Setup mason
require('mason').setup({})

-- Setup mason-lspconfig
require('mason-lspconfig').setup({
    ensure_installed = {
        'clangd',
        'eslint',
        'gopls',
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
            local opts = {}
            if server_name == 'svelte' then
                opts = {
                    settings = {
                        svelte = {
                            plugin = {
                                html = { enable = true },
                                css = { enable = true },
                                javascript = { enable = true },
                                typescript = { enable = true },
                                svelte = { enable = true },
                            }
                        }
                    },
                    filetypes = { 'svelte', 'svex', 'svx' }
                }
            end
            require('lspconfig')[server_name].setup(opts)
        end,
    },
})

-- Setup nvim-cmp
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp_zero.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
})

lsp_zero.set_preferences({
    sign_icons = {}
})

-- Additional file extensions
vim.cmd [[
  augroup svelte
    autocmd!
    autocmd BufRead,BufNewFile *.svx set filetype=svelte.markdown
  augroup END
]]
