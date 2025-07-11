vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.neovide_padding_bottom = 0
vim.g.neovide_padding_left = 10
vim.g.neovide_padding_right = 10
vim.g.neovide_padding_top = 5
vim.opt.autochdir = true
vim.opt.backup = false
vim.opt.breakindent = true
-- vim.opt.cmdheight = 0
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.expandtab = true
vim.opt.formatoptions = "qjl1"
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.infercase = true
vim.opt.laststatus = 3
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = "tab:> ,extends:…,precedes:…,nbsp:␣"
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.pumblend = 10
vim.opt.pumheight = 10
vim.opt.ruler = false
vim.opt.scrolloff = 10
vim.opt.shiftwidth = 2
vim.opt.shortmess:append("Wc")
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
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
vim.opt.virtualedit = "block"
-- vim.opt.winblend = 5
vim.opt.wrap = true
vim.opt.writebackup = false
vim.cmd("hi Comment gui=italic cterm=italic")
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { link = "Comment" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { link = "Comment" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { link = "Comment" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { link = "Comment" })
vim.diagnostic.config({
  underline = false,
  virtual_text = { current_line = true, severity = { min = "INFO", max = "WARN" } },
  virtual_lines = { current_line = true, severity = { min = "ERROR" } },
  update_in_insert = false,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.WARN] = "",
    },
  },
})


vim.filetype.add({ extension = { qalc = "qalculate" } })

vim.o.foldmethod = "expr"
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldcolumn = "0"
