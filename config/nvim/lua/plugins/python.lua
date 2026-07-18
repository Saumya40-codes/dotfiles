-- Python tooling without relying on Mason venv installs.
--
-- Verified from ~/.local/state/nvim/mason.log (2026-07-18):
--   Installation failed for Package(name=ruff) error=spawn: python3 failed ...
--   Installation failed for Package(name=debugpy) error=spawn: python3 failed ...
-- Reproduced installer stdout:
--   "ensurepip is not available ... apt install python3.12-venv"
--
-- Workarounds (no sudo):
--   uv tool install ruff
--   uv tool install debugpy   # provides debugpy + debugpy-adapter
-- Both land in ~/.local/bin (on PATH).

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff = {
          -- Do not let mason-lspconfig try (and fail) to pip/venv-install ruff.
          mason = false,
          -- Explicit cmd so we use the uv-installed binary.
          cmd = { "ruff", "server" },
        },
      },
    },
  },
  -- Prevent mason-nvim-dap from auto-installing debugpy via broken python venv path.
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      automatic_installation = false,
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      -- Prefer uv tool binary; fall back to bare name on PATH.
      local adapter = vim.fn.exepath("debugpy-adapter")
      if adapter == "" then
        adapter = "debugpy-adapter"
      end
      require("dap-python").setup(adapter)
    end,
  },
}
