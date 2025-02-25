return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      dashboard = {
        preset = {
          header = [[



  ▀
█▀█▄█▀█▀█▀█

]],
          keys = {
            { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = '󰈙 ', key = 'e', desc = 'New File', action = ':ene | startinsert' },
            { icon = '󰂺 ', key = 'n', desc = 'Notes', action = ":lua Snacks.dashboard.pick('files', {cwd = [[~/notes]]})" },
            { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = '󰒲 ', key = 'z', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
            { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
          },
        },
        sections = {
          { section = "header", },
          { section = "keys",       padding = 2 },
          { title = "Recent Files", section = "recent_files", padding = 2 },
          { title = "Projects",     section = "projects",     padding = 2 },
          -- { section = "startup" },
        },
      },
      indent = {
        scope = {
          animate = {
            enabled = true,
          },
        },
      },
      lazygit = {},
      words = {},
      scroll = { enabled = false },
      -- statuscolumn = { enabled = true },
      zen = {
        win = {
          style = {
            enter = true,
            fixbuf = false,
            minimal = true,
            width = 120,
            height = 0,
            backdrop = { transparent = false, blend = 90 },
            keys = { q = false },
            wo = { winhighlight = "NormalFloat:Normal" }
          }
        }
      },
    },
    keys = {
      {
        "<leader>p",
        function()
          Snacks.terminal(
            "compiler " .. vim.fn.expand("%:p") .. "; echo -e '\npress ENTER'; read ENTER",
            { win = { position = "right", wo = { winbar = "" } } })
        end,
        desc = "Compiler"
      },
      { "\\x",        function() Snacks.terminal(nil, { win = { position = "right", wo = { winbar = "" } } }) end, desc = "Vertical Terminal" },
      { "\\X",        function() Snacks.terminal(nil, { win = { wo = { winbar = "" } } }) end,                     desc = "Horizontal Terminal" },
      { "]]",         function() Snacks.words.jump(vim.v.count1) end,                                              desc = "Next Reference",               mode = { "n", "t" } },
      { "[[",         function() Snacks.words.jump(-vim.v.count1) end,                                             desc = "Prev Reference",               mode = { "n", "t" } },
      { '<leader>gg', function() Snacks.lazygit() end,                                                             desc = 'Lazygit', },
      { "<leader>gb", function() Snacks.git.blame_line() end,                                                      desc = "Git Blame Line" },
      { '<leader>gf', function() Snacks.lazygit.log_file() end,                                                    desc = 'Lazygit Current File History', },
      { '<leader>gl', function() Snacks.lazygit.log() end,                                                         desc = 'Lazygit Log (cwd)', },
    },
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          Snacks.toggle.option("spell", { name = "Spelling" }):map("\\s")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("\\w")
          Snacks.toggle.option("cursorline", { name = "Cursorline" }):map("\\c")
          Snacks.toggle.option("list", { name = "List" }):map("\\l")
          Snacks.toggle.option("ignorecase", { name = "Ignorecase" }):map("\\g")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("\\r")
          Snacks.toggle.diagnostics():map("\\d")
          Snacks.toggle.line_number():map("\\n")
          Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map(
            "\\-")
          Snacks.toggle.treesitter():map("\\/")
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("\\b")
          Snacks.toggle.inlay_hints():map("\\h")
          Snacks.toggle.indent():map("\\i")
          Snacks.toggle.zen():map("\\z")
          Snacks.toggle.words():map("\\o")
          Snacks.toggle({
            name = "AutoPairs",
            get = function() return not vim.b.minipairs_disable end,
            set = function(enabled) vim.b.minipairs_disable = not enabled end,
          }):map("\\p")
          Snacks.toggle({
            name = "Trails Removal",
            get = function()
              return vim.b.remove_trails_enabled ~= false
            end,
            set = function(enabled)
              vim.b.remove_trails_enabled = enabled
            end,
          }):map("\\T")
        end,
      })
    end,
  },
}
