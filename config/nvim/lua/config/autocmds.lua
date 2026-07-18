-- Autocmds are automatically loaded on the VeryLazy event
-- Defaults already cover yank highlight, close-with-q, and auto-create parent dirs:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

-- Quiet Mason / mason-lspconfig install spam when opening new filetypes.
-- LazyVim auto-installs servers (yamlls, gopls, …) and each success fires a toast.
-- Errors and warnings still pass through.
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    local banned = {
      "successfully installed",
      "successfully uninstalled",
      "[mason-lspconfig.nvim] installing",
      "[mason.nvim] installing",
      "[mason-nvim-dap]",
    }

    ---@diagnostic disable-next-line: duplicate-set-field
    local notify = vim.notify
    vim.notify = function(msg, level, opts)
      if type(msg) == "string" then
        local lvl = level or vim.log.levels.INFO
        if lvl <= vim.log.levels.INFO then
          local lower = msg:lower()
          for _, pat in ipairs(banned) do
            if lower:find(pat:lower(), 1, true) or msg:find(pat, 1, true) then
              return
            end
          end
        end
      end
      return notify(msg, level, opts)
    end
  end,
})
