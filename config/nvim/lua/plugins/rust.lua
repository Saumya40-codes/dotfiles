return {
  {
    "mrcjkb/rustaceanvim",
    opts = function(_, opts)
      opts.server = opts.server or {}
      opts.server.default_settings = vim.tbl_deep_extend("force", opts.server.default_settings or {}, {
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
          },
          check = {
            command = "clippy",
          },
          inlayHints = {
            bindingModeHints = {
              enable = true,
            },
            closureReturnTypeHints = {
              enable = "with_block",
            },
            lifetimeElisionHints = {
              enable = "skip_trivial",
              useParameterNames = true,
            },
          },
        },
      })

      local existing_on_attach = opts.server.on_attach
      opts.server.on_attach = function(client, bufnr)
        if existing_on_attach then
          existing_on_attach(client, bufnr)
        end

        local map = function(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
        end

        map("<leader>rr", function()
          vim.cmd.RustLsp("runnables")
        end, "Rust Runnables")
        map("<leader>rt", function()
          vim.cmd.RustLsp("testables")
        end, "Rust Testables")
        map("<leader>rd", function()
          vim.cmd.RustLsp("debuggables")
        end, "Rust Debuggables")
        map("<leader>re", function()
          vim.cmd.RustLsp("explainError")
        end, "Rust Explain Error")
        map("<leader>rD", function()
          vim.cmd.RustLsp("openDocs")
        end, "Rust Open Docs")
      end

      return opts
    end,
  },

  {
    "Saecki/crates.nvim",
    opts = function(_, opts)
      opts.completion = vim.tbl_deep_extend("force", opts.completion or {}, {
        crates = {
          enabled = true,
        },
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "toml",
        group = vim.api.nvim_create_augroup("CratesNvimMaps", { clear = true }),
        callback = function(ev)
          if vim.fn.fnamemodify(vim.api.nvim_buf_get_name(ev.buf), ":t") ~= "Cargo.toml" then
            return
          end

          local map = function(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
          end

          map("<leader>ct", function()
            require("crates").toggle()
          end, "Crates Toggle")
          map("<leader>cu", function()
            require("crates").upgrade_crate()
          end, "Crates Upgrade")
          map("<leader>cU", function()
            require("crates").upgrade_all_crates()
          end, "Crates Upgrade All")
          map("<leader>cv", function()
            require("crates").show_versions_popup()
          end, "Crates Versions")
          map("<leader>cf", function()
            require("crates").show_features_popup()
          end, "Crates Features")
        end,
      })

      return opts
    end,
  },
}
