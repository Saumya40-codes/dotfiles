-- Custom plugins & LazyVim overrides
return {
  -- Colorscheme: Catppuccin Mocha (drives LazyVim + lualine)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = false,
      integrations = {
        treesitter = true,
        native_lsp = { enabled = true },
        telescope = true,
        cmp = true,
        blink_cmp = true,
        gitsigns = true,
        mason = true,
        which_key = true,
        dap = true,
        dap_ui = true,
        snacks = true,
        flash = true,
        neotree = true,
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  -- Statusline theme
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options = opts.options or {}
      opts.options.theme = "catppuccin"
      return opts
    end,
  },

  -- WakaTime coding stats
  { "wakatime/vim-wakatime", lazy = false },

  -- Floating / split terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
      { "<leader>tt", desc = "Terminal (horizontal)" },
      { "<leader>tv", desc = "Terminal (vertical)" },
      { "<leader>tf", desc = "Terminal (float)" },
    },
    opts = {
      open_mapping = [[<c-\>]],
      direction = "horizontal",
      shade_terminals = true,
      start_in_insert = true,
    },
  },

  -- DAP UI + Go adapter (dap.core extra provides nvim-dap base)
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "leoluz/nvim-dap-go",
      "nvim-neotest/nvim-nio",
      {
        "nvim-telescope/telescope-dap.nvim",
        config = function()
          pcall(require("telescope").load_extension, "dap")
        end,
      },
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()
      require("dap-go").setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  -- Optional Copilot (uncomment when needed)
  -- {
  --   "zbirenbaum/copilot.lua",
  --   event = "InsertEnter",
  --   opts = {
  --     suggestion = {
  --       enabled = true,
  --       auto_trigger = true,
  --       keymap = {
  --         accept = "<Tab>",
  --         next = "<M-]>",
  --         prev = "<M-[>",
  --         dismiss = "<C-]>",
  --       },
  --     },
  --     panel = { enabled = false },
  --   },
  -- },
}
