return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",
    spec = {
      { "<leader>g", group = "Git" },
      { "<leader>m", group = "Misc", icon = "" },
      { ",", group = "FzF", icon = "" },
      { ",h", group = "History", icon = "󰋚" },
      { ",r", group = "Resume", icon = "󰐊" },
      { ",g", group = "Git", icon = "" },
      { "-", group = "LSP", icon = "󱌢" },
      { "<leader><space>", icon = "󰝰" },
      { "<leader>f", group = "lf", icon = "󰝰" },
      { "<leader>p", icon = "" },
      { "<leader>s", icon = "󰛔" },
      { "\\\\", desc = "Resume FzF", icon = "" },
      { "<BS>", desc = "Decrement Selection", mode = "x" },
      { "<c-space>", desc = "Increment Selection", mode = { "x", "n" } },
    },
    show_help = false,
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps",
    },
  },
}
