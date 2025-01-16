return {
  "ibhagwan/fzf-lua",
  event = "VeryLazy",
  config = function()
    require("fzf-lua").setup {
      "borderless_full",
      fzf_colors = true,
      fzf_opts = { ["--no-scrollbar"] = true },
      previewers = {
        builtin = {
          syntax_limit_b = 1024 * 100, -- 100KB
          extensions = {
            ["png"] = "chafa",
            ["jpg"] = "chafa",
            ["jpeg"] = "chafa",
            ["gif"] = "chafa",
            ["webp"] = "chafa",
          },
        },
      },
    }
    local function map(key, method, type)
      local args = {}
      if type == "r" then
        args = { resume = true }
      elseif type == "j" then
        args = { jump_to_single_result = true }
      end
      vim.keymap.set('n', key, function()
        require("fzf-lua")[method](args)
      end, { desc = method })
    end

    vim.keymap.set('n', ",n", function() require("fzf-lua").files({ cwd = vim.fn.stdpath('config') }) end,
      { desc = "nvim config" })
    map(',f', "files")
    map(',b', "buffers")
    map(',,', "builtin")
    map(',g', "live_grep")
    map(',o', "oldfiles")
    map(',s', "spell_suggest")
    map(',t', "registers")
    map(',m', "marks")
    map(',hc', "command_history")
    map(',hs', "search_history")
    map('\\\\', "resume")

    map(',rb', "buffers", "r")
    map(',rf', "files", "r")
    map(',rg', "live_grep", "r")
    map(',ro', "oldfiles", "r")
    map(',rs', "spell_suggest", "r")
    map(',rd', "lsp_definitions", "r")
    map(',ri', "lsp_implementations", "r")
    map(',rD', "lsp_declarations", "r")
    map(',rr', "lsp_references", "r")
    map(',ra', "lsp_code_actions", "r")
    map(',rs', "lsp_document_symbols", "r")
    map(',rw', "lsp_workspace_symbols", "r")
    map(',rc', "lsp_incoming_calls", "r")
    map(',rC', "lsp_outgoing_calls", "r")
    map(',re', "lsp_document_diagnostics", "r")
    map(',rE', "lsp_workspace_diagnostics", "r")

    map('-d', "lsp_definitions", "j")
    map('-i', "lsp_implementations", "j")
    map('-D', "lsp_declarations", "j")
    map('-r', "lsp_references", "j")
    map('-a', "lsp_code_actions")
    map('-s', "lsp_document_symbols")
    map('-w', "lsp_workspace_symbols")
    map('-c', "lsp_incoming_calls")
    map('-C', "lsp_outgoing_calls")
    map('-e', "lsp_document_diagnostics")
    map('-E', "lsp_workspace_diagnostics")
  end,
}
