-- onedark, with a transparent background.
--
-- This is the old after/plugin/colors.lua. That file ran ColorMyPencils() once
-- at startup, which meant the transparency was lost the moment you switched
-- colourscheme. Here it is a ColorScheme autocmd instead, so it survives.

return {
  -- Tell LazyVim which colourscheme to load, instead of its tokyonight default.
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },

  {
    "joshdick/onedark.vim",
    name = "onedark",
    lazy = false,
    priority = 1000,
    init = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        desc = "Transparent background",
        group = vim.api.nvim_create_augroup("shiroko-transparent", { clear = true }),
        callback = function()
          vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
          vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        end,
      })
    end,
  },
}
