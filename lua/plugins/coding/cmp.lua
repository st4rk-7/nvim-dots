return {
  {
    "saghen/blink.compat",
    version = '*',
    lazy = true,
    opts = {}
  },
  {
    "saghen/blink.cmp",
    version = "v0.*",
    event = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "hrsh7th/cmp-calc",
      "micangl/cmp-vimtex",
      "jc-doyle/cmp-pandoc-references",
    },
    opts = {
      appearance = { use_nvim_cmp_as_default = false, nerd_font_variant = "normal" },
      completion = {
        accept = { auto_brackets = { enabled = true } },
        menu = { border = 'single', draw = { treesitter = { "lsp" } } },
        documentation = { auto_show = true, auto_show_delay_ms = 200, window = { border = 'single' } },
        -- ghost_text = { enabled = true },
      },
      signature = { enabled = true },
      sources = {
        providers = {
          calc = { name = "calc", module = 'blink.compat.source', opts = {} },
          vimtex = { name = "vimtex", module = 'blink.compat.source', opts = {} },
          pandoc_references = { name = "pandoc_references", module = 'blink.compat.source', opts = {} },
        },
        default = { "lsp", "path", "snippets", "buffer", "calc", "vimtex", "pandoc_references" },
      },
      cmdline = { enabled = false },
      keymap = { preset = "enter", ["<C-y>"] = { "select_and_accept" } },
    },
  }
}
