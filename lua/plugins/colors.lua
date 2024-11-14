return {
  {
    'miikanissi/modus-themes.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      require('modus-themes').setup {
        transparent = true,
      }
      vim.cmd.colorscheme 'modus_vivendi'
      vim.keymap.set('n', '<leader>uc', '<cmd>Lazy reload modus-themes.nvim<cr>', { desc = '[U]pdate [C]olorscheme' })
    end,
  },
}
