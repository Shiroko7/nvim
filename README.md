# nvim

My Neovim config: [LazyVim](https://lazyvim.org) as the base, with my own
options, keymaps and plugins layered on top.

Previously a Packer config in the ThePrimeagen layout (`lua/shiroko/`,
`after/plugin/`). The settings and habits carried over; the plugin management,
LSP and formatting did not.

## Install

```bash
# Linux / macOS
git clone https://github.com/Shiroko7/nvim ~/.config/nvim

# Windows
git clone https://github.com/Shiroko7/nvim $env:LOCALAPPDATA\nvim
```

Then start `nvim`. lazy.nvim bootstraps itself and installs everything pinned in
`lazy-lock.json`; mason fetches language servers on first use.

Needs Neovim **0.9+**, `git`, a C compiler for Treesitter, and
[ripgrep](https://github.com/BurntSushi/ripgrep). `fd` is optional. Icons need a
Nerd Font installed *and* selected in the terminal.

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

The ordering is the trick: LazyVim sets its defaults, then sources
`lua/config/*`, so anything there overrides it without a fight.

## Keymaps

Leader is `<Space>`. Everything LazyVim binds is still there; these are the
additions.

| key | does |
|---|---|
| `<leader>pv` | netrw (`<leader>e` is LazyVim's explorer) |
| `<leader>pf` | find files |
| `<C-p>` | find git files |
| `<leader>ps` | grep, prompts first |
| `<leader>a` | harpoon: add file |
| `<C-e>` | harpoon: menu |
| `<leader>1`–`<leader>4` | harpoon: jump to file |
| `<C-S-P>` / `<C-S-N>` | harpoon: previous / next |
| `<leader>gs` | fugitive status |
| `<leader>y` / `<leader>Y` | yank to system clipboard |
| `J` / `K` (visual) | move selection |
| `<C-d>` / `<C-u>` / `n` / `N` | scroll and search, centred |

Nothing here collides with LazyVim any more. Earlier versions bound
`<leader>f`, which was a prefix of LazyVim's `<leader>ff`/`<leader>fg` and so
paused for `timeoutlen` on every press; and harpoon on `<C-h/j/k/l>`, which cost
window navigation. Both went back to LazyVim.

## Plugins beyond LazyVim

harpoon2, vim-fugitive, copilot.vim, nvim-treesitter-context, and
onedark.nvim.

Pickers, the file explorer and commenting are LazyVim's (snacks picker, snacks
explorer, and Neovim 0.12's built-in `gc` with ts-comments.nvim). Telescope,
nvim-tree, undotree and Comment.nvim were all removed as duplicates of
something LazyVim already provides.

### Colourscheme

`navarasu/onedark.nvim`, transparent, `style = "dark"`.

Not `joshdick/onedark.vim`, which is what the old config used and why nothing
ever looked like onedark: that plugin defines about two dozen highlight groups
and none of the modern ones — no `NormalFloat`, `FloatBorder`, `WinSeparator`,
no `@...` Treesitter captures, no `@lsp.*` semantic tokens. Every float,
picker, popup and syntax highlight fell through to Neovim's built-in defaults.

The old transparency trick is gone too. `nvim_set_hl(0, "Normal", {bg="none"})`
*replaces* the group instead of patching it, so the theme's foreground was
discarded along with the background:

```
after colorscheme:  { fg = 11252415, bg = 2632756, ... }
after the hack:     vim.empty_dict()
```

onedark.nvim has a real `transparent` option.

## Language support

LazyVim extras, listed in `lazyvim.json` and editable with `:LazyExtras` —
clangd, go, json, markdown, python, rust, svelte, tailwind, typescript, zig,
plus prettier and eslint. Each brings its server, formatter and linter as a set,
which is what replaced the hand-rolled lsp-zero setup.

Two customisations survive on top, in `lua/plugins/lsp.lua`: the extra
filetypes attached to `marksman` and `svelte`, for mdsvex.

### Python formatting

`lang.python` expects formatting from the ruff language server, but ruff's
server does not advertise `documentFormattingProvider` (checked against 0.16.7),
so Python buffers were never formatted. `lua/plugins/formatting.lua` routes
Python through conform's `ruff_format` instead, driving the same binary. Delete
that file once ruff advertises the capability.

### Completion

blink.cmp on its `default` preset — `<C-p>`/`<C-n>` to move, `<C-y>` to accept,
`<C-space>` to show, `<C-e>` to cancel. `<Tab>` is switched off, because
copilot.vim claims insert-mode `<Tab>` for `copilot#Accept()` and wins outright.

## Notes

`checker` is disabled in `config/lazy.lua`: lazy.nvim will not nag about
upstream updates, so the versions in `lazy-lock.json` stay put until `:Lazy
sync` is run deliberately.

Bugs in the old config, fixed rather than carried over:

- `lua/shiroko/package.lua` was never `require`d. The Packer plugin spec had
  never been sourced; plugins only loaded because the committed
  `plugin/packer_compiled.lua` autoloaded, with `/home/shiro` paths baked in.
- `init.lua` declared `augroup fmt` twice, each with `autocmd!`, so the second
  wiped the first and **Black never ran on save**.
- `*.ts` matched both the `fmt` and `Prettier` autocmd groups, so TypeScript was
  formatted twice on every write.
- nvim-tree ran `autocmd! FileExplorer *` to hijack netrw at startup, which
  errored with `E216` because netrw had not loaded yet. nvim-tree is gone now.
- `*.svx` gets the compound filetype `svelte.markdown`, so Treesitter looks for
  a `svelte` parser and the markdown ftplugin throws without one. The old config
  survived on `auto_install`; the `lang.svelte` extra now guarantees the parser.
  The LSP filetype lists were also corrected — they said `svx`, which with that
  autocmd in place never matches anything.
