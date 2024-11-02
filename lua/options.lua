-- [[ Setting options ]]

vim.g.neovide_padding_bottom = 0
vim.g.neovide_padding_left = 10
vim.g.neovide_padding_right = 10
vim.g.neovide_padding_top = 5
vim.opt.autochdir = true
vim.opt.autoindent = true
vim.opt.autowrite = true
vim.opt.breakindent = true
vim.opt.cursorline = false
vim.opt.expandtab = true
vim.opt.guifont = 'JetBrainsMono NF:h9'
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.inccommand = 'nosplit'
vim.opt.incsearch = true
vim.opt.laststatus = 3
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.pumblend = 20
vim.opt.pumheight = 10
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.shiftwidth = 2
vim.opt.shortmess = 'atTWAI'
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.smoothscroll = true
vim.opt.softtabstop = 2
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.virtualedit = 'block'
vim.opt.wrap = true
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)
vim.diagnostic.config {
  underline = false,
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.HINT] = '󰌵',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.WARN] = '',
    },
  },
  update_in_insert = false,
  severity_sort = true,
}
vim.cmd 'hi Comment gui=italic cterm=italic'
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextError', { link = 'Comment' })
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextHint', { link = 'Comment' })
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextInfo', { link = 'Comment' })
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextWarn', { link = 'Comment' })

-- vim: ts=2 sts=2 sw=2 et
