return {
  'rolv-apneseth/tfm.nvim',
  keys = {
    { '<leader><space>', "<cmd>lua require('tfm').open()<cr>", desc = 'Lf file manager' },
  },
  opts = {
    file_manager = 'lf',
    ui = {
      border = 'rounded',
      height = 0.5,
      width = 0.5,
      x = 1,
      y = 1,
    },
  },
}
