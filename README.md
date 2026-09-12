# nvim

My Neovim config: [LazyVim](https://lazyvim.org) as the base, with my own
options, keymaps and plugins layered on top and winning every collision.

Previously a Packer config in the ThePrimeagen layout (`lua/shiroko/`,
`after/plugin/`). The keymaps and settings carried over unchanged; the plugin
management, LSP and formatting did not.

## Install

```bash
# Linux / macOS
git clone https://github.com/Shiroko7/nvim ~/.config/nvim

# Windows
git clone https://github.com/Shiroko7/nvim $env:LOCALAPPDATA\nvim
```

Then start `nvim`. lazy.nvim bootstraps itself, installs everything pinned in
`lazy-lock.json`, and mason fetches the language servers on first use.

Needs Neovim **0.9+**, `git`, a C compiler for Treesitter, and
[ripgrep](https://github.com/BurntSushi/ripgrep) for `<leader>f`. `fd` and a
Nerd Font are optional but make the pickers and icons behave.

## Layout

```
init.lua                   -> require("config.lazy")
lazyvim.json               which LazyVim extras are on
lua/config/lazy.lua        bootstrap, plugin spec roots
lua/config/options.lua     my options    (sourced after LazyVim's, so mine win)
lua/config/keymaps.lua     my keymaps    (likewise)
lua/config/autocmds.lua    my autocmds   (likewise)
lua/plugins/*.lua          plugins LazyVim does not ship, and my overrides
```

The ordering is the whole trick. LazyVim sets its defaults, then sources
`lua/config/*`, so anything in there overrides it without a fight.

## Keymaps

Leader is `<Space>`.

| key | does |
|---|---|
| `<leader>pv` | netrw |
| `<leader>e` | nvim-tree |
| `<leader>f` | live grep |
| `<leader>pf` | find files |
| `<C-p>` | git files |
| `<leader>ps` | grep for a prompt |
| `<leader>a` | harpoon: add file |
| `<C-e>` | harpoon: menu |
| `<C-h/j/k/l>` | harpoon: jump to file 1-4 |
| `<C-S-P>` / `<C-S-N>` | harpoon: previous / next |
| `<leader>gs` | fugitive status |
| `<leader>U` | undotree |
| `<leader>y` / `<leader>Y` | yank to system clipboard |
| `J` / `K` (visual) | move selection |
| `<C-d>` / `<C-u>` / `n` / `N` | scroll and search, centred |

Everything LazyVim binds is still there underneath.

### Three deliberate collisions

- **`<leader>f`** is a prefix group in LazyVim (`<leader>ff`, `<leader>fg`, …).
  Binding it directly does not remove those, but Neovim waits `timeoutlen`
  (300ms) to see whether another key is coming. Mine wins, at the cost of that
  pause.
- **`<C-h/j/k/l>`** are LazyVim's window navigation. Harpoon takes them.
  `<C-w>h/j/k/l` still moves between windows.
- **`<leader>e`** belonged to LazyVim's explorer. neo-tree is disabled in favour
  of nvim-tree, so it is rebound to the equivalent.

## Plugins beyond LazyVim

harpoon2, undotree, vim-fugitive, copilot.vim, Comment.nvim,
nvim-treesitter-context, nvim-tree (replacing neo-tree), telescope (LazyVim now
uses snacks' picker; my four search maps call telescope directly), and onedark
with a transparent background.

## Language support

Handled by LazyVim extras, listed in `lazyvim.json` and editable with
`:LazyExtras` — clangd, go, json, markdown, python, rust, svelte, tailwind,
typescript, zig, plus prettier and eslint. Each extra brings its own server,
formatter and linter as a set, which is why they replaced the hand-rolled
lsp-zero setup.

Two customisations survive on top, in `lua/plugins/lsp.lua`: the extra
filetypes attached to `marksman` and `svelte`, for `.svx`.

### Python formatting

`lang.python` expects formatting from the ruff language server, but ruff's
server does not advertise `documentFormattingProvider` (checked against 0.16.7),
so Python buffers never got formatted. `lua/plugins/formatting.lua` routes
Python through conform's `ruff_format` instead, driving the same binary. Delete
that file once ruff advertises the capability.

### Go

`lang.go` is enabled, but **Go is not installed on this machine**, so mason
cannot build `gopls`, `gofumpt` or `goimports` — they are Go programs. Install
Go and run `:Mason` to fetch them.

## Notes

Three bugs in the old config, fixed rather than carried over:

- `lua/shiroko/package.lua` was never `require`d. The Packer plugin spec had
  never been sourced; plugins only loaded because the committed
  `plugin/packer_compiled.lua` autoloaded, with `/home/shiro` paths baked in.
- `init.lua` declared `augroup fmt` twice, each with `autocmd!`, so the second
  wiped the first and **Black never ran on save**.
- `*.ts` matched both the `fmt` and `Prettier` autocmd groups, so TypeScript was
  formatted twice on every write.

And one that only appeared on Windows: `*.svx` gets the compound filetype
`svelte.markdown`, so Treesitter looks for a `svelte` parser and the markdown
ftplugin throws without one. The old config survived on `auto_install`; the
`lang.svelte` extra now guarantees the parser.
