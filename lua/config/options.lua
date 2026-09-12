-- Everything from the old lua/shiroko/set.lua and the option half of
-- lua/shiroko/remap.lua. LazyVim sources this after its own defaults, so every
-- line here overrides whatever LazyVim chose.
--
-- The old config set several options twice, in both files, with different
-- values. init.lua required remap before set, so set.lua won. The effective
-- value is what is kept below, with the loser noted, so the behaviour is
-- unchanged from what you were actually running.

local opt = vim.opt

-- Line numbers
opt.nu = true
opt.relativenumber = true

-- Indentation. LazyVim defaults to 2; this is the main visible override.
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.breakindent = true

-- Search. remap.lua also set hlsearch = true; set.lua ran later and won.
opt.hlsearch = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"
opt.colorcolumn = "80"
opt.cursorline = true
opt.showmode = false
-- LazyVim sets wrap = false. You had it on.
opt.wrap = true

-- Whitespace rendering
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Scrolling. remap.lua also set 10; set.lua ran later with 8 and won.
opt.scrolloff = 8

-- Timings. remap.lua also set updatetime = 250; set.lua ran later with 50.
opt.updatetime = 50
opt.timeoutlen = 300

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Live preview of :s
opt.inccommand = "split"

-- Persistent undo, which is what makes undotree worth having
opt.undofile = true

-- Treat @-@ as part of a filename, for gf on paths containing it
opt.isfname:append("@-@")

-- Was set at the bottom of the old init.lua
opt.clipboard = "unnamedplus"
