local opt = vim.opt

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

opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split"

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

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

opt.updatetime = 200
opt.timeoutlen = 300

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end,
})

opt.foldlevel = 99
opt.foldlevelstart = 99

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local local_bin = vim.fn.expand("~/.local/bin")
if not vim.env.PATH:find(local_bin, 1, true) then
  vim.env.PATH = local_bin .. ":" .. vim.env.PATH
end
