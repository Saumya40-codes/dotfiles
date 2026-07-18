return {
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

  { "wakatime/vim-wakatime", lazy = false },

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
}
