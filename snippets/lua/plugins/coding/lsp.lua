return {
  "neovim/nvim-lspconfig",
  cmd = { "LspInfo", "LspInstall", "LspStart" },
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    servers = {
      lua_ls = {},   -- pacman: lua-language-server
      clangd = {},   -- pacman: clang
      bashls = {},   -- pacman: bash-language-server
      ruff = {},     -- pacman: ruff
      pyright = {},  -- pacman: pyright
      tinymist = {}, -- pacman: tinymist
      jsonls = {},   -- AUR: vscode-langservers-extracted
      cssls = {},    -- AUR: vscode-langservers-extracted
      eslint = {},   -- AUR: vscode-langservers-extracted
      html = {},     -- AUR: vscode-langservers-extracted
    }
  },
  config = function(_, opts)
    local lspconfig = require('lspconfig')
    for server, config in pairs(opts.servers) do
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      lspconfig[server].setup(config)
    end
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function(args)
        for _, client in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
          if client.name == 'iwes' then
            return
          end
        end
        vim.lsp.start({
          name = 'iwes',
          cmd = { 'iwes' }, -- AUR: iwe-bin
          root_dir = vim.fs.root(args.buf, { '.iwe' }) or vim.fn.getcwd(),
          flags = {
            debounce_text_changes = 500,
            exit_timeout = false
          }
        })
      end,
    })
  end
}
