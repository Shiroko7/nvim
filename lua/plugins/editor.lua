-- Plugins you had that LazyVim does not ship, plus the one swap where you and
-- LazyVim disagree about the file tree.
--
-- Keymaps for all of these live in lua/config/keymaps.lua rather than in each
-- spec's `keys`, because config/keymaps.lua is sourced after LazyVim's own
-- keymaps and therefore wins the collisions on <C-h/j/k/l> and <leader>f.

return {
  -- Harpoon 2. Marked lazy = false so that harpoon:setup() has run before the
  -- first <C-h> lands; the keymaps require() it on demand regardless.
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon"):setup()
    end,
  },

  { "mbbill/undotree", cmd = "UndotreeToggle" },

  { "tpope/vim-fugitive", cmd = { "Git", "G" } },

  -- Kept as github/copilot.vim, the one you had. LazyVim's ai.copilot extra
  -- would pull in copilot.lua instead; the two conflict, so only one.
  { "github/copilot.vim", lazy = false },

  { "numToStr/Comment.nvim", opts = {} },

  -- You used nvim-tree; LazyVim defaults to neo-tree. Yours wins, which means
  -- neo-tree goes: running both leaves two trees fighting over the same
  -- buffer. Disabling it also removes LazyVim's <leader>e, which
  -- config/keymaps.lua rebinds to NvimTreeToggle.
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- Both of these default to true, and both assume netrw is being thrown
      -- away. This config keeps netrw, because <leader>pv opens it with :Ex.
      --
      -- Leaving hijack_netrw on makes nvim-tree run `autocmd! FileExplorer *`
      -- to dismantle netrw's handler. When netrw has not loaded yet that group
      -- does not exist, and startup ends with
      -- `E216: No such group or event: FileExplorer *` every single time.
      disable_netrw = false,
      hijack_netrw = false,
    },
  },

  -- Sticky context header. Settings are exactly the old
  -- after/plugin/treesitter-context.lua.
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
      separator = nil,
      zindex = 20,
      on_attach = nil,
    },
  },
}
