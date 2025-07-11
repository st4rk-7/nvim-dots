return {
  "rolv-apneseth/tfm.nvim",
  keys = {
    { "<leader><space>", function() require("tfm").open() end,                                      desc = "lf" },
    { "<leader>fh",      function() require("tfm").open(nil, require("tfm").OPEN_MODE.split) end,   desc = "lf hsplit" },
    { "<leader>fv",      function() require("tfm").open(nil, require("tfm").OPEN_MODE.vsplit) end,  desc = "lf vsplit" },
    { "<leader>ft",      function() require("tfm").open(nil, require("tfm").OPEN_MODE.tabedit) end, desc = "lf tab" },
  },
  opts = {
    file_manager = "lf",
    replace_netrw = true,
    ui = {
      border = "single",
      height = 0.5,
      width = 0.6,
      x = 0,
      y = 0,
    },
  },
}
