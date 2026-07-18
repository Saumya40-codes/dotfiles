return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff = {
          mason = false,
          cmd = { "ruff", "server" },
        },
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      automatic_installation = false,
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      local adapter = vim.fn.exepath("debugpy-adapter")
      if adapter == "" then
        adapter = "debugpy-adapter"
      end
      require("dap-python").setup(adapter)
    end,
  },
}
