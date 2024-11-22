return {
  'ggandor/leap.nvim',
  enabled = true,
  dependencies = {
    {
      'ggandor/flit.nvim',
      enabled = true,
      keys = function()
        local ret = {}
        for _, key in ipairs { 'f', 'F', 't', 'T' } do
          ret[#ret + 1] = { key, mode = { 'n', 'x', 'o' }, desc = key }
        end
        return ret
      end,
      opts = { labeled_modes = 'nx' },
    },
    { 'tpope/vim-repeat' },
  },
  keys = {
    { 's', mode = { 'n', 'x', 'o' }, desc = 'Leap Forward to' },
    { 'S', mode = { 'n', 'x', 'o' }, desc = 'Leap Backward to' },
    { 'gs', mode = { 'n', 'x', 'o' }, desc = 'Leap from Windows' },
    { 'ga', mode = { 'n', 'x', 'o' }, desc = 'Leap treesitter' },
    { 'gA', mode = { 'n', 'x', 'o' }, desc = 'Leap treesitter linewise' },
  },
  config = function(_, opts)
    local leap = require 'leap'
    for k, v in pairs(opts) do
      leap.opts[k] = v
    end
    leap.add_default_mappings(true)
    vim.keymap.del({ 'x', 'o' }, 'x')
    vim.keymap.del({ 'x', 'o' }, 'X')
    -- vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
    -- vim.api.nvim_set_hl(0, 'LeapMatch', { fg = 'white', bold = true, nocombine = true })
    -- vim.api.nvim_set_hl(0, 'LeapLabelPrimary', { fg = '#f02077', bold = true, nocombine = true })
    -- vim.api.nvim_set_hl(0, 'LeapLabelSecondary', { fg = '#99ddff', bold = true, nocombine = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'ga', function()
      require('leap.treesitter').select()
    end)
    -- Linewise.
    vim.keymap.set({ 'n', 'x', 'o' }, 'gA', 'V<cmd>lua require("leap.treesitter").select()<cr>')
  end,
}
