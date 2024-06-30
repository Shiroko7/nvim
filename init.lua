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

