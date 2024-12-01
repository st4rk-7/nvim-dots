return {
  'mcauley-penney/visual-whitespace.nvim',
  event = 'VeryLazy',
  config = function()
    require('visual-whitespace').setup {
      highlight = { link = 'Visual' },
      space_char = '·',
      tab_char = '→',
      nl_char = '',
      cr_char = '←',
      enabled = true,
      excluded = {
        filetypes = {},
        buftypes = {},
      },
    }
    -- This can go in your color scheme or in your plugin config
    vim.api.nvim_set_hl(0, 'VisualNonText', { fg = '#aaaaaa', bg = '#7030AF' })
  end,
}
