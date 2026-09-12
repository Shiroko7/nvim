-- Every mapping from the old config, in one place.
--
-- LazyVim sources this after setting up its own keymaps, so these win on any
-- collision. Three collisions are deliberate and worth knowing about; they are
-- flagged inline.
--
-- Plugin modules are required inside the callbacks rather than at the top of
-- the file, so that pressing the key is what loads the plugin.

local map = vim.keymap.set

-- ---------------------------------------------------------------------------
-- Editing
-- ---------------------------------------------------------------------------

-- File explorer (netrw). LazyVim would use neo-tree here; netrw is kept, and
-- netrwPlugin is deliberately left enabled in config/lazy.lua because of this.
map("n", "<leader>pv", vim.cmd.Ex, { desc = "Explorer (netrw)" })

-- Move the visual selection up and down, reindenting as it goes
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Yank to the system clipboard explicitly
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
map("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })

-- Keep the cursor centred while moving through a file
local centred = { noremap = true, silent = true }
map("n", "<C-d>", "<C-d>zz", centred)
map("n", "<C-u>", "<C-u>zz", centred)
map("n", "n", "nzzzv", centred)
map("n", "N", "Nzzzv", centred)
map("n", "{", "{zzzv", centred)
map("n", "}", "}zzzv", centred)

-- ---------------------------------------------------------------------------
-- Telescope
-- ---------------------------------------------------------------------------

-- COLLISION: LazyVim uses <leader>f as a prefix group (<leader>ff, <leader>fg,
-- and so on). Mapping <leader>f directly does not delete those, but it does
-- mean Neovim waits timeoutlen (300ms) to see whether another key follows.
-- Your mapping wins, at the cost of that pause. Deleting LazyVim's group would
-- make it instant.
map("n", "<leader>f", function()
  require("telescope.builtin").live_grep()
end, { desc = "Live grep" })

map("n", "<leader>pf", function()
  require("telescope.builtin").find_files()
end, { desc = "Find files" })

map("n", "<C-p>", function()
  require("telescope.builtin").git_files()
end, { desc = "Find git files" })

map("n", "<leader>ps", function()
  require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "Grep for a prompt" })

-- ---------------------------------------------------------------------------
-- Harpoon
-- ---------------------------------------------------------------------------

-- COLLISION: LazyVim maps <C-h/j/k/l> to window navigation. These override it,
-- as they did before. <C-w>h/j/k/l still moves between windows.
map("n", "<leader>a", function()
  require("harpoon"):list():add()
end, { desc = "Harpoon: add file" })

map("n", "<C-e>", function()
  local harpoon = require("harpoon")
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon: menu" })

for i, key in ipairs({ "<C-h>", "<C-j>", "<C-k>", "<C-l>" }) do
  map("n", key, function()
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

-- ---------------------------------------------------------------------------
-- Undotree
-- ---------------------------------------------------------------------------

-- ADDED, not in the old config: undotree was installed but had no mapping, so
-- there was no way to open it. <leader>U rather than the usual <leader>u
-- because LazyVim uses <leader>u as its UI prefix group.
map("n", "<leader>U", vim.cmd.UndotreeToggle, { desc = "Undotree" })

-- ---------------------------------------------------------------------------
-- File tree
-- ---------------------------------------------------------------------------

-- neo-tree is disabled in favour of nvim-tree (see lua/plugins/editor.lua),
-- which takes LazyVim's <leader>e with it. Rebound to the equivalent.
map("n", "<leader>e", vim.cmd.NvimTreeToggle, { desc = "Explorer (nvim-tree)" })
