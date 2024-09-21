return {
  'lervag/vimtex',
  ft = 'tex',
  keys = {
    { '<leader>cc', '<cmd>VimtexCompile<cr>', desc = '[C]ompile latex' },
    { '<leader>co', '<cmd>VimtexCompileOutput<cr>', desc = 'Show latex compiler output' },
  },
  init = function()
    vim.g.vimtex_view_method = 'zathura'
    -- vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
    -- vim.g.vimtex_quickfix_enabled = 1
    vim.g.vimtex_syntax_enabled = 0
    vim.g.vimtex_quickfix_mode = 0
    -- vim.g.vimtex_compiler_method = "tectonic"
    -- vim.cmd("call vimtex#init()")
  end,
}
