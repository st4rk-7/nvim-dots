vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.background = 'light'
vim.cmd.colorscheme 'default'

vim.g.have_nerd_font = true

require 'options'
require 'keymaps'
require 'autocmds'
require 'lazy-bootstrap'

-- vim: ts=2 sts=2 sw=2 et
