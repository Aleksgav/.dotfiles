-- Ctrl+Shift+h/j/k/l moves across nvim splits and zellij panes.
-- zellij side: zellij-autolock locks zellij while nvim is focused, and
-- config.kdl binds the same keys to MoveFocus/MoveFocusOrTab for other panes.
return {
  {
    "smart-splits-nvim/smart-splits.nvim",
    version = "^3.0.0",
    lazy = false,
    dependencies = {
      {
        "smart-splits-nvim/backend-zellij-lua",
        main = "smart-splits-backend-zellij-lua",
        -- at the nvim edge, left/right use move-focus-or-tab (like zellij's Alt h/l)
        opts = { move_cursor = { pane_or_tab = true } },
      },
    },
    opts = { mux = { backend = "smart-splits-backend-zellij-lua" } },
    keys = {
      { "<C-S-h>", function() require("smart-splits").move_cursor_left() end, desc = "Split/pane left" },
      { "<C-S-j>", function() require("smart-splits").move_cursor_down() end, desc = "Split/pane down" },
      { "<C-S-k>", function() require("smart-splits").move_cursor_up() end, desc = "Split/pane up" },
      { "<C-S-l>", function() require("smart-splits").move_cursor_right() end, desc = "Split/pane right" },
    },
  },
}
