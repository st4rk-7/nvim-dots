return {
  {
    'ixru/nvim-markdown',
    ft = { 'markdown' },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown' },
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      pipe_table = { preset = 'round' },
      checkbox = {
        unchecked = { icon = '✘ ' },
        checked = { icon = '✔ ' },
        custom = { todo = { rendered = '◯ ' } },
      },
      sign = { enabled = false },
      code = {
        position = 'right',
        width = 'block',
        min_width = 70,
      },
      heading = {
        sign = false,
        -- icons = { '󰼏 ', '󰼐 ', '󰼑 ', '󰼒 ', '󰼓 ', '󰼔 ' },
        position = 'inline',
        width = 'block',
        left_margin = 0.5,
        left_pad = 0.2,
        right_pad = 0.2,
      },
    },
  },
}
