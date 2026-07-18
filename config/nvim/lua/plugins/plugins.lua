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

  -- Statusline: LazyVim defaults (theme = "auto"). Do not set theme = "catppuccin"
  -- (not a valid lualine theme name; triggers :LualineNotices).

  -- WakaTime coding stats
  { "wakatime/vim-wakatime", lazy = false },

  -- Floating / split terminal
  -- Keys avoid <leader>tt (LazyVim lang.java uses that for "Run All Test")
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
      { "<leader>th", desc = "Terminal (horizontal)" },
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

  -- Do NOT override nvim-dap config: LazyVim dap.core owns setup (mason-dap, signs, UI).
  -- Only add the Go adapter + telescope-dap extension.
  {
    "leoluz/nvim-dap-go",
    opts = {},
  },
  {
    "nvim-telescope/telescope-dap.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap" },
    config = function()
      pcall(require("telescope").load_extension, "dap")
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
