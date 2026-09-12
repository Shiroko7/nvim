-- Completion keys.
--
-- The old config set these on nvim-cmp through lsp-zero. LazyVim has since
-- moved to blink.cmp, so the same four bindings are expressed here instead.
-- `preset = "none"` clears blink's defaults first, so nothing unexpected stays
-- mapped underneath.

return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "none",

        -- the four from the old cmp_mappings
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-y>"] = { "accept", "fallback" },
        ["<C-Space>"] = { "show", "fallback" },

        -- dismiss, which the old config left on lsp-zero's defaults
        ["<C-e>"] = { "hide", "fallback" },

        -- Snippet jumps, also previously a default. `fallback` matters here:
        -- with no snippet active, Tab falls through to copilot.vim, which is
        -- what actually wants that key most of the time.
        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
      },
    },
  },
}
