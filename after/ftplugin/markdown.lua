if not pcall(require, "fzf-lua") then
  return
end

local fzf = require("fzf-lua")

local function get_bibfile()
  local cwd = vim.fn.expand("%:p:h")
  local bibfile = cwd .. "/references.bib"
  if vim.fn.filereadable(bibfile) == 1 then
    return bibfile
  else
    return nil
  end
end

local function extract_citations()
  local bibfile = get_bibfile()
  if not bibfile then return {} end

  local handle = io.popen("rg -o '@\\w+\\{([^,]+)' " .. bibfile)
  if not handle then return {} end

  local citations = {}
  for line in handle:lines() do
    local key = line:match("@%w+{([^,]+)")
    if key then
      citations[key] = true
    end
  end
  handle:close()

  local keys = {}
  for key in pairs(citations) do
    table.insert(keys, key)
  end

  return keys
end

_G.insert_citation = function()
  local citations = extract_citations()
  if #citations == 0 then
    vim.notify("No citations found in references.bib", vim.log.levels.WARN)
    return
  end
  fzf.fzf_exec(citations, {
    prompt = "Select Citation(s)> ",
    actions = {
      ["default"] = function(selected)
        if selected and #selected > 0 then
          table.sort(selected)
          local formatted_citations = "[@" .. table.concat(selected, "; @") .. "]"
          vim.api.nvim_put({ formatted_citations }, "", true, true)
        end
      end
    },
    fzf_opts = {
      ["--multi"] = true,
    }
  })
end

vim.api.nvim_buf_set_keymap(0, "n", ",c", "<cmd>lua _G.insert_citation()<CR>", { noremap = true, silent = true })
