-- Options are automatically loaded before lazy.nvim startup
-- Default options: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local opt = vim.opt

-- Editing
opt.relativenumber = true
opt.number = true
opt.clipboard = "unnamedplus"
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.breakindent = true
opt.undofile = true
opt.swapfile = false
opt.confirm = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split"

-- Indent (project formatters/editorconfig win)
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

-- UI
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.splitright = true
opt.splitbelow = true
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- Performance
opt.updatetime = 200
opt.timeoutlen = 300

-- Go-friendly list of filetypes that prefer tabs (go fmt)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end,
})

-- Prefer treesitter folds when available
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99

-- Leaders (LazyVim defaults, explicit for clarity)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- LazyVim: use snacks picker / explorer as needed; keep telescope via extra
-- Disable animations if you prefer snappier UI
-- vim.g.snacks_animate = false
