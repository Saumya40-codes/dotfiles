return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "go", "gomod", "gosum", "gowork" },
    build = ':lua require("go.install").update_all_sync()',
    opts = {
      go = "go",
      goimports = "gopls",
      fillstruct = "gopls",
      gofmt = "gofumpt",
      tag_transform = false,
      lsp_gofumpt = true,
      lsp_inlay_hints = { enable = true },
      dap_debug = true,
      dap_debug_gui = true,
      trouble = true,
      luasnip = true,
    },
    config = function(_, opts)
      require("go").setup(opts)

      local map = vim.keymap.set
      map("n", "<leader>gt", "<cmd>GoTest<CR>", { silent = true, desc = "Go Test" })
      map("n", "<leader>gT", "<cmd>GoTestFunc<CR>", { silent = true, desc = "Go Test Func" })
      map("n", "<leader>gi", "<cmd>GoImports<CR>", { silent = true, desc = "Go Imports" })
      map("n", "<leader>gf", "<cmd>GoFormat<CR>", { silent = true, desc = "Go Format" })
      map("n", "<leader>gr", "<cmd>GoRun<CR>", { silent = true, desc = "Go Run" })
      map("n", "<leader>gc", "<cmd>GoCoverage<CR>", { silent = true, desc = "Go Coverage" })
      map("n", "<leader>gie", "<cmd>GoIfErr<CR>", { silent = true, desc = "Go If Err" })
    end,
  },
}
