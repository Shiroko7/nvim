-- LSP tweaks that sit on top of the LazyVim language extras.
--
-- The extras are enabled in lazyvim.json and now own the servers themselves:
-- each one installs its server, its formatter and its linter as a set. What is
-- left here is the part that was genuinely yours and that no extra knows about
-- - the extra filetypes you attach to marksman and svelte.
--
-- What the old lua/shiroko + after/plugin/lsp.lua setup declared, and where it
-- went:
--
--   clangd, jsonls, tailwindcss  ->  lang.clangd / lang.json / lang.tailwind
--   eslint                       ->  linting.eslint
--   gopls                        ->  lang.go, which adds gofumpt and goimports
--   marksman                     ->  lang.markdown, customised below
--   pyright, ruff                ->  lang.python (pyright is still the default)
--   rust_analyzer                ->  lang.rust, driven by rustaceanvim
--   svelte                       ->  lang.svelte, customised below
--   tsserver                     ->  lang.typescript, as vtsls
--   luau_lsp                     ->  dropped; lua_ls is in LazyVim core, and
--                                    luau_lsp is the Roblox Luau server, which
--                                    was almost certainly not what you wanted
--   pylsp                        ->  dropped; pyright and ruff cover it, and a
--                                    third Python server just triples the
--                                    diagnostics
--
-- lsp-zero is gone entirely. It existed to wire mason, lspconfig and nvim-cmp
-- together, which is exactly what LazyVim already does.

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Your addition: treat mdsvex files as markdown for marksman too.
        marksman = {
          filetypes = { "markdown", "svx" },
        },

        -- Your svelte settings, carried over verbatim on top of lang.svelte.
        svelte = {
          filetypes = { "svelte", "svex", "svx" },
          settings = {
            svelte = {
              plugin = {
                html = { enable = true },
                css = { enable = true },
                javascript = { enable = true },
                typescript = { enable = true },
                svelte = { enable = true },
              },
            },
          },
        },
      },
    },
  },
}
