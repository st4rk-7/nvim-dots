vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 100 })
  end,
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  pattern = "*",
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  group = vim.api.nvim_create_augroup("DisableAutocommenting", { clear = true }),
})

vim.api.nvim_create_autocmd("FocusGained", {
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
  group = vim.api.nvim_create_augroup("UpdateOnFocus", { clear = true }),
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function(data)
    local directory = vim.fn.isdirectory(data.file) == 1
    if directory then
      require("tfm").open()
    end
  end,
  group = vim.api.nvim_create_augroup("custom_filemanager_ifDirectory", { clear = true }),
})

vim.api.nvim_create_autocmd({ "VimLeave" }, {
  pattern = "*",
  callback = function()
    vim.cmd("set guicursor=a:hor20-blinkon500-blinkoff500-blinkwait700")
  end,
  group = vim.api.nvim_create_augroup("RestoreCursor", { clear = true }),
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  callback = function()
    if vim.b.remove_trails_enabled == false then
      return
    end
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[ %s/\s\+$//e ]])
    vim.cmd([[ %s/\n\+\%$//e ]])
    vim.fn.setpos(".", save_cursor)
  end,
  group = vim.api.nvim_create_augroup("RemoveTrailingWhitespaces", { clear = true }),
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = vim.fn.resolve(vim.fn.expand("~/.config/x11/xresources")),
  callback = function()
    vim.cmd([[!xrdb % ; killall -USR1 st ; renew-dwm]])
  end,
  group = vim.api.nvim_create_augroup("ReloadXresources", { clear = true }),
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
  group = vim.api.nvim_create_augroup("wrap_spell", { clear = true }),
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
  group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
})

local typos = { "W", "Wq", "WQ", "Wqa", "WQa", "WQA", "WqA", "Q", "Qa", "QA" }
for _, cmd in ipairs(typos) do
  vim.api.nvim_create_user_command(cmd, function(opts)
    vim.api.nvim_cmd({
      cmd = cmd:lower(),
      bang = opts.bang,
    }, {})
  end, { bang = true })
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "LICENSE", "LICENSE.*", "COPYING", "COPYING.*", "LICENSE.txt", "LICENSE.md"
  },
  command = "set filetype=license"
})
