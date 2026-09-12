-- Autocommands carried over from the old config.
--
-- The formatting autocmds that used to live in init.lua are gone: formatting is
-- now handled by the LazyVim language extras listed in lazyvim.json. That was
-- not a cosmetic change. The old init.lua declared `augroup fmt` twice, each
-- with its own `autocmd!`, so the second declaration wiped the first and the
-- Python Black hook never fired. Separately, *.ts matched both the `fmt` and
-- the `Prettier` group, so TypeScript was formatted twice on every write.
--
-- The yank highlight that used to be here is not repeated: LazyVim installs an
-- identical TextYankPost autocmd already.

-- Treat mdsvex files as Svelte-flavoured markdown.
--
-- Two things depend on this and are easy to break.
--
-- First, the compound filetype means Treesitter resolves the language from the
-- leading component and goes looking for a `svelte` parser. Without one,
-- opening any .svx file throws "Parser could not be created ... language
-- svelte" out of the markdown ftplugin. The lang.svelte extra installs that
-- parser, so disabling the extra brings the crash back. The old config only
-- escaped it because nvim-treesitter's auto_install fetched parsers on demand.
--
-- Second, lua/plugins/lsp.lua lists `svx` among the filetypes for marksman and
-- svelte, but with this autocmd in place the filetype is `svelte.markdown` and
-- never plain `svx`, so those entries never actually match. That was equally
-- true of the old config, and it is harmless.
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  desc = "mdsvex files are Svelte-flavoured markdown",
  group = vim.api.nvim_create_augroup("shiroko-svelte", { clear = true }),
  pattern = "*.svx",
  callback = function()
    vim.bo.filetype = "svelte.markdown"
  end,
})
