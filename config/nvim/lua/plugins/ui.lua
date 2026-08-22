return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>lg",
        function()
          require("snacks").lazygit()
        end,
        desc = "Lazygit (float)",
      },
    },
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
