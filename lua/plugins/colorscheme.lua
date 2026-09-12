-- onedark, the maintained Lua port.
--
-- The old config used joshdick/onedark.vim, which is why nothing looked like
-- onedark: that plugin defines about two dozen highlight groups and none of the
-- modern ones. No NormalFloat, no FloatBorder, no WinSeparator, no `@...`
-- Treesitter captures, no `@lsp.*` semantic tokens. Every float, picker,
-- which-key popup, statusline and syntax highlight therefore fell through to
-- Neovim's built-in defaults - which is exactly the generic look you noticed.
--
-- navarasu/onedark.nvim is the same palette with full Treesitter, LSP semantic
-- token and plugin coverage.
--
-- It also has a real `transparent` option, which replaces the old
-- ColorMyPencils trick. That trick was actively destructive: calling
--   nvim_set_hl(0, "Normal", { bg = "none" })
-- REPLACES the group rather than patching it, so onedark's foreground
-- (#abb2bf) was thrown away along with the background and body text fell back
-- to the terminal's default colour. Measured before and after:
--   after colorscheme:  { fg = 11252415, bg = 2632756, ... }
--   after the hack:     vim.empty_dict()

return {
  -- Point LazyVim at it instead of its tokyonight default.
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },

  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      -- "dark" is the classic Atom One Dark palette the old theme used.
      -- Also available: darker, cool, deep, warm, warmer, light.
      style = "dark",
      transparent = true,
      lualine = { transparent = true },
    },
  },
}
