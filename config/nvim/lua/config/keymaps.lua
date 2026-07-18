-- Keymaps are automatically loaded on the VeryLazy event
-- Defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = vim.keymap.set

-- Telescope (also available via LazyVim; kept for muscle memory)
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Live grep (words)" })
map("n", "<leader>fv", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })

-- Better window navigation (when not using LazyVim defaults)
map("n", "<C-h>", "<C-w>h", { desc = "Go left" })
map("n", "<C-j>", "<C-w>j", { desc = "Go down" })
map("n", "<C-k>", "<C-w>k", { desc = "Go up" })
map("n", "<C-l>", "<C-w>l", { desc = "Go right" })

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search" })

-- Move lines in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move up" })

-- Keep cursor centered when scrolling / searching
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- DAP (avoid <leader>b - LazyVim uses it for buffers)
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
map("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })
map("n", "<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Conditional Breakpoint" })
map("n", "<leader>du", function()
  require("dapui").toggle()
end, { desc = "Toggle DAP UI" })
map("n", "<leader>dbg", function()
  require("dap-go").debug_test()
end, { desc = "Debug Go Test" })

-- Java: compile + run current file in toggleterm
map("n", "<leader>rj", function()
  local file = vim.fn.expand("%:t:r")
  local dir = vim.fn.expand("%:p:h")
  local compile_cmd = "javac " .. file .. ".java"
  local run_cmd = "java " .. file
  vim.cmd("TermExec dir='" .. dir .. "' cmd='" .. compile_cmd .. " && " .. run_cmd .. "'")
end, { desc = "Run Java File" })

-- Toggleterm
map("n", "<leader>tt", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Terminal (horizontal)" })
map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical size=60<CR>", { desc = "Terminal (vertical)" })
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Terminal (float)" })
map("t", "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Terminal normal mode" })
