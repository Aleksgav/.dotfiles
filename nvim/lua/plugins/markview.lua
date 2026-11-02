-- markdown-only note colors (solarized palette). A color per heading level, like org-level-N
-- (otherwise every level falls back to `Title`); markview builds its heading colors from these.
local highlights = {
  ["@markup.heading.1.markdown"] = { fg = "#ede7d3", bold = true },
  ["@markup.heading.2.markdown"] = { fg = "#6d71c4", bold = true },
  ["@markup.heading.3.markdown"] = { fg = "#268bd3", bold = true },
  ["@markup.heading.4.markdown"] = { fg = "#29a298", bold = true },
  ["@markup.heading.5.markdown"] = { fg = "#849900", bold = true },
  ["@markup.heading.6.markdown"] = { fg = "#b28500", bold = true },
  ["@markup.strong.markdown_inline"] = { fg = "#c94c16", bold = true },
  ["@markup.italic.markdown_inline"] = { fg = "#7f84db", italic = true },
  ["@markup.strikethrough.markdown_inline"] = { fg = "#576d74", strikethrough = true }, -- dimmed, like done items
  ["@markup.underline.markdown_inline"] = { fg = "#a3cc00", underline = true }, -- <u>…</u>, see `html` below
}

return {
  {
    "OXY2DEV/markview.nvim",
    lazy = false, -- markview lazy-loads itself; its docs say not to lazy load it
    -- registered here, before markview's own ColorScheme autocmd, so the groups are set before
    -- markview re-reads them
    init = function()
      local function apply()
        for name, hl in pairs(highlights) do
          vim.api.nvim_set_hl(0, name, hl)
        end
      end
      -- a theme load runs `hi clear`, so re-apply after every colorscheme change
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("markview_markdown_highlights", { clear = true }),
        callback = apply,
      })
      apply()
    end,
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
      markdown = {
        headings = {
          -- org-bullets style icons (colors come from @markup.heading.N.markdown, set at the top of this file)
          heading_1 = { icon = "◉ " },
          heading_2 = { icon = "○ " },
          heading_3 = { icon = "✸ " },
          heading_4 = { icon = "✿ " },
          heading_5 = { icon = "◆ " },
          heading_6 = { icon = "◇ " },
          shift_width = 2, -- heading indent per level
          -- indent section bodies under their heading, like org-indent-mode
          org_indent = true,
          org_shift_width = 2,
        },
      },
      markdown_inline = {
        -- ==text== as a yellow highlighter (the default palette 3 is the blue heading-3 color)
        highlights = { default = { hl = "MarkviewPalette6" } },
      },
      html = {
        -- <u>…</u> uses `Underlined` by default, which also colors URLs; give it its own group
        container_elements = { ["^u$"] = { on_node = { hl_group = "@markup.underline.markdown_inline" } } },
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
