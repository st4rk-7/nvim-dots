return {
  {
    "folke/tokyonight.nvim",
    -- enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        transparent = false,
        day_brightness = 0.1,
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "normal", -- style for sidebars, see below
          floats = "normal",   -- style for floating windows
        },
      })
      vim.cmd.colorscheme("tokyonight-night")
    end,
  },
  -- example lazy.nvim install setup
  {
    "slugbyte/lackluster.nvim",
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme("lackluster-hack")
      -- no leap highlights
      -- no snacks words highlights
    end,
  }
}
