return {
  "neovim/nvim-lspconfig",
  cmd = { "LspInfo", "LspInstall", "LspStart" },
  -- dependencies = { 'saghen/blink.cmp' },
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    servers = {
      lua_ls = {},       -- pacman: lua-language-server
      clangd = {},       -- pacman: clang
      bashls = {},       -- pacman: bash-language-server
      marksman = {},     -- pacman: marksman
      ruff = {},         -- pacman: ruff
      basedpyright = {}, -- AUR: basedpyright
      jsonls = {},       -- AUR: vscode-langservers-extracted
      cssls = {},        -- AUR: vscode-langservers-extracted
      eslint = {},       -- AUR: vscode-langservers-extracted
      html = {},         -- AUR: vscode-langservers-extracted
    }
  },
  config = function(_, opts)
    local lspconfig = require('lspconfig')
    for server, config in pairs(opts.servers) do
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      lspconfig[server].setup(config)
    end
  end
}
