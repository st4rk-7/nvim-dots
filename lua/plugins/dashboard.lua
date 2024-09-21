return {
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    config = function()
      local dashboard = require 'alpha.themes.dashboard'

      local create_gradient = function(start, finish, steps)
        local r1, g1, b1 = tonumber('0x' .. start:sub(2, 3)), tonumber('0x' .. start:sub(4, 5)), tonumber('0x' .. start:sub(6, 7))
        local r2, g2, b2 = tonumber('0x' .. finish:sub(2, 3)), tonumber('0x' .. finish:sub(4, 5)), tonumber('0x' .. finish:sub(6, 7))

        local r_step = (r2 - r1) / steps
        local g_step = (g2 - g1) / steps
        local b_step = (b2 - b1) / steps

        local gradient = {}
        for i = 1, steps do
          local r = math.floor(r1 + r_step * i)
          local g = math.floor(g1 + g_step * i)
          local b = math.floor(b1 + b_step * i)
          table.insert(gradient, string.format('#%02x%02x%02x', r, g, b))
        end

        return gradient
      end

      local function apply_gradient_hl(text)
        local gradient = create_gradient('#5e81ac', '#c8ced7', #text)

        local lines = {}
        for i, line in ipairs(text) do
          local tbl = {
            type = 'text',
            val = line,
            opts = {
              hl = 'HeaderGradient' .. i,
              shrink_margin = false,
              position = 'center',
            },
          }
          table.insert(lines, tbl)

          -- create hl group
          vim.api.nvim_set_hl(0, 'HeaderGradient' .. i, { fg = gradient[i] })
        end

        return {
          type = 'group',
          val = lines,
          opts = { position = 'center' },
        }
      end

      local headers = require 'ascii'

      dashboard.section.buttons.val = {
        dashboard.button('r', '  Recent files', ":lua require('telescope.builtin').oldfiles()<CR>"),
        dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
        dashboard.button('f', '  Find file', ":lua require('telescope.builtin').find_files()<CR>"),
        dashboard.button('t', '󱎸  Find text', ":lua require('telescope.builtin').live_grep()<CR>"),
        dashboard.button('n', '󰠮  Notes', ":lua require('telescope.builtin').find_files({cmd=[[fd -t f -e 'md' -e 'txt' -e 'qalc']],cwd =[[~/notes]]})<CR>"),
        dashboard.button('c', '  Configuration', ':e $MYVIMRC <CR>'),
        dashboard.button('z', '󰒲  Lazy', ':Lazy<CR>'),
        dashboard.button('q', '  Quit', ':qa<CR>'),
      }
      dashboard.section.buttons.opts.spacing = 0

      vim.api.nvim_create_autocmd('User', {
        pattern = 'LazyVimStarted',
        callback = function()
          local stats = require('lazy').stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = '󱎫  ' .. ms .. ' ms'
          pcall(vim.cmd.AlphaRedraw)
        end,
      })

      local headerKeys = {}
      for key, _ in pairs(headers) do
        table.insert(headerKeys, key)
      end
      local randomHeader = headerKeys[math.random(#headerKeys)]

      dashboard.config.layout = {
        { type = 'padding', val = 3 },
        -- options = randomHeader, raven, yggdrasil,
        -- void_stranger, aot, meatboy, isaac, gta,
        -- hydra, spider, morse, sharp, galaxy,
        apply_gradient_hl(headers[randomHeader]),
        { type = 'padding', val = 4 },
        dashboard.section.buttons,
        { type = 'padding', val = 4 },
        dashboard.section.footer,
      }

      dashboard.opts.opts.noautocmd = true
      require('alpha').setup(dashboard.opts)
    end,
  },
}
