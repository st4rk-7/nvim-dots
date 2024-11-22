-- [[ General Keymaps ]]

vim.keymap.set('c', '<space>', function()
  if vim.fn.getcmdtype() == '?' or vim.fn.getcmdtype() == '/' then
    return '.*'
  else
    return ' '
  end
end, { expr = true })

local function open_terminal(split_type, size, command)
  vim.cmd 'write'
  if split_type == 'vsplit' then
    vim.cmd(size .. 'vsplit')
  elseif split_type == 'split' then
    vim.cmd(size .. 'split')
  end
  vim.cmd 'terminal'
  vim.cmd 'startinsert'
  vim.wo.number = false
  vim.wo.relativenumber = false
  if command then
    vim.defer_fn(function()
      vim.api.nvim_chan_send(vim.b.terminal_job_id, command .. '\n')
    end, 600)
  end
end

vim.keymap.set('n', '<leader>t', function()
  open_terminal('vsplit', 60)
end, { silent = true, desc = 'Vertical terminal' })
vim.keymap.set('n', '<leader>T', function()
  open_terminal('split', 10)
end, { silent = true, desc = 'Horizontal terminal' })
vim.keymap.set('n', '<leader>p', function()
  open_terminal('vsplit', 65, 'compiler ' .. vim.fn.expand '%:p')
end, { silent = true, desc = 'Run compiler script' })

vim.keymap.set('i', '<A-Down>', '<C-\\><C-N><C-w>j')
vim.keymap.set('i', '<A-Left>', '<C-\\><C-N><C-w>h')
vim.keymap.set('i', '<A-Right>', '<C-\\><C-N><C-w>l')
vim.keymap.set('i', '<A-Up>', '<C-\\><C-N><C-w>k')
vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi')
vim.keymap.set('i', '<C-;>', '<Esc>miA;<Esc>`ii')
vim.keymap.set('i', '<C-t>', '<Esc>b~lea')
vim.keymap.set('i', '<C-u>', '<Esc>viwUea')
vim.keymap.set('n', '<A-;>', '<Esc>miA;<Esc>`i')
vim.keymap.set('n', '<A-h>', ':split<CR>', { silent = true })
vim.keymap.set('n', '<A-v>', ':vsplit<CR>', { silent = true })
vim.keymap.set('n', '<A-w>', ':bd<CR>', { silent = true })
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>', { silent = true })
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { silent = true })
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { silent = true })
vim.keymap.set('n', '<C-Up>', ':resize +2<CR>', { silent = true })
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>cg', ':setlocal spell! spelllang=en_us<CR>', { desc = 'Spellcheck', silent = true })
vim.keymap.set('n', '<leader>cx', '<cmd>!chmod +x %<CR>', { desc = 'chmod +x' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>sa', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left><Left>]], { desc = 'Replace All' })
vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', '[b', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
vim.keymap.set('n', ']b', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
vim.keymap.set('n', 'gl', ':lua vim.diagnostic.open_float()<cr>')
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('t', '<C-h>', '<C-\\><C-N><C-w>h')
vim.keymap.set('t', '<C-j>', '<C-\\><C-N><C-w>j')
vim.keymap.set('t', '<C-k>', '<C-\\><C-N><C-w>k')
vim.keymap.set('t', '<C-l>', '<C-\\><C-N><C-w>l')
vim.keymap.set('v', '<', '<gv^')
vim.keymap.set('v', '>', '>gv^')
vim.keymap.set('x', '<leader>h', [["ay:!dmenuhandler '<C-r>a'<cr>]])
vim.keymap.set('x', 'J', ":m '>+1<cr>gv=gv")
vim.keymap.set('x', 'K', ":m '<-2<cr>gv=gv")
vim.keymap.set('x', 'p', 'p:let @+=@0<CR>:let @"=@0<CR>', { silent = true })
vim.keymap.set({ 'x', 'v', 'n' }, '<A-j>', ':m .+1<cr>==')
vim.keymap.set({ 'x', 'v', 'n' }, '<A-k>', ':m .-2<cr>==')

-- vim: ts=2 sts=2 sw=2 et
