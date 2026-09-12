-- The plugins from the old config that LazyVim does not ship and that are
-- still wanted.
--
-- Removed deliberately, each for its own reason:
--
--   nvim-tree    LazyVim's explorer (snacks) takes <leader>e instead, so
--                neo-tree is no longer force-disabled either - LazyVim decides
--   telescope    snacks' picker does the same job; the old search keymaps now
--                call Snacks.picker, so the plugin was pure duplication
--   undotree     it was installed with no keymap at all in the old config,
--                so it had never actually been reachable
--   Comment.nvim Neovim 0.12 has built-in commenting on gc/gcc, and LazyVim
--                ships ts-comments.nvim to improve the built-in's
--                commentstring handling for embedded languages (JSX in TSX,
--                <script> in Svelte). Comment.nvim was shadowing both
--
-- Keymaps live in lua/config/keymaps.lua, not in each spec's `keys`, because
-- that file is sourced after LazyVim's own keymaps and so wins any collision.

return {
  -- Harpoon 2. lazy = false so harpoon:setup() has run before the first
  -- <leader>1 lands.
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon"):setup()
    end,
  },

  { "tpope/vim-fugitive", cmd = { "Git", "G" } },

  -- github/copilot.vim, as in the old config. It owns insert-mode <Tab>
  -- outright - see lua/plugins/completion.lua.
  { "github/copilot.vim", lazy = false },

  -- Sticky context header. Settings are the old after/plugin/treesitter-context.lua.
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    opts = {
      enable = true,
      max_lines = 0,
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 20,
      trim_scope = "outer",
      mode = "cursor",
      zindex = 20,
    },
  },
}
