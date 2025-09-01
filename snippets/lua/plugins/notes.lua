return {
  {
    "lervag/vimtex",
    ft = "tex",
    init = function()
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_syntax_enabled = 1
      vim.g.vimtex_quickfix_mode = 0
    end,
  },

  { "iffse/qalculate.vim", ft = "qalculate" },
  { "ixru/nvim-markdown",  ft = "markdown" },
  { "mipmip/vim-scimark",  ft = "markdown" }
}
