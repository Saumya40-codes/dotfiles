return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        prompt_prefix = "   ",
        selection_caret = " ❯ ",
        path_display = { "smart" },
        file_ignore_patterns = {
          "node_modules",
          "%.git/",
          "go%.sum",
          "%.lock",
          "%.min%.js",
          "target/",
          "dist/",
          "build/",
          "%.class",
        },
        layout_config = {
          horizontal = { preview_width = 0.55 },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          find_command = { "fd", "--type", "f", "--hidden", "--follow", "--exclude", ".git" },
        },
      },
    },
  },
}
