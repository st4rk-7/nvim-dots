return {
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    event = "VeryLazy",
    version = "v0.*",
    opts = {
      keymap = { preset = "enter" },
      completion = {
        trigger = { show_on_insert_on_trigger_character = false, },
        accept = { auto_brackets = { enabled = true } },
        documentation = { auto_show = true, auto_show_delay_ms = 200, window = { border = 'single' } },
        ghost_text = { enabled = vim.g.ai_cmp },
        menu = { border = 'single' },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      cmdline = { enabled = false },
      signature = { enabled = true, window = { border = 'single' } }
    },
  },
}
