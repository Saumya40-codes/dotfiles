local function find_command()
  if vim.fn.executable("fd") == 1 then
    return { "fd", "--type", "f", "--hidden", "--follow", "--exclude", ".git" }
  end
  if vim.fn.executable("fdfind") == 1 then
    return { "fdfind", "--type", "f", "--hidden", "--follow", "--exclude", ".git" }
  end
  return nil
end

local find_files = { hidden = true }
local cmd = find_command()
if cmd then
  find_files.find_command = cmd
end

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
        find_files = find_files,
      },
    },
  },
}
