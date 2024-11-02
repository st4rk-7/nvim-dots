return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  config = function()
    local function get_colors()
      local colorscheme = vim.g.colors_name
      if colorscheme == 'tokyonight-moon' then
        local colors = require('tokyonight.colors').setup()
        return {
          bg = colors.none,
          fg = colors.comment,
          -- active_buf = colors.fg,
        }
        -- elseif colorscheme == "default" then
        --   return {
        --     bg = '#14161b',
        --     fg = '#9B9EA4',
        --     -- active_buf = "#E0E2EA",
        --   }
      else
        return {
          bg = '',
          fg = '',
          -- active_buf = "",
        }
      end
    end

    local colors = get_colors()

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand '%:t') ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand '%:p:h'
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    local config = {
      options = {
        component_separators = '',
        section_separators = '   ',
        disabled_filetypes = { 'help', 'lazy', 'mason', 'fzf', 'lspinfo', 'alpha' },
        theme = {
          normal = { c = { fg = colors.fg, bg = colors.bg } },
          inactive = { c = { fg = colors.fg, bg = colors.bg } },
        },
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
    }
    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end
    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    ins_left {
      'mode',
    }

    ins_left {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      -- Displays diagnostics for the defined severity types
      sections = { 'error', 'warn' },
      symbols = { error = ' ', warn = ' ' },
      colored = false,
    }

    ins_left {
      function()
        return '%='
      end,
    }

    -- ins_left({
    --   "buffers",
    --   hide_filename_extension = false,
    --   buffers_color = {
    --     active = { fg = colors.active_buf, bg = colors.bg },
    --     inactive = { fg = colors.fg, bg = colors.bg },
    --   },
    --   symbols = {
    --     modified = " ●",
    --     alternate_file = "",
    --   },
    --   cond = conditions.buffer_not_empty,
    --   color = { fg = colors.active_buf, gui = "bold" },
    -- })

    ins_left {
      'filename',
      file_status = true, -- Displays file status (readonly status, modified status)
      newfile_status = false, -- Display new file status (new file means no write after created)
      path = 0, -- 0: Just the filename
      symbols = {
        modified = '[+]', -- Text to show when the file is modified.
        readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
        unnamed = '[No Name]', -- Text to show for unnamed buffers.
        newfile = '[New]', -- Text to show for newly created file before first write
      },
    }

    ins_right {
      function()
        if vim.bo.filetype == 'txt' or vim.bo.filetype == 'markdown' or vim.bo.filetype == 'tex' then
          if vim.fn.wordcount().visual_words == 1 then
            return tostring(vim.fn.wordcount().visual_words) .. ' word'
          elseif not (vim.fn.wordcount().visual_words == nil) then
            return tostring(vim.fn.wordcount().visual_words) .. ' words'
          else
            return tostring(vim.fn.wordcount().words) .. ' words'
          end
        else
          return ''
        end
      end,
    }

    ins_right {
      -- Lsp server name
      function()
        local msg = 'Inactive'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end
        return msg
      end,
      icon = ' ',
    }

    ins_right {
      'branch',
      icon = '',
      color = { gui = 'bold' },
    }
    ins_right {
      'location',
    }

    require('lualine').setup(config)
  end,
}
