-- Telescope, which LazyVim no longer ships.
--
-- Current LazyVim uses snacks.nvim's picker for <leader>ff, <leader>fg and the
-- rest. Your four search mappings call telescope.builtin directly, so without
-- this they would all error. Both can coexist: snacks keeps LazyVim's own
-- pickers, telescope backs yours.
--
-- The old spec pinned tag 0.1.6. That pin is dropped in favour of the current
-- release - 0.1.6 predates Neovim 0.11 and does not get on with 0.12.
--
-- live_grep and grep_string need ripgrep, which is installed.

return {
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
}
