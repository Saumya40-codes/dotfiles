-- UI tweaks (snacks notifier filter, etc.)
--
-- Evidence: mason-lspconfig / mason call vim.notify for every install. LazyVim uses
-- snacks.notifier as the real UI; filtering must use snacks.notifier.filter, not a
-- pre-VeryLazy vim.notify wrap (that wrap gets replaced).

return {
  {
    "folke/snacks.nvim",
    opts = {
      notifier = {
        ---@param notif snacks.notifier.Notif
        filter = function(notif)
          local msg = notif.msg or ""
          local title = notif.title or ""
          local blob = (title .. " " .. msg):lower()

          -- Install noise from mason ecosystem
          if blob:find("mason", 1, true) then
            if blob:find("successfully installed", 1, true)
              or blob:find("successfully uninstalled", 1, true)
              or blob:find("installing ", 1, true)
              or blob:find("automatically installing", 1, true)
            then
              return false
            end
            -- Hide the known broken python-venv installs until python3-venv is present.
            -- Root cause (from :MasonLog / mason.log): ensurepip missing on Ubuntu.
            if blob:find("failed to install ruff", 1, true)
              or blob:find("failed to install debugpy", 1, true)
            then
              return false
            end
          end
          return true
        end,
      },
    },
  },
}
