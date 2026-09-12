-- One gap in the extras, patched in LazyVim's own idiom.
--
-- Formatting is otherwise entirely the language extras' job now (lazyvim.json):
-- prettier for the web filetypes, gofumpt and goimports for Go, stylua for
-- Lua, rustfmt through rustaceanvim. Python is the exception.
--
-- lazyvim.plugins.extras.lang.python expects Python formatting to come from the
-- ruff language server, and never registers a conform formatter for it. But
-- ruff's server does not advertise `documentFormattingProvider` - verified
-- against ruff 0.16.7, with the client attached - so `vim.lsp.buf.format`
-- answers "no matching language servers" and a Python buffer is never
-- formatted at all.
--
-- conform ships a `ruff_format` builtin that shells out to the same ruff binary
-- mason already installed, which avoids the question entirely. Import sorting
-- is ruff's isort rules, which the LSP does expose as a code action, but doing
-- it here keeps both halves in one place and ordered correctly: imports first,
-- then format.
--
-- Worth rechecking when ruff updates: if the server starts advertising
-- formatting, this file can go.

return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_organize_imports", "ruff_format" },
      },
    },
  },
}
