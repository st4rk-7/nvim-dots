return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      transparent = false,
      day_brightness = 0.1,
    })
    vim.cmd.colorscheme("tokyonight-night")
  end,
}
