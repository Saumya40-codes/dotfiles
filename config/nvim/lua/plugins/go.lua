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
      -- lang.go extra starts gopls via LazyVim/mason; keep go.nvim LSP off to avoid double gopls
      lsp_cfg = false,
      lsp_gofumpt = true,
      lsp_inlay_hints = { enable = true },
      dap_debug = true,
      -- LazyVim dap.core owns UI + keymaps; do not let go.nvim install temporary single-key maps
      dap_debug_gui = false,
      dap_debug_keymap = false,
      trouble = true,
      luasnip = false, -- stack uses blink.cmp, not LuaSnip
    },
    config = function(_, opts)
      require("go").setup(opts)

      -- Buffer-local maps under <leader>go* so we never shadow LazyVim git keys
      -- (<leader>gf file history, <leader>gc commits, etc.)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "go", "gomod" },
        group = vim.api.nvim_create_augroup("GoNvimMaps", { clear = true }),
        callback = function(ev)
          local map = function(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
          end
          map("<leader>got", "<cmd>GoTest<CR>", "Go Test")
          map("<leader>goT", "<cmd>GoTestFunc<CR>", "Go Test Func")
          map("<leader>goi", "<cmd>GoImports<CR>", "Go Imports")
          map("<leader>gof", "<cmd>GoFormat<CR>", "Go Format")
          map("<leader>gor", "<cmd>GoRun<CR>", "Go Run")
          map("<leader>goc", "<cmd>GoCoverage<CR>", "Go Coverage")
          map("<leader>goe", "<cmd>GoIfErr<CR>", "Go If Err")
        end,
      })
    end,
  },
}
