-- Completion keys.
--
-- This used to spell out every binding with `preset = "none"`, which meant any
-- key blink added later would never reach this config. It turns out not to be
-- necessary: blink's built-in `default` preset already maps exactly the four
-- keys the old lsp-zero setup did.
--
--   <C-p>      select_prev
--   <C-n>      select_next
--   <C-y>      select_and_accept
--   <C-space>  show / show_documentation / hide_documentation
--   <C-e>      cancel
--
-- So `preset = "default"` keeps the bindings identical and lets blink's future
-- defaults through - plus <C-b>/<C-f> to scroll docs and <C-k> for signature
-- help, which the old config had no equivalent of.
--
-- Tab is switched off on purpose. The preset maps it to snippet navigation,
-- but copilot.vim claims insert-mode <Tab> for copilot#Accept() and wins, so
-- the snippet binding was dead either way. Setting it to `false` says that
-- outright instead of leaving a mapping that never fires.

return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "default",
        ["<Tab>"] = false,
        ["<S-Tab>"] = false,
      },
    },
  },
}
