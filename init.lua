require("shiroko")

-- Python
vim.api.nvim_exec([[
    augroup fmt
        autocmd!
        autocmd BufWritePre *.py lua Black()
    augroup END
]], false)

function Black()
    vim.cmd('silent! !python -m black %:p')
end


-- Golang
vim.api.nvim_exec([[
    autocmd FileType go autocmd BufWritePre <buffer> lua GoFmt()
]], false)

function GoFmt()
    vim.cmd('silent! %!gofmt')
end

-- Typescript/Svelte
--- Configure Neoformat
vim.g.neoformat_enabled_svelte = { 'prettier' }
vim.g.neoformat_enabled_typescript = { 'prettier' }

-- Configure Neoformat for Svelte with prettier-plugin-svelte
vim.g.neoformat_svelte_prettier = {
  exe = 'prettier',
  args = { '--plugin', 'prettier-plugin-svelte', '--stdin-filepath', '%:p' },
  stdin = 1
}

-- Auto-format on save
vim.api.nvim_exec([[
  augroup fmt
    autocmd!
    autocmd BufWritePre *.ts,*.svelte Neoformat
  augroup END
]], false)


-- Auto-format on save for specified file types
vim.api.nvim_exec([[
  augroup Prettier
    autocmd!
    autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.css,*.scss,*.json,*.graphql,*.md,*.vue,*.html,*.svelte,*.svx PrettierAsync
  augroup END
]], false)


vim.opt.clipboard = 'unnamedplus'
