return {
  {
    "OXY2DEV/markview.nvim",
    lazy = false, -- markview lazy-loads itself; its docs say not to lazy load it
    keys = {
      { "<leader>um", "<cmd>Markview Toggle<cr>", desc = "Toggle Markview" },
    },
    opts = {
      preview = {
        -- show the raw source on the cursor line in normal mode (like render-markdown's anti-conceal)
        hybrid_modes = { "n" },
        -- redraw right after a cursor move instead of waiting 150ms (the default)
        debounce = 0,
        -- buffers up to this size are re-parsed whole on every redraw (~50ms at 1000 lines);
        -- longer ones only around the window (~10ms), so keep the whole-buffer path small
        max_buf_lines = 200,
      },
    },
    config = function(_, opts)
      require("markview").setup(opts)
      -- markview redraws after a cursor move on a timer, so nvim first draws a frame where the
      -- cursor line is already unconcealed but still decorated (the text jumps right, then
      -- redraws). Redraw inside CursorMoved instead, as markview already does for big jumps.
      local autocmds = require("markview.autocmds")
      local use_delay = autocmds.use_delay
      if type(use_delay) == "function" then
        autocmds.use_delay = function(buf, event, args)
          local delay, ignore = use_delay(buf, event, args)
          return delay and event ~= "CursorMoved", ignore
        end
      end
    end,
  },
}
