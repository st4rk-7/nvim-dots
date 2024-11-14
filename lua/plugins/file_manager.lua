return {
  'rolv-apneseth/tfm.nvim',
  keys = {
    { '<leader><space>', "<cmd>lua require('tfm').open()<cr>", desc = 'Lf file manager' },
  },
  opts = {
    file_manager = 'lf',
    replace_netrw = true,
    ui = {
      border = 'rounded',
      height = 0.5,
      width = 0.6,
      x = 0,
      y = 0,
    },
  },
}
