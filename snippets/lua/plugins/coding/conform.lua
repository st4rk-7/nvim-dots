return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  keys = {
    {
      "--",
      function()
        require("conform").format()
        vim.cmd "write"
      end,
      mode = "",
      desc = "LSP Format",
    },
  },
  opts = {
    formatters_by_ft = {
      markdown = { "prettier" },
      sh = { "shfmt" },      -- pacman: shfmt
      html = { "prettier" }, -- pacman: prettier
      css = { "prettier" },
      javascript = { "prettier" },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
  },
}
