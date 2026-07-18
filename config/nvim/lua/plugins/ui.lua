return {
  {
    "folke/snacks.nvim",
    opts = {
      notifier = {
        filter = function(notif)
          local msg = notif.msg or ""
          local title = notif.title or ""
          local blob = (title .. " " .. msg):lower()

          if blob:find("mason", 1, true) then
            if blob:find("successfully installed", 1, true)
              or blob:find("successfully uninstalled", 1, true)
              or blob:find("installing ", 1, true)
              or blob:find("automatically installing", 1, true)
              or blob:find("failed to install ruff", 1, true)
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
