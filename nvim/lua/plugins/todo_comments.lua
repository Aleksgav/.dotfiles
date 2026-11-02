return {
  "folke/todo-comments.nvim",
  optional = true,
  -- stylua: ignore
  keys = {
    { "<leader>st", function() require("todo-comments.fzf").todo() end, desc = "Todo" },
    { "<leader>sT", function () require("todo-comments.fzf").todo({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
  },
  opts = {
    -- extra keywords (merged with the built-in FIX/TODO/HACK/WARN/PERF/NOTE/TEST)
    keywords = {
      QUESTION = { icon = "\u{f059} ", color = "info", alt = { "Q" } },
      IDEA = { icon = "\u{f0eb} ", color = "hint" },
      IMPORTANT = { icon = "\u{f06a} ", color = "error", alt = { "IMP" } },
      DONE = { icon = "\u{f00c} ", color = "default" },
      EXAMPLE = { icon = "\u{f02d} ", color = "#29a197", alt = { "EXAMPLES" } },
    },
  },
  config = function(_, opts)
    require("todo-comments").setup(opts)
    -- keywords are only colored inside comments, and markdown has none. In markdown, treat a line
    -- as a comment when it holds a keyword itself, so the multiline continuation doesn't color
    -- the rest of the paragraph below a `FIXME:` line.
    local hl = require("todo-comments.highlight")
    local is_comment = hl.is_comment
    hl.is_comment = function(buf, row, col)
      if vim.bo[buf].filetype == "markdown" then
        local line = vim.api.nvim_buf_get_lines(buf, row, row + 1, false)[1] or ""
        return hl.match(line) ~= nil
      end
      return is_comment(buf, row, col)
    end
  end,
}
