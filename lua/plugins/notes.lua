return {
  {
    "lervag/vimtex",
    ft = "tex",
    init = function()
      vim.g.vimtex_view_method = "zathura"
      -- vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
      -- vim.g.vimtex_quickfix_enabled = 1
      vim.g.vimtex_syntax_enabled = 1
      vim.g.vimtex_quickfix_mode = 0
      -- vim.g.vimtex_compiler_method = "tectonic"
      -- vim.cmd("call vimtex#init()")
    end,
  },

  { "iffse/qalculate.vim", ft = "qalculate" },

  { "ixru/nvim-markdown",  ft = "markdown" },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    config = function()
      require("render-markdown").setup({
        pipe_table = { preset = "round" },
        sign = { enabled = false },
        code = {
          position = "right",
          width = "block",
          min_width = 70,
        },
        heading = {
          sign = false,
          icons = {},
          position = "inline",
          width = "block",
          left_margin = 0.5,
          left_pad = 0.2,
          right_pad = 0.2,
        },
        bullet = {
          enabled = true,
          icons = { '•', '○', '◆', '◇' },
        }
      })
      require("render-markdown").disable()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "markdown" },
        callback = function()
          Snacks.toggle({
            name = "Render Markdown",
            get = function()
              return require("render-markdown.state").enabled
            end,
            set = function(enabled)
              if enabled then
                require("render-markdown").enable()
              else
                require("render-markdown").disable()
              end
            end,
          }):map("\\m")
        end
      })
    end,
  },
}
