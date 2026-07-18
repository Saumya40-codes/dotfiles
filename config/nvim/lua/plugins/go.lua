return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          severity = { min = vim.diagnostic.severity.WARN },
          format = function(diagnostic)
            local msg = diagnostic.message or ""
            msg = msg:gsub("\n.*", "")
            if #msg > 120 then
              msg = msg:sub(1, 117) .. "..."
            end
            return msg
          end,
        },
        severity_sort = true,
        float = {
          source = true,
          border = "rounded",
          header = "",
          prefix = "",
        },
      },
      servers = {
        gopls = {
          settings = {
            gopls = {
              analyses = {
                nilness = false,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
                shadow = false,
              },
              staticcheck = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = false,
                run_govulncheck = false,
                test = true,
                tidy = true,
                upgrade_dependency = false,
                vendor = false,
              },
              hints = {
                assignVariableTypes = false,
                compositeLiteralFields = true,
                compositeLiteralTypes = false,
                constantValues = true,
                functionTypeParameters = false,
                parameterNames = true,
                rangeVariableTypes = false,
              },
            },
          },
        },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.go = {}
      return opts
    end,
  },

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
      lsp_cfg = false,
      lsp_gofumpt = true,
      lsp_inlay_hints = { enable = true },
      lsp_codelens = false,
      dap_debug = true,
      dap_debug_gui = false,
      dap_debug_keymap = false,
      trouble = true,
      luasnip = false,
    },
    config = function(_, opts)
      require("go").setup(opts)

      if vim.lsp.codelens and type(vim.lsp.codelens.refresh) == "function" and type(vim.lsp.codelens.enable) ~= "function" then
        vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave", "BufWritePost" }, {
          group = vim.api.nvim_create_augroup("GoCodeLensNvim011", { clear = true }),
          pattern = { "*.go", "go.mod" },
          callback = function(ev)
            local clients = vim.lsp.get_clients({ bufnr = ev.buf, name = "gopls" })
            if #clients > 0 then
              pcall(vim.lsp.codelens.refresh, { bufnr = ev.buf })
            end
          end,
        })
      end

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
