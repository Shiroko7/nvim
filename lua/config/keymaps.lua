-- Mappings carried over from the old config.
--
-- LazyVim sources this after its own keymaps, so anything here wins. Since the
-- last pass that matters much less: the three collisions this file used to
-- create have all been resolved in LazyVim's favour, so nothing here fights it
-- any more.
--
-- Plugin modules are required inside the callbacks, so pressing the key is what
-- loads the plugin.

local map = vim.keymap.set

-- ---------------------------------------------------------------------------
-- Editing
-- ---------------------------------------------------------------------------

-- netrw. LazyVim's own explorer stays on <leader>e; this is the old :Ex habit,
-- and it is why netrwPlugin is deliberately left enabled in config/lazy.lua.
map("n", "<leader>pv", vim.cmd.Ex, { desc = "Explorer (netrw)" })

-- Move the visual selection up and down, reindenting as it goes
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Yank to the system clipboard explicitly
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
map("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })

-- Keep the cursor centred while moving through a file.
--
-- `{` and `}` are no longer remapped - `zv` exists to open folds around a
-- search match, which makes sense after n/N and not after a paragraph jump.
-- Those two are back to stock Vim.
local centred = { noremap = true, silent = true }
map("n", "<C-d>", "<C-d>zz", centred)
map("n", "<C-u>", "<C-u>zz", centred)
map("n", "n", "nzzzv", centred)
map("n", "N", "Nzzzv", centred)

-- ---------------------------------------------------------------------------
-- Pickers
-- ---------------------------------------------------------------------------

-- Telescope is gone; these call LazyVim's picker instead. The keys are the old
-- ones, so the habits survive the swap.
--
-- <leader>f is NOT mapped any more. It was a prefix of LazyVim's <leader>ff,
-- <leader>fg and friends, so every press waited timeoutlen to disambiguate.
-- Grep now lives on LazyVim's <leader>sg and <leader>/.

map("n", "<leader>pf", function()
  Snacks.picker.files()
end, { desc = "Find files" })

map("n", "<C-p>", function()
  Snacks.picker.git_files()
end, { desc = "Find git files" })

-- Prompts first, exactly as the old telescope binding did, rather than
-- grepping the word under the cursor.
map("n", "<leader>ps", function()
  Snacks.picker.grep({ search = vim.fn.input("Grep > ") })
end, { desc = "Grep for a prompt" })

-- ---------------------------------------------------------------------------
-- Harpoon
-- ---------------------------------------------------------------------------

-- On <leader>1..4 rather than <C-h/j/k/l>, which go back to LazyVim for window
-- navigation.
map("n", "<leader>a", function()
  require("harpoon"):list():add()
end, { desc = "Harpoon: add file" })

map("n", "<C-e>", function()
  local harpoon = require("harpoon")
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon: menu" })

for i = 1, 4 do
  map("n", "<leader>" .. i, function()
    require("harpoon"):list():select(i)
  end, { desc = "Harpoon: file " .. i })
end

map("n", "<C-S-P>", function()
  require("harpoon"):list():prev()
end, { desc = "Harpoon: previous" })

map("n", "<C-S-N>", function()
  require("harpoon"):list():next()
end, { desc = "Harpoon: next" })

-- ---------------------------------------------------------------------------
-- Git
-- ---------------------------------------------------------------------------

map("n", "<leader>gs", vim.cmd.Git, { desc = "Fugitive status" })
