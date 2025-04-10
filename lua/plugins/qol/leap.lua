return {
  "ggandor/leap.nvim",
  event = "VeryLazy",
  keys = {
    { "s",  mode = { "n", "x", "o" }, desc = "Leap Forward to" },
    { "S",  mode = { "n", "x", "o" }, desc = "Leap Backward to" },
    { "gs", mode = { "n", "x", "o" }, desc = "Leap Remote" },
    { "gS", mode = { "n", "x", "o" }, desc = "Leap from Windows" },
    { "ga", mode = { "n", "x", "o" }, desc = "Leap treesitter" },
    { "gA", mode = { "n", "x", "o" }, desc = "Leap treesitter linewise" },
  },
  config = function(_, opts)
    local leap = require("leap")
    for k, v in pairs(opts) do
      leap.opts[k] = v
    end
    leap.set_default_mappings()
    vim.keymap.set({ "n", "x", "o" }, "ga", function()
      require("leap.treesitter").select()
    end)
    vim.keymap.set({ "n", "x", "o" }, "gA", 'V<cmd>lua require("leap.treesitter").select()<cr>')
    vim.keymap.set({ 'n', 'o' }, 'gs', function() require('leap.remote').action() end)
    local default_text_objects = {
      'iw', 'iW', 'is', 'ip', 'i[', 'i]', 'i(', 'i)', 'ib',
      'i>', 'i<', 'it', 'i{', 'i}', 'iB', 'i"', 'i\'', 'i`',
      'aw', 'aW', 'as', 'ap', 'a[', 'a]', 'a(', 'a)', 'ab',
      'a>', 'a<', 'at', 'a{', 'a}', 'aB', 'a"', 'a\'', 'a`',
    }
    for _, tobj in ipairs(default_text_objects) do
      vim.keymap.set({ 'x', 'o' }, tobj:sub(1, 1) .. 'r' .. tobj:sub(2), function()
        require('leap.remote').action { input = tobj }
      end)
    end
  end,
}
