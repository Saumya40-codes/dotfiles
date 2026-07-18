-- Keymaps are automatically loaded on the VeryLazy event
-- Defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Only add maps LazyVim does not already provide.

local map = vim.keymap.set

-- Telescope muscle-memory (LazyVim also has <leader>f* snacks/telescope variants)
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Live grep (words)" })
map("n", "<leader>fv", "<cmd>Telescope find_files<CR>", { desc = "Find files" })

-- Keep scroll centered (does not break LazyVim searchforward n/N maps)
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- DAP F-keys (LazyVim already maps <leader>db / dB / du; keep F-keys + Go test debug)
map("n", "<F5>", function()
  require("dap").continue()
end, { desc = "DAP Continue" })
map("n", "<F10>", function()
  require("dap").step_over()
end, { desc = "DAP Step Over" })
map("n", "<F11>", function()
  require("dap").step_into()
end, { desc = "DAP Step Into" })
map("n", "<F12>", function()
  require("dap").step_out()
end, { desc = "DAP Step Out" })
map("n", "<leader>dbg", function()
  require("dap-go").debug_test()
end, { desc = "Debug Go Test" })

-- Java scratch helper: single-file / simple package only (prefer jdtls / build tool for real projects)
map("n", "<leader>rj", function()
  if vim.bo.filetype ~= "java" then
    vim.notify("Not a Java buffer", vim.log.levels.WARN)
    return
  end
  local path = vim.api.nvim_buf_get_name(0)
  if path == "" then
    vim.notify("Save the file first", vim.log.levels.WARN)
    return
  end
  local dir = vim.fn.fnamemodify(path, ":h")
  local base = vim.fn.fnamemodify(path, ":t:r")
  local lines = vim.api.nvim_buf_get_lines(0, 0, 30, false)
  local pkg
  for _, line in ipairs(lines) do
    pkg = line:match("^%s*package%s+([%w%.]+)%s*;")
    if pkg then
      break
    end
  end
  local classname = pkg and (pkg .. "." .. base) or base
  -- shellescape avoids quote breakage; still a scratch helper, not a full build
  local cmd = string.format(
    "javac %s && java %s",
    vim.fn.shellescape(base .. ".java"),
    vim.fn.shellescape(classname)
  )
  vim.cmd("TermExec dir=" .. vim.fn.shellescape(dir) .. " cmd=" .. vim.fn.shellescape(cmd))
end, { desc = "Run Java File (scratch)" })

-- ToggleTerm (avoid <leader>tt: Java extra uses it for Run All Test)
map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Terminal (horizontal)" })
map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical size=60<CR>", { desc = "Terminal (vertical)" })
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Terminal (float)" })
map("t", "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Terminal normal mode" })
