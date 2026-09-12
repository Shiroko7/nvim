-- Bootstrap lazy.nvim, then LazyVim, then our own overrides on top.

-- Must be set before lazy.setup, or any plugin that registers a <leader>
-- mapping at load time binds it to the wrong key.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- LazyVim first, so its defaults are in place before ours are merged.
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "plugins" },
  },
  defaults = {
    -- Our plugins load at startup unless a spec says otherwise. LazyVim's own
    -- are lazy-loaded by its authors, which is where the startup time goes.
    lazy = false,
    -- Use the latest commit rather than the last tag: several plugins here
    -- (harpoon2 in particular) do not tag releases.
    version = false,
  },
  install = { colorscheme = { "onedark", "habamax" } },
  -- Off deliberately. With it on, lazy.nvim polls for upstream commits and
  -- nudges you to update, which is how a working setup drifts away from the
  -- versions pinned in lazy-lock.json. Run :Lazy sync when you actually want
  -- to move, and the lockfile records exactly what you moved to.
  checker = { enabled = false },
  performance = {
    rtp = {
      -- netrwPlugin is deliberately NOT disabled here, unlike the LazyVim
      -- starter: <leader>pv opens netrw with :Ex and would break without it.
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
