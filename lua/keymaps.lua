vim.keymap.set("c", "<space>", function()
  if vim.fn.getcmdtype() == "?" or vim.fn.getcmdtype() == "/" then
    return ".*"
  else
    return " "
  end
end, { expr = true })

vim.keymap.set("n", "-n", vim.lsp.buf.rename, { desc = "LSP Rename" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>s", [[:%s/<C-r><C-w>//gIc<Left><Left><Left><Left>]], { desc = "Replace Word" })
vim.keymap.set("x", "<leader>s", [[:s///gIc<Left><Left><Left><Left><Left>]], { desc = "Replace in Visual Selection" })
vim.keymap.set("v", "<", "<gv^")
vim.keymap.set("v", ">", ">gv^")
vim.keymap.set("x", "<leader>h", [["ay:!dmenuhandler '<C-r>a'<cr>]])

vim.keymap.set({ "n", "x" }, "j", [[v:count == 0 ? 'gj' : 'j']], { expr = true })
vim.keymap.set({ "n", "x" }, "k", [[v:count == 0 ? 'gk' : 'k']], { expr = true })


vim.keymap.set({ "n", "x" }, "gy", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set("n", "gp", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set("x", "gp", '"+P', { desc = "Paste from system clipboard" })
vim.keymap.set(
  "n",
  "gV",
  '"`[" . strpart(getregtype(), 0, 1) . "`]"',
  { expr = true, replace_keycodes = false, desc = "Visually select changed text" }
)
vim.keymap.set("x", "g/", "<esc>/\\%V", { silent = false, desc = "Search inside visual selection" })
vim.keymap.set("x", "*", [[y/\V<C-R>=escape(@", '/\')<CR><CR>]], { desc = "Search forward" })
vim.keymap.set("x", "#", [[y?\V<C-R>=escape(@", '?\')<CR><CR>]], { desc = "Search backward" })

vim.keymap.set("n", "<C-H>", "<C-w>h", { desc = "Focus on left window" })
vim.keymap.set("n", "<C-J>", "<C-w>j", { desc = "Focus on below window" })
vim.keymap.set("n", "<C-K>", "<C-w>k", { desc = "Focus on above window" })
vim.keymap.set("n", "<C-L>", "<C-w>l", { desc = "Focus on right window" })
vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h")
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j")
vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k")
vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l")

vim.keymap.set(
  "n",
  "<C-Left>",
  '"<Cmd>vertical resize -" . v:count1 . "<CR>"',
  { expr = true, replace_keycodes = false, desc = "Decrease window width" }
)
vim.keymap.set(
  "n",
  "<C-Down>",
  '"<Cmd>resize -"          . v:count1 . "<CR>"',
  { expr = true, replace_keycodes = false, desc = "Decrease window height" }
)
vim.keymap.set(
  "n",
  "<C-Up>",
  '"<Cmd>resize +"          . v:count1 . "<CR>"',
  { expr = true, replace_keycodes = false, desc = "Increase window height" }
)
vim.keymap.set(
  "n",
  "<C-Right>",
  '"<Cmd>vertical resize +" . v:count1 . "<CR>"',
  { expr = true, replace_keycodes = false, desc = "Increase window width" }
)

vim.keymap.set("c", "<M-h>", "<Left>", { silent = false, desc = "Left" })
vim.keymap.set("c", "<M-l>", "<Right>", { silent = false, desc = "Right" })

vim.keymap.set("i", "<M-h>", "<Left>", { noremap = false, desc = "Left" })
vim.keymap.set("i", "<M-j>", "<Down>", { noremap = false, desc = "Down" })
vim.keymap.set("i", "<M-k>", "<Up>", { noremap = false, desc = "Up" })
vim.keymap.set("i", "<M-l>", "<Right>", { noremap = false, desc = "Right" })
vim.api.nvim_set_keymap("i", "<C-l>", "<C-g>u<Esc>[s1z=`]a<C-g>u", { noremap = true, silent = true })

vim.keymap.set("t", "<M-h>", "<Left>", { desc = "Left" })
vim.keymap.set("t", "<M-j>", "<Down>", { desc = "Down" })
vim.keymap.set("t", "<M-k>", "<Up>", { desc = "Up" })
vim.keymap.set("t", "<M-l>", "<Right>", { desc = "Right" })

vim.keymap.set("n", "<leader>mc", function()
  local ts = vim.treesitter
  if not ts or not ts.get_parser then
    vim.notify("Treesitter is not available", vim.log.levels.ERROR)
    return
  end

  local parser = ts.get_parser(0)
  if not parser then
    vim.notify("No Treesitter parser found for this filetype", vim.log.levels.ERROR)
    return
  end

  local tree = parser:parse()[1]
  local root = tree:root()

  local query = ts.query.get(parser:lang(), "highlights")
  if not query then
    vim.notify("No highlight query found for this filetype", vim.log.levels.ERROR)
    return
  end

  local comments = {}
  for id, node, _ in query:iter_captures(root, 0, 0, -1) do
    local name = query.captures[id]
    if name == "comment" then
      table.insert(comments, node)
    end
  end

  table.sort(comments, function(a, b)
    return a:start() > b:start()
  end)

  local lines_to_check = {}
  local shebang_line = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]
  local has_shebang = shebang_line and shebang_line:match("^#!")

  for _, node in ipairs(comments) do
    local start_row, start_col, end_row, end_col = node:range()
    if has_shebang and start_row == 0 then
      goto continue
    end
    vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, {})
    for i = start_row, end_row do
      lines_to_check[i] = true
    end
    ::continue::
  end

  local lines_deleted = 0
  for line_num in pairs(lines_to_check) do
    line_num = line_num - lines_deleted
    local line = vim.api.nvim_buf_get_lines(0, line_num, line_num + 1, false)[1]
    if line and line:match("^%s*$") then
      vim.api.nvim_buf_set_lines(0, line_num, line_num + 1, false, {})
      lines_deleted = lines_deleted + 1
    end
  end

  vim.cmd "write"
  vim.notify("All comments deleted")
end, { noremap = true, silent = true, desc = "Delte all comments" })

_G.put_empty_line = function(put_above)
  if type(put_above) == 'boolean' then
    vim.o.operatorfunc = 'v:lua.put_empty_line'
    _G.put_empty_line_cache = { put_above = put_above }
    return 'g@l'
  end

  local count = vim.v.count1
  local cur_line = vim.fn.line('.')
  local target_line = cur_line - (_G.put_empty_line_cache.put_above and 1 or 0)

  vim.fn.append(target_line, vim.fn['repeat']({ '' }, count))

  if count == 1 then
    local new_cursor_line = cur_line + (_G.put_empty_line_cache.put_above and 0 or 1)
    vim.api.nvim_win_set_cursor(0, { new_cursor_line, 0 })
  end
end

vim.keymap.set('n', 'gO', function() return _G.put_empty_line(true) end,
  { expr = true, desc = 'Insert empty line above' })
vim.keymap.set('n', 'go', function() return _G.put_empty_line(false) end,
  { expr = true, desc = 'Insert empty line below' })

vim.keymap.set("n", "<leader>mb",
  function()
    local handle = io.popen("bullshit")
    if not handle then
      print("Failed to execute 'bullshit' command.")
      return
    end
    local bullshit = handle:read("*a")
    handle:close()
    if not bullshit then
      print("Failed to read output from 'bullshit' command.")
      return
    end
    bullshit = bullshit:gsub("%s+", "")
    vim.api.nvim_put({ bullshit }, "", true, true)
  end,
  { desc = "Bullshit Generator", noremap = true, silent = true }
)

vim.keymap.set('n', '\\k', function()
  vim.diagnostic.config({ virtual_lines = { current_line = true }, virtual_text = false })
  vim.api.nvim_create_autocmd('CursorMoved', {
    group = vim.api.nvim_create_augroup('line-diagnostics', { clear = true }),
    callback = function()
      vim.diagnostic.config({ virtual_lines = false, virtual_text = true })
      return true
    end,
  })
end, { desc = "Toggle Virtuallines" })
