return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      local headers = require 'ascii'
      local headerKeys = {}
      for key, _ in pairs(headers) do
        table.insert(headerKeys, key)
      end
      local randomHeader = headerKeys[math.random(#headerKeys)]
      local selectedHeader = table.concat(headers[randomHeader], '\n')
      require('snacks').setup {
        bigfile = { enabled = true },
        quickfile = { enabled = true },
        dashboard = {
          enabled = true,
          width = 60,
          row = nil, -- dashboard position. nil for center
          col = nil, -- dashboard position. nil for center
          pane_gap = 4, -- empty columns between vertical panes
          autokeys = '1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', -- autokey sequence
          -- These settings are used by some built-in sections
          preset = {
            -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
            ---@type fun(cmd:string, opts:table)|nil
            pick = nil,
            -- Used by the `keys` section to show keymaps.
            -- Set your curstom keymaps here.
            -- When using a function, the `items` argument are the default keymaps.
            ---@type snacks.dashboard.Item[]
            keys = {
              { icon = ' ', key = 's', desc = 'Smart Open', action = ":lua require('telescope').extensions.smart_open.smart_open()" },
              { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
              { icon = '󰈙 ', key = 'e', desc = 'New File', action = ':ene | startinsert' },
              { icon = '󰂺 ', key = 'n', desc = 'Notes', action = ":lua Snacks.dashboard.pick('files', {cwd = [[~/notes]]})" },
              { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
              { icon = '󰒲 ', key = 'z', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
              { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
            },
            -- Used by the `header` section
            header = selectedHeader,
          },
          -- item field formatters
          formats = {
            icon = function(item)
              if item.file and item.icon == 'file' or item.icon == 'directory' then
                return M.icon(item.file, item.icon)
              end
              return { item.icon, width = 2, hl = 'icon' }
            end,
            footer = { '%s', align = 'center' },
            header = { '%s', align = 'center' },
            file = function(item, ctx)
              local fname = vim.fn.fnamemodify(item.file, ':~')
              fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
              local dir, file = fname:match '^(.*)/(.+)$'
              return dir and { { dir .. '/', hl = 'dir' }, { file, hl = 'file' } } or { { fname, hl = 'file' } }
            end,
          },
          sections = {
            { section = 'header', padding = 4 },
            { section = 'keys', padding = 4 },
            { section = 'startup' },
          },
        },
      }
    end,
    -- stylua: ignore start
    keys = {
      { '<leader>gg', function() Snacks.lazygit() end, desc = 'Lazygit', },
      { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
      { '<leader>gf', function() Snacks.lazygit.log_file() end, desc = 'Lazygit Current File History', },
      { '<leader>gl', function() Snacks.lazygit.log() end, desc = 'Lazygit Log (cwd)', },
      { '<leader>cR', function() Snacks.rename.rename_file() end, desc = 'Rename File', },
    },
    -- stylua: ignore end
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          -- Create some toggle mappings
          Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
          Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
          Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'
          Snacks.toggle.diagnostics():map '<leader>ud'
          Snacks.toggle.line_number():map '<leader>ul'
          Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>uc'
          Snacks.toggle.treesitter():map '<leader>uT'
          -- Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>ub'
          Snacks.toggle.inlay_hints():map '<leader>uh'
        end,
      })
    end,
  },
}
