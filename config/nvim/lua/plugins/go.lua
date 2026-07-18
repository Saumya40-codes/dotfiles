return {
  -- gopls: drop overlapping analyzers so one finding is not shown 2-3 times.
  -- LazyVim lang.go enables both analyses.nilness AND staticcheck (SA4031 etc.),
  -- which report the same nil-check issues. It also wires nvim-lint → golangci-lint,
  -- which often runs staticcheck again.
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- Less end-of-line spam; full detail still in float (:leader>cd) and Trouble.
      diagnostics = {
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- Hints / pure "related info" style noise stay off the line; WARN+ only.
          severity = { min = vim.diagnostic.severity.WARN },
          format = function(diagnostic)
            -- One line only (relatedInformation can make multi-line walls)
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
              -- staticcheck already covers impossible/tautological nil checks (e.g. SA4031)
              analyses = {
                nilness = false,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
                -- often noisy for learning/scratch code:
                shadow = false,
              },
              staticcheck = true,
              -- fewer floating codelenses / inlay chrome in the gutter area of focus
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

  -- Do not also run golangci-lint via nvim-lint: gopls+staticcheck is enough inline.
  -- Use `golangci-lint run` in CI/terminal when you want the full suite.
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.go = {} -- empty = no extra linters for Go
      return opts
    end,
  },

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
      -- go.nvim master calls vim.lsp.codelens.enable() which does NOT exist on Neovim 0.11
      lsp_codelens = false,
      dap_debug = true,
      dap_debug_gui = false,
      dap_debug_keymap = false,
      trouble = true,
      luasnip = false,
    },
    config = function(_, opts)
      require("go").setup(opts)

      -- Safe codelens for Neovim 0.11 (go.nvim uses enable() which is 0.12+)
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
